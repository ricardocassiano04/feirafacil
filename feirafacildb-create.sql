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





CREATE TABLE produtocategoria (
id integer not null primary key generated always as identity,
descricao text,
datacadastro date default current_date,
id_situacaocadastro integer not null references situacaocadastro (id) default 1
);



CREATE TABLE produto (
id integer not null primary key generated always as identity,
descricao text,
id_produtocategoria integer not null references produtocategoria (id),
datacadastro date default current_date,
id_situacaocadastro integer not null references situacaocadastro (id) default 1
);


CREATE TABLE item (
id integer not null primary key generated always as identity,
descricao text,
id_produto integer not null references produto (id),
id_produtocategoria integer not null references produtocategoria (id),
datacadastro date default current_date,
id_situacaocadastro integer not null references situacaocadastro (id) default 1
);



CREATE TABLE pais (
id integer not null primary key generated always as identity,
descricao text
);

CREATE TABLE cidade (
id integer not null primary key generated always as identity,
id_pais integer not null references pais (id),
descricao text
);


CREATE TABLE bairro (
id integer not null primary key generated always as identity,
id_cidade integer not null references cidade (id),
descricao text
);



CREATE TABLE formapagamento (
id integer not null primary key generated always as identity,
descricao text,
id_situacaocadastro integer not null references situacaocadastro (id) default 1 
);

CREATE TABLE tipoestabelecimento (
id integer not null primary key generated always as identity,
descricao text,
id_situacaocadastro integer not null references situacaocadastro (id) default 1 
);




CREATE TABLE estabelecimento (
id integer not null primary key generated always as identity,
descricao text,
cnpj varchar(13),
endereco text,
numero integer,
complementonumero text,
id_bairro integer not null references bairro (id),
id_situacaocadastro integer not null references situacaocadastro (id) default 1,
id_tipoestabelecimento integer not null references tipoestabelecimento (id),
datacadastro date default current_date
);



CREATE TABLE usuario (
id integer not null primary key generated always as identity,
nome text not null,
login text not null,
senha text null,
comprador boolean default false,
endereco text,
numero integer,
complementonumero text,
id_bairro integer not null references bairro (id),
id_situacaocadastro integer not null references situacaocadastro (id) default 1,
datacadastro date not null default current_date
);
