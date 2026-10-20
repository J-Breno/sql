-- Relacionamentos em um banco de dados é a ligação entre duas tabelas.
-- inner join só vai trazer as informações que tem tanto na tabela A e na tabela B
-- LEFT JOIN ele vai trazer tanto do inner, quanto tudo da tabela A.
-- RIGH JOIN ele vai trazer tanto do innerm, quanto tudo da tabela B.

SP_HELP PRODUTOS

SELECT
	a.VENDEDOR,
	b.nome,
	SUM( a.QUANTIDADE) AS QUANTIDADE
FROM
	VENDAS_ANALITICAS a
INNER JOIN VENDEDORES b ON a.VENDEDOR = b.VENDEDOR
WHERE a.VENDEDOR IN(1, 2, 3, 20)
GROUP BY a.VENDEDOR, b.NOME
HAVING SUM( a.QUANTIDADE) > 35840.0
ORDER BY a.VENDEDOR

SELECT
	B.MARCA COD_MARCA,
	C.DESCRICAO AS DESCRICAO_MARCA,
	SUM(A.VENDA_LIQUIDA) AS TOTAL_VENDA_LIQUIDA
FROM
	VENDAS_ANALITICAS A
INNER JOIN PRODUTOS B ON A.PRODUTO = B.PRODUTO
INNER JOIN MARCAS C ON C.MARCA = B.MARCA
GROUP BY B.MARCA, C.DESCRICAO
ORDER BY B.MARCA