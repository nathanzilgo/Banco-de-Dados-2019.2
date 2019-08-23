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
    cpf INTEGER PRIMARY KEY,
    data_nasc DATE NOT NULL,
    nome VARCHAR() NOT NULL,
    funcao VARCHAR() NOT NULL,
    nivel CHAR NOT NULL,
    superior_cpf INTEGER FOREIGN KEY,
    CONSTRAINT restricFuncao CHECK(funcao = 'LIMPEZA' OR funcao = 'SUP_LIMPEZA'),
    CONSTRAINT restricNivel CHECK(nivel = 'J' OR nivel = 'P' OR nivel = 'S')

);

