-- DROP TABLE clientes
/*
CREATE TABLE clientes (
	id_ciente     INT                  NOT NULL PRIMARY KEY IDENTITY(1, 1),
	nome          VARCHAR(60)          NOT NULL,
	tipo_endereco VARCHAR(20)          NOT NULL,
	endereco      VARCHAR(60)          NOT NULL,
	numero        NUMERIC(5)           NOT NULL,
	bairro        VARCHAR(60)          NOT NULL,
	complemento   VARCHAR(80)          NULL,
	cep           CHAR(8)              NOT NULL
)

EXEC sp_rename 'clientes.id_ciente', 'id_cliente', 'COLUMN';

CREATE TABLE clientes_telefone (
	id_cliente INT REFERENCES clientes(id_cliente),
	ddd        NUMERIC(2),
	telefone   NUMERIC(9),
	PRIMARY KEY(id_cliente, ddd, telefone)
)

*/

