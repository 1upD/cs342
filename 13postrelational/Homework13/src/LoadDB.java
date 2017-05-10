import oracle.kv.*;

import java.sql.*;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by drd26 on 5/10/2017.
 */
public class LoadDB {
    public static void main(String[] args){
        GetTableValues();
    }

    public static void LoadDB(){
        // Initialize KVStore to store values
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // Initialize connection to IMDB with JDBC
        try {
            Connection jdbcConnection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");

        // Populate the movie table
        Statement movieStatement = jdbcConnection.createStatement();
        ResultSet resultSet = movieStatement.executeQuery("SELECT id, name, year, rank FROM Movie");
        while (resultSet.next()) {
            Key key = Key.createKey(Arrays.asList("movie", resultSet.getString(1)), Arrays.asList("name"));
            Value value = Value.createValue(resultSet.getString(2).getBytes());
            store.put(key, value);

            key = Key.createKey(Arrays.asList("movie", resultSet.getString(1)), Arrays.asList("year"));
            value = Value.createValue(resultSet.getString(3).getBytes());
            store.put(key, value);

            // For some reason rank doesn't work
            //key = Key.createKey(Arrays.asList("movie", resultSet.getString(1)), Arrays.asList("rank"));
            //value = Value.createValue(resultSet.getString(4).getBytes());
            //store.put(key, value);
        }
        resultSet.close();
        movieStatement.close();

        jdbcConnection.close();
        } catch(SQLException e){
            System.err.println(e.getMessage());
        }


    }

    public static void GetTableValues(){
        // Initialize KVStore to store values
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // Using hard coded values to demonstrate multiget
        // TODO Read all ID values

        System.out.println("Table: movie");
        System.out.println("ID: 92616");
        Key key = Key.createKey(Arrays.asList("movie", "92616"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
    }

}
