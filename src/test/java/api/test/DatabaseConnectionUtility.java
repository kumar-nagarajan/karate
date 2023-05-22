package api.test;
import java.sql.*;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
public class DatabaseConnectionUtility {
    private static final String url = "jdbc:mysql://tek-database-server.mysql.database.azure.com:3306/tek_insurance_app?useSSL=true&requireSSL=false";
    private static final String username = "tek_student_user";
    private static final String password = "MAY_2022";
    private  static Connection getConnection() {
        try {
            System.out.println("Making Connection to Database");
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getSQLState());
            System.out.println(e.getErrorCode());
            throw new RuntimeException("Error Connecting to Database");
        }
    }
    private static Statement getConnectionStatement() {
        try {
            System.out.println("Creating Connection Statement");
            return getConnection().createStatement();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getSQLState());
            System.out.println(e.getErrorCode());
            throw new RuntimeException("Error Error Creating Statement");
        }
    }
    public  static ResultSet executeQuery(String query) {
        Statement statement;
        try {
            System.out.println("Executing Query " + query);
            statement = getConnectionStatement();
            return statement.executeQuery(query);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getSQLState());
            System.out.println(e.getErrorCode());
            throw new RuntimeException("Error executing query");
        }
    }
    public static List<Map<String, Object>> convertResultToMap(String query) {
        Statement statement = null;
        try {
            List<Map<String, Object>> list = new LinkedList<>();
            ResultSet resultSet = executeQuery(query);
            statement = resultSet.getStatement();
            ResultSetMetaData metadata = resultSet.getMetaData();
            int columns = metadata.getColumnCount();
            while (resultSet.next()) {
                Map<String, Object> map = new HashMap<>();
                for (int i = 1; i <= columns; i++) {
                    map.put(metadata.getColumnName(i), resultSet.getObject(i));
                }
                list.add(map);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getSQLState());
            System.out.println(e.getErrorCode());
            throw new RuntimeException("Error executing query");
        } finally {
            if (statement != null) {
                try {
                    statement.getConnection().close();
                    statement.close();
                } catch (SQLException e) {
                }
            }
        }
    }
    public static String result(String query, String col) {
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        List<Map<String, Object>> result = convertResultToMap(query);
        String resultData = result.get(0).get(col).toString();
        System.out.println(resultData + "=========================================");
        return resultData;
    }
}