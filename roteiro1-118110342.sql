
--Um automovel deve obrigatoriamente ter uma placa, modelo, fabricante e segurado.
CREATE TABLE AUTOMOVEL (
	placa varchar(7) PRIMARY KEY,
	modelo char(20),
	fabricante char(40),
	segurado varchar(40),
	oficina varchar(40)
);


ALTER TABLE automovel ALTER COLUMN modelo SET NOT NULL;
ALTER TABLE automovel ALTER COLUMN fabricante SET NOT NULL;
ALTER TABLE automovel ALTER COLUMN segurado SET NOT NULL;
ALTER TABLE automovel DROP COLUMN oficina;

-- Um segurado deve obrigatoriamente ter um nome, cpf, cnh, endereco, idade(nascimento) e telefone.
CREATE TABLE SEGURADO (
	nome varchar(50),
	cpf char(11),
	cnh char(11),
	endereco varchar(50),
	nascimento date
	telefone integer
);

ALTER TABLE segurado ADD PRIMARY KEY(cpf);
ALTER TABLE segurado ALTER COLUMN cnh SET NOT NULL;
ALTER TABLE segurado ALTER COLUMN endereco SET NOT NULL;
ALTER TABLE segurado ALTER COLUMN nascimento SET NOT NULL;

CREATE TABLE SINISTRO (
	placa_automovel char(10),
	cpf_perito varchar(11),
	cnpj_oficina varchar(30),
	avarias varchar(200) NOT NULL
);

-- Um sinistro deve ser relacionado com um automovel(placa) e um id unico para registro.
ALTER TABLE sinistro ADD COLUMN id integer;
ALTER TABLE sinistro ADD PRIMARY KEY(id, placa_automovel);

-- Um perito deve obrigatoriamente ter um cpf, nome e telefone.
CREATE TABLE PERITO (
	cpf char(11) PRIMARY KEY,
	nome varchar(100) NOT NULL,
	telefone integer
);

-- Um perito pode mudar de telefone, mas deve sempre ter um telefone
-- Um telefone é melhor representado por varchar.

ALTER TABLE perito DROP COLUMN telefone;
ALTER TABLE perito ADD COLUMN telefone varchar(15) NOT NULL;

-- Uma oficina deve obrigatoriamente ser identificada por um CNPJ. Deve ter nome, endereco
-- e telefone.

CREATE TABLE OFICINA (
	cnpj char(20) PRIMARY KEY,
	nome varchar(40),
	endereco varchar(100),
	telefone integer
);

ALTER TABLE oficina ALTER COLUMN nome SET NOT NULL;
ALTER TABLE oficina ALTER COLUMN endereco SET NOT NULL;
ALTER TABLE oficina DROP COLUMN telefone;
ALTER TABLE oficina ADD COLUMN telefone varchar(15) NOT NULL;

-- Um seguro deve ser relacionado com um veiculo e um segurado.
CREATE TABLE SEGURO (
	cpf_titular varchar(11),
	plano varchar(200),
	data_acionamento date,
	placa_automovel char(7) PRIMARY KEY 
);

-- Cpf do segurado e a data de acionamento do seguro nao podem ser NULL.
ALTER TABLE seguro ALTER COLUMN cpf_titular SET NOT NULL ;
ALTER TABLE seguro ALTER COLUMN data_acionamento SET NOT NULL ;

-- Uma tabela de pericia deve ser relacionada a um perito e um automovel.
CREATE TABLE PERICIA (
	cpf_perito varchar(11) NOT NULL,
	veredito char(200),
	placa_automovel char(7) PRIMARY KEY REFERENCES automovel(placa),
	sinistro char(7)
);

-- Um reparo deve ser associado a um automovel, avarias do sinistro, oficina e segurado.
CREATE TABLE REPARO (
	placa_automovel char(7) PRIMARY KEY REFERENCES automovel(placa),
	custo numeric NOT NULL,
	avarias_sinistro varchar(200) REFERENCES sinistro(avarias),
	oficina_cnpj varchar(20) REFERENCES oficina(cnpj),
	segurado_cpf char(11) REFERENCES segurado(cpf)
);


