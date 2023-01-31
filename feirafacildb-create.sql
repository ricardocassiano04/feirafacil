/*
Projeto de software para gerenciar suas compras no supermercado

Queries de criação das tabelas do banco feirafacildb

Compatível com PostgreSQL 11 ou superior.

Obs: O banco de dados ainda está em desenvolvimento.

*/



CREATE TABLE situacaocadastro (
id integer not null primary key,
descricao text
);

INSERT INTO situacaocadastro (id, descricao) 
values (0, 'EXCLUIDO'), (1, 'ATIVO');


CREATE TABLE usuario (
id integer not null primary key generated always as identity,
nome text not null,
login text not null,
senha text null,
id_situacaocadastro integer not null references situacaocadastro (id) default 0,
datacadastro date not null default current_date
);



CREATE TABLE comprador (
id integer not null primary key generated always as identity,
nome text,
id_situacaocadastro integer not null references situacaocadastro (id) default 0,
datacadastro date not null default current_date
);
