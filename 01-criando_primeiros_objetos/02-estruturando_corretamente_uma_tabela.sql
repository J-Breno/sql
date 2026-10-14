-- drop table clientes

/*
CREATE TABLE clientes (

 id              NUMERIC(9)   NOT NULL PRIMARY KEY IDENTITY(1, 1),
 nome            VARCHAR(60)  NOT NULL,
 cpf             CHAR(11)     NOT NULL,
 data_nascimento DATE         NULL,
 idade           TINYINT      NULL,
 data_cadastro   DATETIME     NOT NULL DEFAULT(GETDATE()),
 ativo           BIT          NOT NULL DEFAULT(1),
 limite          NUMERIC(5,2) NOT NULL DEFAULT(0.00)

)

*/

-- SP_HELP clientes

