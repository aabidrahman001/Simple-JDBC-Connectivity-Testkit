import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionTester {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            if (conn != null) {
                System.out.println("Connection successful!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
