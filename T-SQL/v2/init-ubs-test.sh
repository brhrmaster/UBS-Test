/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P SqlServerTest! -d master -i /tmp/01-create-tables.sql
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P SqlServerTest! -d master -i /tmp/02-create-procedures.sql