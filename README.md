# UBS-Test
An implementation of a challenge with

Input:
```
Trade1 {Value = 2000000; ClientSector = "Private"}
Trade2 {Value = 400000; ClientSector = "Public"}
Trade3 {Value = 500000; ClientSector = "Public"}
Trade4 {Value = 3000000; ClientSector = "Public"}
portfolio = {Trade1, Trade2, Trade3, Trade4}
```

Output:
```
tradeCategories = {"HIGHRISK", "LOWRISK", "LOWRISK", "MEDIUMRISK"}
```

## Domain Design
![alt diagram](docs/class-domain.png)


## (T-SQL) DB output
![alt diagram](docs/db-output.png)