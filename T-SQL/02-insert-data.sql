USE UBS_AG
GO

INSERT INTO dbo.tbl_sectors(name)
VALUES
    ('Private'),
    ('Public')

GO

INSERT INTO dbo.tbl_trades(value, sector_id)
VALUES
    (2000000, 1),
    (400000, 2),
    (500000, 2),
    (3000000, 2),
    (1000000, 2),
    (1000000, 1)

GO

INSERT INTO dbo.tbl_risk_rules(title, min_range, max_range, sector_id)
VALUES 
    ('LOWRISK', NULL, 1000000, 2),
    ('MEDIUMRISK', 1000000, NULL, 2),
    ('HIGHRISK', 1000000, NULL, 1)

GO