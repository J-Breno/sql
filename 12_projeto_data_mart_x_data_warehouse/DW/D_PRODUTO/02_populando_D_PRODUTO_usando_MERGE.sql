MERGE D_PRODUTO AS D
USING PBS_PROCFIT_ST.DBO.VW_D_PRODUTOS AS O
    ON D.COD_PRODUTO = O.COD_PRODUTO

WHEN MATCHED THEN
    UPDATE SET
        D.DESCRICAO          = O.DESCRICAO,
        D.DESCRICAO_REDUZIDA = O.DESCRICAO_REDUZIDA,
        D.FAMILIA            = O.FAMILIA,
        D.SECAO              = O.SECAO,
        D.GRUPO              = O.GRUPO,
        D.SUB_GRUPO          = O.SUB_GRUPO,
        D.MARCA               = O.MARCA

WHEN NOT MATCHED BY TARGET THEN
    INSERT
    (
        COD_PRODUTO,
        DESCRICAO,
        DESCRICAO_REDUZIDA,
        FAMILIA,
        SECAO,
        GRUPO,
        SUB_GRUPO,
        MARCA
    )
    VALUES
    (
        O.COD_PRODUTO,
        O.DESCRICAO,
        O.DESCRICAO_REDUZIDA,
        O.FAMILIA,
        O.SECAO,
        O.GRUPO,
        O.SUB_GRUPO,
        O.MARCA
    );