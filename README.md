This repo demonstrates a bug in the [sqlboiler](https://github.com/volatiletech/sqlboiler) code generation tool. The generated `Upsert` test fails.

To demonstrate the bug, clone this repo and run:
```bash
docker-compose up -d
sqlboiler psql --wipe
go test ./models/...
```
You should see the following output:
```bash
--- FAIL: TestUpsert (0.00s)
    --- FAIL: TestUpsert/Examples (0.00s)
        example_test.go:722: Unable to upsert Example: models: unable to upsert example: pq: cannot insert a non-DEFAULT value into column "id"
        example_test.go:727: models: failed to count example rows: pq: current transaction is aborted, commands ignored until end of transaction block
        example_test.go:730: want one record, got: 0
```

The bug occurs because the generated upsert test provides a value for the id field:
```sql
id INT GENERATED ALWAYS AS IDENTITY
```

From the postgres [docs](https://www.postgresql.org/docs/current/sql-createtable.html):
> In an INSERT command, if ALWAYS is selected, a user-specified value is only accepted if the INSERT statement specifies OVERRIDING SYSTEM VALUE. 


Versions used:
 - SQLBoiler: v4.8.3
 - Postgres: 14
 - Go: go1.17.6 darwin/arm64