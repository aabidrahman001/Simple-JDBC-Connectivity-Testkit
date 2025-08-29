import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionTester {
    public static void main(String[] args) {
        if (args.length < 4) {
            System.out.println("Usage: java ConnectionTester <dbType> <jdbcUrl> <username> <password> <driverClass>");
            return;
        }

        String dbType = args[0];
        String jdbcUrl = args[1];
        String username = args[2];
        String password = args[3];
        String driverClass = args.length > 4 ? args[4] : null;

        try {
            DatabaseConfig.init(jdbcUrl, username, password, driverClass);

            try (Connection conn = DatabaseConfig.getConnection()) {
                if (conn != null) {
                    System.out.println("✅ Connection to " + dbType + " successful!");
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Connection failed: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

