USE UBS_AG_v1
GO

CREATE FUNCTION dbo.get_trade_category_from_db(@value INT, @sector_id INT)
RETURNS varchar(10)
BEGIN
    RETURN (
        SELECT
            temp_risk.title AS trade_category
        FROM (
            SELECT
                rr.title,
                (
                    CASE WHEN
                        rr.min_range IS NOT NULL 
                        AND @value > rr.min_range
                    THEN 1
                    ELSE 0
                    END
                ) AS MIN_RULE,
                (
                    CASE WHEN
                        rr.max_range IS NOT NULL 
                        AND @value < rr.max_range
                    THEN 1
                    ELSE 0
                    END
                ) AS MAX_RULE
            FROM
                dbo.tbl_risk_rules AS rr
            WHERE
                rr.sector_id = @sector_id
        ) AS temp_risk
        WHERE
            (temp_risk.MIN_RULE = 1 and temp_risk.MAX_RULE = 0) 
            OR (temp_risk.MIN_RULE = 0 and temp_risk.MAX_RULE = 1)
    )
END
GO

CREATE PROCEDURE dbo.get_trade_risks @refresh AS bit = 0
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
                ISNULL(dbo.get_trade_category(trades.value, sectors.id), 'UNKNOWN') AS trade_category
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

-- EXEC dbo.get_trade_risks @refresh = 1