-- não faz sentido acionar um seguro e sinistro sem ter tido algum tipo de avaria no veiculo
ALTER TABLE sinistro ALTER COLUMN avarias SET NOT NULL;
-- custo_total faz mais sentido ser colocado apenas na tabela REPARO
ALTER TABLE sinistro DROP COLUMN custo_total ;

--************************APAGANDO TUDO**************************
DROP TABLE automovel CASCADE;
DROP TABLE oficina CASCADE;
DROP TABLE pericia CASCADE;
DROP TABLE perito CASCADE;
DROP TABLE segurado CASCADE;
DROP TABLE seguro CASCADE;
DROP TABLE sinistro CASCADE;
DROP TABLE reparo CASCADE;

-- Um segurado deve obrigatoriamente ter um nome, cpf, cnh, endereco, idade(nascimento) e telefone.
CREATE TABLE SEGURADO (
        nome varchar(50) NOT NULL,
        cpf char(11) PRIMARY KEY,
        cnh char(11) NOT NULL,
        endereco varchar(50) NOT NULL,
        nascimento date NOT NULL,
        telefone integer NOT NULL
);

--Um automovel deve obrigatoriamente ter uma placa, modelo, fabricante e segurado.
CREATE TABLE AUTOMOVEL (
        placa varchar(7) PRIMARY KEY,
        modelo char(20) NOT NULL,
        fabricante char(40) NOT NULL,
        segurado varchar(40) REFERENCES segurado(cpf),
        quilometragem numeric

);

-- Um perito deve obrigatoriamente ter um cpf, nome e telefone.
CREATE TABLE PERITO (
        cpf char(11) PRIMARY KEY,
        nome varchar(100) NOT NULL,
        telefone varchar(15) NOT NULL
);


-- Um sinistro deve ser relacionado com um automovel(placa) e um id unico para registro.
-- Decidi nao ser necessario informar a oficina no sinistro

CREATE TABLE SINISTRO (
	id integer,
        placa_automovel char(10),
        cpf_perito varchar(11) REFERENCES perito(cpf),
        avarias varchar(200) NOT NULL,
	PRIMARY KEY(id, placa_automovel)
);

-- Uma oficina deve obrigatoriamente ser identificada por um CNPJ. Deve ter nome, endereco e telefone.

CREATE TABLE OFICINA (
        cnpj char(20) PRIMARY KEY,
        nome varchar(40) NOT NULL,
        endereco varchar(100) NOT NULL,
        telefone varchar(15) NOT NULL
);

-- Um seguro deve ser relacionado com um veiculo e um segurado.
CREATE TABLE SEGURO (
        cpf_segurado varchar(11) REFERENCES segurado(cpf),
        plano varchar(200),
        data_acionamento date NOT NULL,
        placa_automovel char(7) PRIMARY KEY
);

-- Uma tabela de pericia deve ser relacionada a um perito e um automovel.
-- Nao consegui referenciar o sinistro:
-- ERROR:  there is no unique constraint matching given keys for referenced table "sinistro". 
-- Ao tentar usar: sinistro char(7) REFERENCES sinistro(id).

CREATE TABLE PERICIA (
        cpf_perito varchar(11) REFERENCES perito(cpf),
        veredito char(200),
        placa_automovel char(7) PRIMARY KEY REFERENCES automovel(placa),
        sinistro char(7) NOT NULL
);

-- Um reparo deve ser associado a um automovel, avarias do sinistro, oficina e segurado.
CREATE TABLE REPARO (
        placa_automovel char(7) PRIMARY KEY REFERENCES automovel(placa),
        custo numeric NOT NULL,
        avarias_sinistro varchar(200) NOT NULL,
        oficina_cnpj varchar(20) REFERENCES oficina(cnpj),
        segurado_cpf char(11) REFERENCES segurado(cpf)
);
















