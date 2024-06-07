/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P SqlServerTest! -d master -i /tmp/01-create-tables.sql
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P SqlServerTest! -d master -i /tmp/02-insert-data.sql
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P SqlServerTest! -d master -i /tmp/03-create-procedures-v1.sql
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P SqlServerTest! -d master -i /tmp/04-create-procedures-v2.sql