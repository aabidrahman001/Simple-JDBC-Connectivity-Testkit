# Simple-JDBC-Connectivity-Testkit
Basically a lightweight tester I wrote for testing active jdbc connectivity while getting annoyed with repeated failed attempts to test something at work

- Compiles with Java8 and uses MSSQL
        
# Usage
- in DatabaseConfig.java update the following paremeters as needed:

```
remote-host-ip
port
dbname
db-user
db-password
```

Once configured run with ./connect.sh

