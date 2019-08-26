

CREATE TABLE farmacia {
    id          BIGINT UNIQUE,
    nome        TEXT,
    sede        BOOLEAN,
    endereco    TEXT,
    gerenteCpf  VARCHAR(11)

};

CREATE TABLE funcionario {
    nome        TEXT NOT NULL,
    cpf         CHAR(11) PRIMARY KEY,
    cargo       VARCHAR(20),
    farmaciaId  BIGINT REFERENCES farmacia(id),

    CONSTRAINT cargos CHECK (cargo IN ( 'farmaceutico', 'vendedor', 'entregador',
    'caixa', 'administrador', 'gerente', null))
    
};

CREATE TABLE medicamento {
    id          SERIAL  PRIMARY KEY,
    nome        TEXT,
    receita     BOOLEAN,
    bula        TEXT,
    fabricante  TEXT
};

CREATE TABLE cliente {
    nome        TEXT NOT NULL,
    cpf         CHAR(11) NOT NULL,
    enderecos   FOREIGN KEY REFERENCES enderecos(cpfCliente)

}

CREATE TABLE enderecos {
    cpfCliente  CHAR(11) FOREIGN KEY REFERENCES cliente(cpf),
    rua TEXT NOT NULL,
    bairro TEXT NOT NULL,
    cep BIGINT NOT NULL,
    numero INTEGER NOT NULL

}