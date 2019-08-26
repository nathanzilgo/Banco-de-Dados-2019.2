

CREATE TABLE farmacia {
    id BIGINT UNIQUE,
    sede BOOLEAN,
    endereco TEXT,
    gerenteCpf VARCHAR(11)

};

CREATE TABLE funcionario {
    nome TEXT NOT NULL,
    cpf VARCHAR(11) PRIMARY KEY,
    cargo VARCHAR(20),
    farmaciaId BIGINT REFERENCES farmacia(id),

    CONSTRAINT cargos CHECK (cargo IN ( 'farmaceutico', 'vendedor', 'entregador',
    'caixa', 'administrador', 'gerente'))
    
};

CREATE TABLE medicamento {
    nome TEXT,
    requerReceita BOOLEAN,

};