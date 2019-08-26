

CREATE TABLE farmacia {
    id          BIGINT UNIQUE,
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
    nome        TEXT,
    receita     BOOLEAN,

};

CREATE TABLE cliente {
    nome        TEXT,
    cpf         CHAR(11),
    enderecos      
}

CREATE TABLE enderecos {
    cpfCliente  CHAR(11) REFERENCES cliente(cpf),
    endereco1   TEXT,
    
}