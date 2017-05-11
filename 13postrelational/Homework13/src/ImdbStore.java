import oracle.kv.*;

import java.sql.*;
import java.util.*;

/**
 * Created by drd26 on 5/10/2017.
 */
public class ImdbStore {
    public static void main(String[] args){
        LoadDB();
        GetMovieActors();
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

        // Populate the actor table
            Statement actorStatement = jdbcConnection.createStatement();
            resultSet = actorStatement.executeQuery("SELECT id, firstname, lastname, gender FROM Actor");
            while (resultSet.next())
            {
                Key key = Key.createKey(Arrays.asList("actor", resultSet.getString(1)), Arrays.asList("firstname"));
                Value value = Value.createValue(resultSet.getString(2).getBytes());
                store.put(key, value);

                key = Key.createKey(Arrays.asList("actor", resultSet.getString(1)), Arrays.asList("lastname"));
                value = Value.createValue(resultSet.getString(3).getBytes());
                store.put(key, value);
            }

         // Clear the role table


        // Populate the role table
            Statement roleStatement = jdbcConnection.createStatement();
            resultSet = actorStatement.executeQuery("SELECT MovieID, ActorID, Role FROM Role");

            // Initialize a hash map to store the structure of the role path first before adding it to the KVStore
            HashMap<String, HashMap<String, String>> roleStore = new HashMap<>();

            while (resultSet.next())
            {
                String movieID = resultSet.getString(1);
                String actorID = resultSet.getString(2);

                String nextRole = resultSet.getString(3);
                HashMap<String, String> currentMovieRecords = roleStore.get(movieID);
                if(currentMovieRecords == null)
                {
                    currentMovieRecords = new HashMap<String, String>();
                    roleStore.put(movieID, currentMovieRecords); // This is a pass by reference operation, correct?
                }

                String currentRoles = currentMovieRecords.get(actorID);

                String role;
                if(currentRoles == null || currentRoles.equals("")){
                    role = nextRole;
                } else {
                    role = currentRoles + "," + nextRole;
                }

                currentMovieRecords.put(actorID, role);
            }

            // Iterate over hash map and add to key value store
            for(Iterator i = roleStore.entrySet().iterator(); i.hasNext(); i.remove()){
                Map.Entry pair = (Map.Entry)i.next();
                String movieID = (String)pair.getKey();
                Map roles = (Map)pair.getValue();
                for(Iterator j = roles.entrySet().iterator(); j.hasNext(); j.remove()){
                    Map.Entry actorRole = (Map.Entry)j.next();
                    String actorID = (String)actorRole.getKey();
                    String roleString = (String)actorRole.getValue();
                    Key key = Key.createKey(Arrays.asList("role", movieID), Arrays.asList(actorID, "role"));
                    Value value = Value.createValue(roleString.getBytes());
                    store.put(key, value);
                }
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

    public static void GetActorTableValues(){
        // Initialize KVStore to store values
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // Using hard coded values to demonstrate multiget
        // TODO Read all ID values

        System.out.println("Table: actor");
        System.out.println("ID: 155223");
        Key key = Key.createKey(Arrays.asList("actor", "155223"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
    }

    public static void GetMovieActorRoles(){
        // Initialize KVStore to store values
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // Using hard coded values to demonstrate multiget
        // TODO Read all ID values

        System.out.println("Movie ID: 92616");
        System.out.println("Actor ID: 429719");
        Key key = Key.createKey(Arrays.asList("role", "92616"), Arrays.asList("429719", "role"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
    }

    public static void GetMovieActors(){
        // Initialize KVStore to store values
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // Using hard coded values to demonstrate multiget
        // TODO Read all ID values
        String movieID = "92616";

        System.out.println("Table: role");
        System.out.println("ID: " + movieID);
        Key key = Key.createKey(Arrays.asList("role", movieID));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
    }

}
