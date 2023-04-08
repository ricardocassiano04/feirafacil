/*
Projeto de software para gerenciar suas compras no supermercado

Queries de criação das tabelas do banco feirafacildb

Compatível com PostgreSQL 15 ou superior.

Obs: O banco de dados ainda está em desenvolvimento.

*/



create table situacao (
id integer not null primary key,
descricao text
);

INSERT INTO situacao (id, descricao) 
values (0, 'EXCLUIDO'), (1, 'ATIVO');





create table produto_categoria (
id integer not null primary key generated always as identity,
descricao text,
datacadastro timestamp default current_timestamp(0),
situacao_id integer not null references situacao (id) default 1
);



create table produto (
id integer not null primary key generated always as identity,
descricao text,
id_produtocategoria integer not null references produto_categoria (id),
datacadastro  timestamp  default current_timestamp(0),
situacao_id integer not null references situacao (id) default 1
);


create table item (
id integer not null primary key generated always as identity,
descricao text,
produto_id integer not null references produto (id),
estoque numeric(13,2),
datacadastro timestamp  default current_timestamp(0),
situacao_id integer not null references situacao (id) default 1,
item_unidade char(2),
qtde_embalagem integer
);



create table item_codigo_barras (
item_id integer not null references item (id),
codigo_barras numeric(14) not null,
situacao_id integer not null references situacao (id) default 1,
primary key (item_id, codigo_barras)
);



create table lista_compra (
id integer not null primary key generated always as identity,
descricao text,
datacadastro timestamp default current_timestamp(0),
situacao_id integer not null references situacao (id) default 1
);

create table lista_compra_item (
id integer not null primary key generated always as identity,
lista_compra_id integer not null references lista_compra (id),
item_id integer not null references item (id),
datacadastro timestamp default current_timestamp(0),
situacao_id integer not null references situacao (id) default 1
);


create table pais (
id integer not null primary key generated always as identity,
descricao text
);

create table estado (
id integer not null primary key ,
pais_id integer not null references pais (id),
descricao text,
sigla char(2)
);

 

create table cidade (
id integer not null primary key,
estado_id integer not null references estado (id),
descricao text
);



create table bairro (
id integer not null primary key generated always as identity,
cidade_id integer not null references cidade (id),
descricao text
);

create table endereco (
id integer not null primary key generated always as identity,
bairro_id integer not null references bairro (id),
endereco text,
numero integer,
complementonumero text,
cep varchar(8)
);


create table forma_pagamento (
id integer not null primary key generated always as identity,
descricao text,
situacao_id integer not null references situacao (id) default 1 
);



create table tipoestabelecimento (
id integer not null primary key generated always as identity,
descricao text,
situacao_id integer not null references situacao (id) default 1 
);




create table estabelecimento (
id integer not null primary key generated always as identity,
descricao text,
cnpj varchar(13),
endereco_id integer not null references endereco (id),
situacao_id integer not null references situacao (id) default 1,
tipoestabelecimento_id integer not null references tipoestabelecimento (id),
datacadastro timestamp  default current_timestamp(0)
);


create table comprador (
id integer not null primary key generated always as identity,
nome text not null,
situacao_id integer not null references situacao (id) default 1,
datacadastro timestamp default current_timestamp(0)
);


create table usuario (
id integer not null primary key generated always as identity,
nome text not null,
login text not null,
senha text null,
endereco_id integer not null references endereco (id),
comprador_id integer null references comprador (id),
situacao_id integer not null references situacao (id) default 1,
datacadastro timestamp default current_timestamp(0)
);


create table terceiro (
id integer not null primary key generated always as identity,
nome text not null,
situacao_id integer not null references situacao (id) default 1,
datacadastro timestamp default current_timestamp(0)
);

create table carteira (
id integer not null primary key generated always as identity,
descricao text,
forma_pagamento_id integer references forma_pagamento (id),
usuario_id integer references usuario (id),
terceiro_id integer references terceiro (id),
situacao_id integer not null references situacao (id) default 1 
);

alter table carteira add final_cartao varchar(10);
alter table carteira add bandeira varchar(20);

alter table carteira add datacadastro timestamp default current_timestamp(0);

alter table carteira drop column forma_pagamento_id;

create table carteira_forma_pagamento (
carteira_id integer,
forma_pagamento_id integer,
datacadastro timestamp default current_timestamp(0),
unique (carteira_id, forma_pagamento_id)
);



create table compras (
id bigint not null primary key generated always as identity,
numero_cupom bigint not null,
numero_nfce bigint,
compra_data date,
compra_hora date,
valor_total numeric(15,2),
chavenfce varchar(44),
estabelecimento_id integer references estabelecimento (id),
usuario_id integer references usuario (id),
datahorainclusao timestamp default current_timestamp(0)
);


create table compras_forma_pagamento (
id bigint not null primary key generated always as identity,
compra_id bigint references compras (id),
forma_pagamento_id integer references forma_pagamento (id),
carteira_id integer references carteira (id),
unique (compra_id, forma_pagamento_id, carteira_id)
);


create table compras_item (
id bigint not null primary key generated always as identity,
compras_id bigint references compras (id),
posicao_item_cupom integer,
codigo_item_estabelecimento integer,
item_id integer references item (id),
quantidade numeric(15,2) not null,
preco_unitario numeric(15,2),
valor_total_item numeric(15,2)
);
