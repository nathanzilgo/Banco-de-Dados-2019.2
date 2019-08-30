CREATE TYPE estadoPB as ENUM('paraiba', 'bahia', 'alagoas', 'pernambuco', 'sergipe', 'ceara', 'rio grande do norte', 'piaui', 'maranhao');

CREATE TABLE farmacia (
    id          BIGINT UNIQUE PRIMARY KEY,
    nome        TEXT NOT NULL,
    tipo        TEXT NOT NULL,
    rua         TEXT NOT NULL,
    bairro      TEXT NOT NULL UNIQUE,
    numero      INTEGER,
    estado      estadoPB,
    gerenteCpf  VARCHAR(11) NOT NULL,
    

    EXCLUDE USING gist (tipo WITH =) WHERE (tipo = 'sede')
);

CREATE TYPE cargoType AS ENUM('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador');

CREATE TABLE funcionario (
    nome        TEXT NOT NULL,
    cpf         CHAR(11) PRIMARY KEY,
    cargo       cargoType,
    isGerente   BOOLEAN,
    farmaciaId  BIGINT,
    vendas      SERIAL,

    CONSTRAINT gerente CHECK (isGerente = TRUE AND cargo IN('administrador', 'entregador') OR isGerente = FALSE)
);

ALTER TABLE farmacia ADD FOREIGN KEY (gerenteCpf) REFERENCES funcionario(cpf);
ALTER TABLE funcionario ADD FOREIGN KEY (farmaciaId) REFERENCES farmacia(id);

CREATE TABLE medicamento (
    id          SERIAL  PRIMARY KEY,
    nome        TEXT NOT NULL,
    receita     BOOLEAN NOT NULL,
    bula        TEXT,
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

CREATE TABLE venda (
    id                  SERIAL NOT NULL,
    funcionarioCpf      CHAR(11) REFERENCES funcionario(cpf) NOT NULL,
    funcionarioCargo    cargoType NOT NULL,
    clienteCpf          CHAR(11) REFERENCES cliente(cpf),
    clienteEnd          CHAR(11) REFERENCES enderecosCliente(id),
    medId               SERIAL REFERENCES medicamento(id),
    medReceita          BOOLEAN NOT NULL,

    CONSTRAINT clienteOuNao CHECK(clienteCpf = NULL AND clienteEnd = NULL OR clienteCpf != NULL AND clienteEnd != NULL),
    CONSTRAINT receitaReq   CHECK(medReceita = TRUE AND clienteCpf != NULL OR medReceita = FALSE),
    CONSTRAINT funcionario  CHECK(funcionarioCargo = 'vendedor')
);

ALTER TABLE funcionario ADD FOREIGN KEY (vendas) REFERENCES venda(funcionarioCpf) ON DELETE RESTRICT;
ALTER TABLE medicamento ADD FOREIGN KEY (id) REFERENCES venda(medId) ON DELETE RESTRICT;

CREATE TABLE entrega (
    clienteCpf  CHAR(11) REFERENCES cliente(cpf),
    medId       SERIAL REFERENCES medicamento(id),
    clienteEnd  CHAR(11) REFERENCES enderecosCliente(id)
);