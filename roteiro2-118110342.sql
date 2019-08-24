-- QUESTÃO 1:

CREATE TABLE tarefas
(
    atributo1 INTEGER,
    atributo2 VARCHAR(50),
    atributo3 VARCHAR(11),
    atributo4 INTEGER UNIQUE,
    atributo5 CHAR(2),
    CONSTRAINT at3Length CHECK(LENGTH(atributo3) = 11)
);

INSERT INTO tarefas VALUES(2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
INSERT INTO tarefas VALUES(null, null, null, null, null);

INSERT INTO tarefas VALUES(2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');
INSERT INTO tarefas VALUES(2147483643, 'limpar chão do corredor superior', '98765432321', 0, 'FF');


-- QUESTÃO 2:

INSERT INTO tarefas VALUES(2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

-- Mudando o tipo do atributo1 para BIGINT:
ALTER TABLE tarefas ALTER COLUMN atributo1 TYPE BIGINT;
-- Agora inserido com sucesso.
INSERT INTO tarefas VALUES(2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

-- QUESTÃO 3

ALTER TABLE tarefas ADD CONSTRAINT at4Max CHECK (atributo4 < 32768);

INSERT INTO tarefas VALUES(2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');
INSERT INTO tarefas VALUES(2147483650, 'limpar janelas da entrada principal', '323333233288', 32789, 'A');

INSERT INTO tarefas VALUES(2147483651, 'limpar portas do 1o andar', '32323232911', 32767, 'A');
INSERT INTO tarefas VALUES(2147483652, 'limpar portas do 2o andar', '32323232911', 32766, 'A');

-- QUESTÃO 4

ALTER TABLE tarefas RENAME COLUMN atributo1 TO id;
ALTER TABLE tarefas RENAME COLUMN atributo2 TO descricao;
ALTER TABLE tarefas RENAME COLUMN atributo3 TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN atributo4 TO prioridade;
ALTER TABLE tarefas RENAME COLUMN atributo5 TO status;

DELETE FROM tarefas WHERE id IS NULL;

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

-- QUESTÃO 5

-- Adicionando a Constraint UNIQUE para a coluna 'id':
ALTER TABLE tarefas ADD CONSTRAINT idUnique UNIQUE(id);

INSERT INTO tarefas VALUES(2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');

-- Não será inserido pois o id coincide com a tupla inserida anteriormente.
INSERT INTO tarefas VALUES(2147483653, 'aparar a grama da área frontal', '32323232911', 3, 'A');

-- QUESTÃO 6a (Já implementado na criação da tabela)

-- QUESTÃO 6b 

UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

ALTER TABLE tarefas ADD CONSTRAINT statusDom CHECK(status = 'P' OR status = 'E' OR status = 'C');

-- QUESTÃO 7

UPDATE tarefas SET prioridade = 5 WHERE prioridade > 5;

ALTER TABLE tarefas ADD CONSTRAINT prioridadeMax CHECK(prioridade < 6 AND prioridade >= 0);

-- QUESTÃO 8

CREATE TABLE funcionario(
    cpf VARCHAR(11) PRIMARY KEY,
    data_nasc DATE NOT NULL,
    nome VARCHAR(50) NOT NULL,
    funcao VARCHAR(50) NOT NULL,
    nivel CHAR NOT NULL,
    superior_cpf VARCHAR(11),
    CONSTRAINT restricFuncao CHECK(funcao = 'SUP_LIMPEZA' OR (funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL)),
    CONSTRAINT restricNivel CHECK(nivel = 'J' OR nivel = 'P' OR nivel = 'S')

);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678913', '1980-04-09', 'joao da silva', 'LIMPEZA', 'J', null);

-- QUESTÃO 9

-- Deve funcionar:
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('32322525199', '1987-04-02', 'Pedrovsky Romanov', 'LIMPEZA', 'S', '99999999999');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('32323232911', '1987-09-12', 'jOAO ANTONIO', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('32323232955', '1992-08-01', 'Zé', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('32322525198', '1992-12-08', 'Joseana', 'SUP_LIMPEZA', 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('98765432111', '1998-11-22', 'Mariana', 'LIMPEZA', 'S', '78787876545');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678939', '1998-12-26', 'Marcos Costa', 'LIMPEZA', 'S', '78787876548');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678945', '1998-12-29', 'Marina Fernandes', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678967', '1950-10-24', 'Gilberto Gil', 'SUP_LIMPEZA', 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678969', '1952-12-28', 'Mick Jagger', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678989', '2000-09-22', 'Carouuuu', 'LIMPEZA', 'S', '79798564237');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('98765432122', '1980-07-03', 'Martin Scorsese', 'SUP_LIMPEZA', 'S', null);
-- Não deve funcionar:
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678990', '2000-09-22', 'Mário Andrade', 'LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678991', '2000-09-22', 'Higor Santos', 'SUP_LIMPEZA', 'V', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678992', '2000-09-22', 'Robert Plant', 'SUP_LIMPEZA', 'V', '79798564237');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678995', '2000-09-22', 'Zezo O Principe dos Teclados', 'SUP_LIMPEZA', null, '79798564232');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678998', '1975-09-22', 'Japa Souza', 'Servente de pedreiro', 'S', '79798564232');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678999', '2000-02-03', 'Caroliny Valença', 'PRINCESA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12347678001', '1998-09-22', 'Lucio Nathan', 'Incompetente', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('123476780056', '1998-09-22', 'Cilas Marques', 'LIMPEZA', 'S', '12345678534');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12347678001', '1998-09-27', 'Gabriel Carvalho', 'LIMPEZA', 'Senior', '12345678537');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678989', '1998-09-27', 'Carlos Drummond de Andrade', 'LIMPEZA', 'S', '12345678539');

-- QUESTÃO 10

ALTER TABLE tarefas ADD CONSTRAINT deleteConstraint FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;
DELETE FROM funcionario WHERE cpf = '12345678939';

ALTER TABLE tarefas ADD CONSTRAINT deleteConstraint2 FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE RESTRICT;
DELETE FROM funcionario WHERE cpf = '32322525199';
-- Nenhum erro -.-

-- QUESTÃO 11

ALTER TABLE tarefas ALTER COLUMN func_resp_cpf DROP NOT NULL;
ALTER TABLE tarefas ADD CONSTRAINT cpfNull CHECK(status = 'E' AND func_resp_cpf IS NULL);
