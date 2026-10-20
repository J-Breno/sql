CREATE FUNCTION FN_MONTAR_D_CALENDARIO
( 
  @D_INI              DATE 
, @D_FIM              DATE 
, @ANO_FECHADO        BIT  
, @INICIO_ANO_FISCAL  INT  

)

RETURNS @D_CALENDARIO TABLE
(

  [date] DATE PRIMARY KEY
, [year] INT
, [start_of_year] DATE
, [end_of_year] DATE
, [month] TINYINT
, [star_of_month] DATE
, [end_of_month] DATE
, [day_in_month] TINYINT
, [year_month_number] INT
, [year_month_name] VARCHAR(8)
, [day] TINYINT
, [day_name] VARCHAR(15)
, [day_name_short] CHAR(3)
, [day_of_week] TINYINT
, [day_of_year] SMALLINT
, [month_name] VARCHAR(15)
, [month_name_short] CHAR(3)
, [quarter] TINYINT
, [quarter_name] CHAR(2)
, [year_quarter_number] INT
, [year_quarter_name] VARCHAR(7)
, [start_of_quarter] DATE
, [end_of_quarter] DATE
, [week_of_year] TINYINT 
, [star_of_week] DATE
, [end_of_week] DATE
, [fiscal_year] INT
, [fiscal_quarter] TINYINT
, [fiscal_month] TINYINT
, [day_offset] INT
, [month_offset] INT
, [quarter_offset] INT
, [year_offset] INT

)

AS

BEGIN




--DECLARE
--  @D_INI              DATE = '2018-01-01'
--, @D_FIM              DATE = '2022-12-31'
--, @ANO_FECHADO        BIT  = 1
--, @INICIO_ANO_FISCAL  INT  = 7


DECLARE @HOJE        DATE = CAST( GETDATE() AS DATE )

DECLARE @ANO_INI     INT = YEAR( @D_INI )
DECLARE @ANO_FIM     INT = YEAR( @D_FIM )

DECLARE @DATA_INI    DATE
DECLARE @DATA_FIM    DATE

SET @DATA_INI = CAST( CONCAT( @ANO_INI , '-01-01' ) AS DATE )
SET @DATA_FIM = CASE @ANO_FECHADO WHEN 1 THEN CAST( CONCAT( @ANO_FIM , '-12-31' ) AS DATE ) ELSE @D_FIM END



;WITH DATAS AS (

SELECT DATEADD( DAY , A.SEQUENCIA -1 , @DATA_INI ) AS [DATA]
  FROM VEZES A WITH(NOLOCK)
 WHERE A.SEQUENCIA <= DATEDIFF( DAY , @DATA_INI , @DATA_FIM ) + 1

)


INSERT INTO @D_CALENDARIO
( 

  [date]
, [year] 
, [start_of_year] 
, [end_of_year] 
, [month] 
, [star_of_month] 
, [end_of_month] 
, [day_in_month] 
, [year_month_number] 
, [year_month_name]
, [day] 
, [day_name]
, [day_name_short]
, [day_of_week]
, [day_of_year]
, [month_name]
, [month_name_short]
, [quarter]
, [quarter_name]
, [year_quarter_number]
, [year_quarter_name]
, [start_of_quarter]
, [end_of_quarter]
, [week_of_year]
, [star_of_week]
, [end_of_week]
, [fiscal_year]
, [fiscal_quarter]
, [fiscal_month]
, [day_offset]
, [month_offset]
, [quarter_offset]
, [year_offset]

)


