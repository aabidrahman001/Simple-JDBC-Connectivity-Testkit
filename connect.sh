echo "Simple JDBC Connectivity Testkit"
echo "Select Java version:"
select JAVA_VERSION in "8" "17" "21"; do
    case $JAVA_VERSION in
        8 ) DRIVER="lib/mssql-jdbc-12.8.1.jre8.jar"; HIKARI="lib/HikariCP-4.0.3.jar"; break;;
        17 ) DRIVER="lib/mssql-jdbc-12.8.1.jre11.jar"; HIKARI="lib/HikariCP-5.1.0.jar"; break;;
        21 ) DRIVER="lib/mssql-jdbc-12.8.1.jre11.jar"; HIKARI="lib/HikariCP-5.1.0.jar"; break;;
        * ) echo "Invalid option";;
    esac
done

echo "Select Database type:"
select DB_TYPE in "mssql" "postgres"; do
    case $DB_TYPE in
        mssql ) DB_DRIVER=$DRIVER; DB_CLASS="com.microsoft.sqlserver.jdbc.SQLServerDriver"; break;;
        postgres ) DB_DRIVER="lib/postgresql-42.7.3.jar"; DB_CLASS="org.postgresql.Driver"; break;;
        * ) echo "Invalid option";;
    esac
done

read -p "Enter host (default: localhost): " DB_HOST
DB_HOST=${DB_HOST:-localhost}

if [ "$DB_TYPE" = "mssql" ]; then
    read -p "Enter port (default: 1433): " DB_PORT
    DB_PORT=${DB_PORT:-1433}
    read -p "Enter database name: " DB_NAME
    DB_URL="jdbc:sqlserver://$DB_HOST:$DB_PORT;databaseName=$DB_NAME;encrypt=true;trustServerCertificate=true"
elif [ "$DB_TYPE" = "postgres" ]; then
    read -p "Enter port (default: 5432): " DB_PORT
    DB_PORT=${DB_PORT:-5432}
    read -p "Enter database name: " DB_NAME
    DB_URL="jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME"
fi

read -p "Enter username: " DB_USER
read -s -p "Enter password: " DB_PASS
echo

CLASSPATH=".:$DB_DRIVER:$HIKARI:lib/slf4j-api-1.7.36.jar:lib/slf4j-simple-1.7.36.jar"

javac --release $JAVA_VERSION -cp "$CLASSPATH" DatabaseConfig.java ConnectionTester.java
java -cp "$CLASSPATH" ConnectionTester "$DB_TYPE" "$DB_URL" "$DB_USER" "$DB_PASS" "$DB_CLASS"

