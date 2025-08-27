import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConfig {
    private static HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        config.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        config.setJdbcUrl("jdbc:sqlserver://remote-host-ip:port;databaseName=dbname;encrypt=true;trustServerCertificate=true");
        config.setUsername("db-user");
        config.setPassword("db-password");
        config.setMaximumPoolSize(1000);
        config.setMinimumIdle(500);
        config.setIdleTimeout(5);
        config.setMinimumIdle(1);
        config.setMaximumPoolSize(20);
        config.setConnectionTimeout(500); // Set to 250ms or higher

        dataSource = new HikariDataSource(config);
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
