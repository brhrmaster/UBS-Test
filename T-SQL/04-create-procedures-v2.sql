USE UBS_AG
GO

CREATE FUNCTION dbo.get_trade_category(@value INT, @sector INT)
RETURNS varchar(10)
BEGIN
    DECLARE @trade_category VARCHAR(20)
    DECLARE @limit INT = 1000000

    SET @trade_category = (
        SELECT CASE
            WHEN @value < @limit AND @sector = 'Public' THEN 'LOWRISK'
            WHEN @value > @limit AND @sector = 'Public' THEN 'MEDIUMRISK'
            WHEN @value > @limit AND @sector = 'Private' THEN 'HIGHRISK'
            ELSE 'UNKNOWN'
        END
    )

    RETURN @trade_category
END
GO

CREATE PROCEDURE dbo.get_trade_risks_v2 @refresh AS bit = 0
AS
BEGIN
    IF @refresh = 1
       OR (SELECT COUNT(id) FROM dbo.tbl_trades_risks) = 0
    BEGIN
        DELETE FROM dbo.tbl_trades_risks

        INSERT INTO dbo.tbl_trades_risks
            SELECT
                trades.value AS value,
                sectors.name AS sector,
                dbo.get_trade_category(trades.value, sectors.name) AS trade_category
            FROM 
                dbo.tbl_trades AS trades
            INNER JOIN
                dbo.tbl_sectors AS sectors
            ON
                trades.sector_id = sectors.id
    END;

    SELECT 
        trades.value AS Value, 
        sectors.name AS ClientSector
    FROM dbo.tbl_trades AS trades
    INNER JOIN dbo.tbl_sectors AS sectors
    ON trades.sector_id = sectors.id;

    SELECT
        trade_category AS TradeCategory
    FROM dbo.tbl_trades_risks;

    SELECT
        value AS Value,
        sector AS ClientSector,
        trade_category AS TradeCategory
    FROM dbo.tbl_trades_risks;
END
GO

-- EXEC dbo.get_trade_risks_v2 @refresh = 1