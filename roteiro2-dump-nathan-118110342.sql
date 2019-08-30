--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.tarefas DROP CONSTRAINT deleteconstraint2;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT deleteconstraint;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_atributo4_key;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT idunique;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: nathan
--

CREATE TABLE public.funcionario (
    cpf character varying(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(50) NOT NULL,
    funcao character varying(50) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character varying(11),
    CONSTRAINT restricfuncao CHECK ((((funcao)::text = 'SUP_LIMPEZA'::text) OR (((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)))),
    CONSTRAINT restricnivel CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO nathan;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: nathan
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao character varying(50) NOT NULL,
    func_resp_cpf character varying(11),
    prioridade integer NOT NULL,
    status character(2) NOT NULL,
    CONSTRAINT at3length CHECK ((length((func_resp_cpf)::text) = 11)),
    CONSTRAINT at4max CHECK ((prioridade < 32768)),
    CONSTRAINT statusdom CHECK (((status = 'P'::bpchar) OR (status = 'E'::bpchar) OR (status = 'C'::bpchar)))
);


ALTER TABLE public.tarefas OWNER TO nathan;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: nathan
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1987-09-12', 'jOAO ANTONIO', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1992-08-01', 'Zé', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32322525198', '1992-12-08', 'Joseana', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1998-11-22', 'Mariana', 'LIMPEZA', 'S', '78787876545');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678945', '1998-12-29', 'Marina Fernandes', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678967', '1950-10-24', 'Gilberto Gil', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678969', '1952-12-28', 'Mick Jagger', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678989', '2000-09-22', 'Carouuuu', 'LIMPEZA', 'S', '79798564237');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1980-07-03', 'Martin Scorsese', 'SUP_LIMPEZA', 'S', NULL);


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: nathan
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'P ');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 32767, 'P ');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 32766, 'P ');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'P ');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C ');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C ');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: nathan
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: idunique; Type: CONSTRAINT; Schema: public; Owner: nathan
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT idunique UNIQUE (id);


--
-- Name: tarefas_atributo4_key; Type: CONSTRAINT; Schema: public; Owner: nathan
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_atributo4_key UNIQUE (prioridade);


--
-- Name: deleteconstraint; Type: FK CONSTRAINT; Schema: public; Owner: nathan
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT deleteconstraint FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE CASCADE;


--
-- Name: deleteconstraint2; Type: FK CONSTRAINT; Schema: public; Owner: nathan
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT deleteconstraint2 FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

