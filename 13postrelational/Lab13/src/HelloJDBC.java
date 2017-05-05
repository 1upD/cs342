import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * This program used JDBC to query all the movies from the IMDB Movies table.
 * Include ojdbc6.jar (from the J2EE library) in the system path to support the JDBC functions.
 * 
 * @author kvlinden
 * @version Spring, 2015
 */
public class HelloJDBC {

	public static void main(String[] args) throws SQLException {
		Connection jdbcConnection = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
		Statement jdbcStatement = jdbcConnection.createStatement();
		ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year FROM Movie");
		while (resultSet.next()) {
			System.out.println(resultSet.getInt(1) + "\t" + resultSet.getString(2) + "\t"
					+ resultSet.getString(3));
		}
		resultSet.close();
		jdbcStatement.close();
		jdbcConnection.close();
	}

}