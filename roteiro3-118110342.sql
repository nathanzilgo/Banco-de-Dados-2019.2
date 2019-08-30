

CREATE TABLE farmacia (
    id          BIGINT UNIQUE PRIMARY KEY,
    nome        TEXT NOT NULL,
    sede        BOOLEAN,
    rua         TEXT NOT NULL,
    bairro      TEXT NOT NULL UNIQUE,
    numero      INTEGER
    gerenteCpf  VARCHAR(11) NOT NULL,

    
);

CREATE TABLE funcionario (
    nome        TEXT NOT NULL,
    cpf         CHAR(11) PRIMARY KEY,
    cargo       VARCHAR(20),
    farmaciaId  BIGINT REFERENCES farmacia(id),
    vendas      SERIAL REFERENCES venda(funcionarioCpf) ON DELETE RESTRICT,

    CONSTRAINT cargos CHECK (cargo IN ( 'farmaceutico', 'vendedor', 'entregador',
    'caixa', 'administrador', 'gerente', null))
    
);

CREATE TABLE medicamento (
    id          SERIAL  PRIMARY KEY,
    nome        TEXT NOT NULL,
    receita     BOOLEAN,
    bula        TEXT,
    fabricante  TEXT,
    
);

CREATE TABLE cliente (
    nome        TEXT NOT NULL,
    cpf         CHAR(11) NOT NULL,
    enderecos   REFERENCES enderecosCliente(cpfCliente),
    nascimento  DATE NOT NULL

    CONSTRAINT maioridade CHECK(AGE(timestamp nascimento, timestamp current_date) >= 18);

);

CREATE TABLE enderecosCliente (
    id          CHAR(11) REFERENCES cliente(cpf),
    tipo        TEXT NOT NULL,
    rua         TEXT NOT NULL,
    bairro      TEXT NOT NULL,
    cep         BIGINT NOT NULL,
    numero      INTEGER NOT NULL

    CONSTRAINT tipos CHECK(tipo IN ('residencia', 'trabalho', 'outro'));

);

CREATE TABLE venda (
    id              SERIAL NOT NULL,
    funcionarioCpf  CHAR(11) REFERENCES funcionario(cpf) NOT NULL,
    clienteCpf      CHAR(11) REFERENCES cliente(cpf),
    clienteEnd      CHAR(11) REFERENCES enderecosCliente(id),
    medId           SERIAL REFERENCES medicamento(id)

    CONSTRAINT clienteOuNao CHECK(clienteCpf = NULL && clienteEnd = NULL || clienteCpf != NULL && clienteEnd != NULL);
);

CREATE TABLE entrega (
    clienteCpf  CHAR(11) REFERENCES cliente(cpf),
    medId       SERIAL REFERENCES medicamento(id),
    clienteEnd  CHAR(11) REFERENCES enderecosCliente(id)
);