SELECT A.[DATA]                                                                     AS [date]
     , DATEPART( yy , A.[DATA] )                                                    AS [year]
     , DATEFROMPARTS( YEAR( A.[DATA] ) , 1 , 1 )                                    AS [start_of_year]
     , DATEFROMPARTS( YEAR( A.[DATA] ) , 12 , 31 )                                  AS [end_of_year]
	 , DATEPART( mm , A.[DATA] )                                                    AS [month]
	 , DATEFROMPARTS( YEAR( A.[DATA] ) , MONTH( A.[DATA] ) , 1 )                    AS [star_of_month]
	 , EOMONTH( A.[DATA] )                                                          AS [end_of_month]
	 , DATEPART( dd , EOMONTH( A.[DATA] ) )                                         AS [day_in_month]

     , CONCAT( 
			YEAR( A.[DATA] ) , 
			CONCAT(
				REPLICATE( '0' , 2 - LEN( MONTH( A.[DATA] ) ) ) ,
				MONTH( A.[DATA] )
			)
	   )                                                                            AS [year_month_number]
	 
	 , CONCAT( 
			DATEPART( yy , A.[DATA] ) , 
			'-' ,  
			LOWER( LEFT( DATENAME( mm , A.[DATA] ) , 3 ) )  )                       AS [year_month_name]
	 
	 
	 , DATEPART( dd , A.[DATA] )                                                    AS [day]
	 , LOWER( DATENAME( dw , A.[DATA] ) )                                           AS [day_name]
	 , LOWER( LEFT( DATENAME( dw , A.[DATA] ) , 3 ) )                               AS [day_name_short]
	 , DATEPART( [weekday] , A.[DATA] )                                             AS [day_of_week]
	 , DATEPART( dy , A.[DATA] )                                                    AS [day_of_year]
	 , LOWER( DATENAME( mm , A.[DATA] ) )                                           AS [month_name]
	 , LOWER( LEFT( DATENAME( mm , A.[DATA] ) , 3 ) )                               AS [month_name_short]
	 , DATEPART( qq , A.[DATA] )                                                    AS [quarter]
	 , CONCAT( 'Q' , DATEPART( qq , A.[DATA] ) )                                    AS [quarter_name]
	 , CONCAT( DATEPART( yy , A.[DATA] ) , DATEPART( qq , A.[DATA] ) )              AS [year_quarter_number]
	 , CONCAT( DATEPART( yy , A.[DATA] ) , ' Q' , DATEPART( qq , A.[DATA] ) )       AS [year_quarter_name]
	 , DATEFROMPARTS( YEAR( A.[DATA] ), (DATEPART( qq , A.[DATA] )*3)-2, 1)         AS [start_of_quarter]
	 , EOMONTH( DATEFROMPARTS( YEAR( A.[DATA] ), (DATEPART( qq , A.[DATA] ))*3, 1),0) AS [end_of_quarter]
	 , DATEPART( wk , A.[DATA] )                                                    AS [week_of_year]
	 , DATEADD( DAY , - ( DATEPART( [weekday] , A.[DATA] ) - 1 ) , A.[DATA] )       AS [star_of_week]
	 , DATEADD( DAY , 7 - DATEPART( [weekday] , A.[DATA] ) , A.[DATA] )             AS [end_of_week]
	 
	 , CASE @INICIO_ANO_FISCAL 
	        WHEN 1 
			THEN YEAR( A.[DATA] ) 
			ELSE YEAR( A.[DATA] ) + CAST( ( MONTH( A.[DATA] ) + ( 13 - @INICIO_ANO_FISCAL ) ) / 13 AS INT ) 
	   END                                                                          AS [fiscal_year]

     , DATEPART( 
			qq , 
			DATEFROMPARTS( 
				YEAR( A.[DATA] ) , 
				( ( MONTH( A.[DATA] ) + (13 - @INICIO_ANO_FISCAL) - 1 ) % 12 ) + 1 , 
				1 
			) 
		)                                                                           AS [fiscal_quarter]

	 
	 , ( ( MONTH( A.[DATA] ) + (13 - @INICIO_ANO_FISCAL) - 1 ) % 12 ) + 1           AS [fiscal_month]
	 , DATEDIFF( DAY     , @HOJE , A.[DATA] )                                       AS [day_offset]
     , DATEDIFF( MONTH   , @HOJE , A.[DATA] )                                       AS [month_offset]
	 , DATEDIFF( QUARTER , @HOJE , A.[DATA] )                                       AS [quarter_offset]
	 , DATEDIFF( YEAR    , @HOJE , A.[DATA] )                                       AS [year_offset]


  FROM DATAS                A WITH(NOLOCK)
 ORDER
    BY 1


RETURN


END