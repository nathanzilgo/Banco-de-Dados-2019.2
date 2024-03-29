-- Banco de Dados 2019.2 - ROTEIRO 3
-- Professor: Cláudio Campelo
-- Aluno: Nathan Fernandes

CREATE TYPE estadoPB as ENUM('paraiba', 'bahia', 'alagoas', 'pernambuco', 'sergipe', 'ceara', 'rio grande do norte', 'piaui', 'maranhao');

CREATE TABLE farmacia (
    id          BIGINT UNIQUE PRIMARY KEY,
    nome        TEXT NOT NULL,
    tipo        TEXT NOT NULL,
    rua         TEXT NOT NULL,
    bairro      TEXT NOT NULL UNIQUE,
    numero      INTEGER,
    estado      estadoPB,
    gerenteCpf  VARCHAR(11) NOT NULL UNIQUE,
    

    EXCLUDE USING gist (tipo WITH =) WHERE (tipo = 'sede')
);

CREATE TYPE cargoType AS ENUM('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador');

CREATE TABLE funcionario (
    nome        TEXT NOT NULL,
    cpf         CHAR(11) PRIMARY KEY,
    cargo       cargoType,
    isGerente   BOOLEAN,
    farmaciaId  BIGINT NOT NULL,

    CONSTRAINT gerente CHECK (isGerente = TRUE AND cargo IN('administrador', 'farmaceutico') OR isGerente = FALSE)
);

ALTER TABLE funcionario ADD FOREIGN KEY (farmaciaId) REFERENCES farmacia(id);

CREATE TABLE medicamento (
    id          BIGINT PRIMARY KEY,
    nome        TEXT NOT NULL,
    receita     BOOLEAN NOT NULL,
    fabricante  TEXT
    
);


CREATE TABLE cliente (
    cpf         CHAR(11) PRIMARY KEY,
    nome        TEXT NOT NULL,
    nascimento  DATE NOT NULL,

    CONSTRAINT maioridade CHECK(EXTRACT(YEAR FROM AGE(nascimento)) > 17)
);

CREATE TABLE enderecosCliente (
    id          CHAR(11) REFERENCES cliente(cpf),
    tipo        TEXT NOT NULL,
    rua         TEXT NOT NULL,
    bairro      TEXT NOT NULL,
    cep         BIGINT NOT NULL,
    numero      INTEGER NOT NULL

    CONSTRAINT tipos CHECK(tipo IN ('residencia', 'trabalho', 'outro'))
);

ALTER TABLE enderecosCliente ADD PRIMARY KEY(id);

CREATE TABLE venda (
    id                  BIGINT PRIMARY KEY,
    funcionarioCpf      CHAR(11) REFERENCES funcionario(cpf) NOT NULL,
    funcionarioCargo    cargoType NOT NULL,
    clienteCpf          CHAR(11) REFERENCES cliente(cpf) ON DELETE RESTRICT,
    clienteTemEnd       BOOLEAN NOT NULL,
    medId               BIGINT REFERENCES medicamento(id) ON DELETE RESTRICT,
    medReceita          BOOLEAN NOT NULL,

    CONSTRAINT clienteOuNao CHECK(clienteCpf = NULL AND clienteTemEnd = FALSE OR clienteCpf != NULL AND clienteTemEnd = TRUE),
    CONSTRAINT receitaReq   CHECK(medReceita = TRUE AND clienteCpf != NULL OR medReceita = FALSE),
    CONSTRAINT funcionario  CHECK(funcionarioCargo = 'vendedor')
    
);

CREATE TABLE entrega (
    clienteCpf      CHAR(11) REFERENCES cliente(cpf),
    medId           BIGINT REFERENCES medicamento(id),
    clienteTemEnd   BOOLEAN NOT NULL,

    CONSTRAINT clienteTemEndereco CHECK(clienteTemEnd = TRUE)
);

ALTER TABLE farmacia ADD CONSTRAINT tipos CHECK(tipo IN ('sede', 'filial'));

-- TESTES:

-- Deve funcionar:
INSERT INTO farmacia VALUES(0, 'farmacia dias', 'filial', 'alguma rua', 'algum bairro', 
158, 'paraiba', '56734523410');
INSERT INTO funcionario VALUES('alfredo', '12345678923', 'vendedor', FALSE, 0);
INSERT INTO funcionario VALUES('Patricia', '12345678543', 'administrador', TRUE, 0);

INSERT INTO farmacia VALUES(1, 'drogasil', 'sede', 'jose de alguma coisa', 'centro', 
451, 'paraiba', '32345678543');

INSERT INTO funcionario VALUES('Jorge', '32345678543', 'farmaceutico', TRUE, 1);

INSERT INTO medicamento VALUES(1, 'alprazolam', TRUE, 'ems');
INSERT INTO medicamento VALUES(30, 'neosoro', FALSE, 'n sei');

INSERT INTO cliente VALUES('54612345678', 'JOAO', '2000-08-22');
INSERT INTO cliente VALUES('54612345666', 'Matheus', '1999-02-20');

INSERT INTO venda VALUES(1, '32345678543', 'vendedor', '54612345678', FALSE, 30, FALSE);
INSERT INTO venda VALUES(2, '12345678923', 'vendedor', '54612345666', FALSE, 30, TRUE);

-- Deve dar erro:
INSERT INTO farmacia VALUES(0, 'redefarma' , 'sede' , 'alguma rua2', 'algum bairro',
300, 'bahia', '45678912345');
INSERT INTO cliente VALUES('54612345679', 'Antonio', '2004-08-22');
INSERT INTO cliente VALUES('54612345678', 'Maria', '2000-08-22');
DELETE FROM medicamento WHERE id = 30;
INSERT INTO entrega VALUES('54612345678', 1, FALSE);