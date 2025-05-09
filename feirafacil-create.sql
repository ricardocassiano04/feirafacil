/*
Projeto para gerenciar suas compras no supermercado.

Queries de criação das tabelas do banco feirafacildb

Testado com PostgreSQL 17.

Obs: O banco de dados ainda está em desenvolvimento.

*/

create database feirafacildb ;

\c feirafacildb


create table situacao (
id integer not null primary key,
descricao text
);

INSERT INTO situacao (id, descricao) 
values (0, 'EXCLUIDO'), (1, 'ATIVO');



create table produto_categoria (
id bigserial not null primary key,
descricao text,
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp
);



create table produto (
id bigserial not null primary key,
descricao text,
id_produtocategoria bigint not null references produto_categoria (id),
situacao_id integer not null references situacao (id) default 1,
data_cadastro  timestamp  default current_timestamp(0),
data_atualizacao timestamp
);


create table item (
id bigserial not null primary key,
descricao text,
produto_id bigint not null references produto (id),
estoque numeric(13,2),
situacao_id integer not null references situacao (id) default 1,
item_unidade char(2),
qtde_embalagem integer,
data_cadastro timestamp  default current_timestamp(0),
data_atualizacao timestamp
);



create table item_codigo_barras (
item_id bigint not null references item (id),
codigo_barras numeric(14) not null,
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp  default current_timestamp(0),
data_atualizacao timestamp,
primary key (item_id, codigo_barras)
);



create table lista_compra (
id bigserial not null primary key,
descricao text,
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp
);


create table lista_compra_item (
id bigserial not null primary key,
lista_compra_id bigint not null references lista_compra (id),
item_id bigint not null references item (id),
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp
);


create table pais (
id bigserial not null primary key,
descricao text
);

create table estado (
id bigserial not null primary key,
pais_id bigint not null references pais (id),
descricao text,
sigla char(2)
);

 

create table cidade (
id bigserial not null primary key,
estado_id bigint not null references estado (id),
descricao text
);



create table bairro (
id bigserial not null primary key,
cidade_id bigint not null references cidade (id),
descricao text not null,
unique (cidade_id, descricao)
);



create table endereco (
id bigserial not null primary key,
bairro_id bigint not null references bairro (id),
endereco text,
cep varchar(8),
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp,
unique (bairro_id, endereco, cep)
);


create table forma_pagamento (
id bigserial not null primary key,
descricao text UNIQUE,
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp
);



create table tipo_estabelecimento (
id bigserial not null primary key,
descricao text,
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp
);




create table estabelecimento (
id bigserial not null primary key,
descricao text,
cnpj varchar(13),
endereco_id bigint not null references endereco (id),
endereco_complemento text,
situacao_id integer not null references situacao (id) default 1,
tipoestabelecimento_id bigint not null references tipo_estabelecimento (id),
data_cadastro timestamp  default current_timestamp(0),
data_atualizacao timestamp
);


create table comprador (
id bigserial not null primary key,
nome text not null,
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp
);


create table usuario (
id bigserial not null primary key,
nome text not null,
login text not null,
senha text null,
endereco_id bigint not null references endereco (id),
endereco_complemento text,
comprador_id bigint null references comprador (id),
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp
);


create table terceiro (
id bigserial not null primary key,
nome text not null,
situacao_id integer not null references situacao (id) default 1,
data_cadastro timestamp default current_timestamp(0),
data_atualizacao timestamp
);




create table compras (
id bigserial not null primary key,
numero_cupom bigint not null,
numero_nfce bigint,
compra_data date,
compra_hora time,
valor_total numeric(15,2),
chavenfce varchar(44),
estabelecimento_id bigint references estabelecimento (id),
usuario_id bigint references usuario (id),
datahorainclusao timestamp default current_timestamp(0)
);


create table compras_forma_pagamento (
id bigserial not null primary key,
compra_id bigint references compras (id),
forma_pagamento_id bigint references forma_pagamento (id),
unique (compra_id, forma_pagamento_id)
);



create table compras_item (
id bigserial not null primary key,
compras_id bigint references compras (id),
posicao_item_cupom integer,
codigo_item_estabelecimento integer,
item_id bigint references item (id),
quantidade numeric(15,2) not null,
preco_unitario numeric(15,2),
valor_total_item numeric(15,2),
datahorainclusao timestamp default current_timestamp(0)
);
