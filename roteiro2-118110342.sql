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


