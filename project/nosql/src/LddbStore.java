import oracle.kv.*;

import java.sql.*;
import java.util.*;

/**
 * Created by drd26 on 5/10/2017.
 */
public class LddbStore {

    /**
     * Loads data from LDDB into KVStore.
     *
     * Review/$reviewID provides a simplified join table on Review, Game, Player that lists the player username,
     * game name, and review rating for fast and easy acces.
     *
     * Review/$reviewID/player
     * Review/$reviewID/game
     * Review/$reviewID/rating
     *
     */
    public static void LoadDB(){
        // Initialize KVStore to store values
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // Initialize connection to IMDB with JDBC
        try {
            Connection jdbcConnection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "lddbUser", "bjarne");

        // Populate the review table
        Statement reviewStatement = jdbcConnection.createStatement();
        ResultSet resultSet = reviewStatement.executeQuery("SELECT Review.reviewID, Player.username, Game.gameName, Review.rating, Review.dateSubmitted FROM Review, Game, Player WHERE Game.GameID = Review.GameID AND Player.PlayerID = Review.PlayerID");
        while (resultSet.next()) {
            Key key = Key.createKey(Arrays.asList("review", resultSet.getString(1)), Arrays.asList("player"));
            Value value = Value.createValue(resultSet.getString(2).getBytes());
            store.put(key, value);

            key = Key.createKey(Arrays.asList("review", resultSet.getString(1)), Arrays.asList("game"));
            value = Value.createValue(resultSet.getString(3).getBytes());
            store.put(key, value);

            key = Key.createKey(Arrays.asList("review", resultSet.getString(1)), Arrays.asList("rating"));
            value = Value.createValue(resultSet.getString(4).getBytes());
            store.put(key, value);

            //key = Key.createKey(Arrays.asList("review", resultSet.getString(1)), Arrays.asList("date"));
            //value = Value.createValue(resultSet.getString(5).getBytes());
            //store.put(key, value);
        }

        // Populate the sorted game table
        Statement gameStatement = jdbcConnection.createStatement();
        resultSet = reviewStatement.executeQuery("SELECT Game.GameName, Game.DateReleased FROM Game ORDER BY Game.DateReleased ASC");
            while (resultSet.next()) {
                Key key = Key.createKey(Arrays.asList("sortedGames"), Arrays.asList(resultSet.getString(1)));
                Value value = Value.createValue(resultSet.getString(2).getBytes());
                store.put(key, value);
            }

        resultSet.close();
        reviewStatement.close();



        jdbcConnection.close();
        } catch(SQLException e){
            System.err.println(e.getMessage());
        }


    }

    /**
     * Gets a value out of the review join table where reviewID = 0.
     * Uses a multiget to retrieve all minor keys associated with the major key review/0
     *
     * Prints the results to console
     */
    public static void GetTableValues(){
        // Initialize KVStore to store values
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // Using hard coded values to demonstrate multiget
        // TODO Read all ID values

        System.out.println("Table: review");
        System.out.println("ID: 0");
        Key key = Key.createKey(Arrays.asList("review", "0"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
    }

    /**
     * Gets a list of all games sorted by release date
     */
    public static void GetSortedGames(){
        // Initialize KVStore to store values
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));


        System.out.println("Table: sortedGames");
        Key key = Key.createKey(Arrays.asList("sortedGames"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
    }


}
