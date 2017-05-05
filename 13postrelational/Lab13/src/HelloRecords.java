import oracle.kv.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Arrays;
import java.util.Map;

/**
 * This program connects to kvlite on localhost, puts a single key-value pair,
 * reads/prints it, updates it and the deletes it. It is based on Oracle's
 * example:
 * 
 * 		C:\Program Files\kv-3.0.9\examples\hello\HelloBigDataWorld.java
 * 
 * You'll need to copy the code into a Java class/application file. See lab 13.1 for details.
 * 
 * @author kvlinden
 * @version Summer, 2014
 */
public class HelloRecords {

	public static void main(String[] args) {
		// Create the store object
		KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

		// Create each key value pair and put it into the store
		// For this example, pairs will be hard coded. Typically they will be stored and entered in a more reasonable way.
		Key key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("name"));
		Value value = Value.createValue("Dr. Strangelove".getBytes());
		store.put(key, value);

		key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("year"));
		value = Value.createValue("1964".getBytes()); // Better way to convert into to byte[]?
		store.put(key, value);

		key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("rating"));
		value = Value.createValue("8.7".getBytes()); // Better way to convert into to byte[]?
		store.put(key, value);


		// Print all values under key movie/92616
		Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", "92616"));
		Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
		for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
			String fieldName = field.getKey().getMinorPath().get(0);
			String fieldValue = new String(field.getValue().getValue().getValue());
			System.out.println("\t" + fieldName + "\t: " + fieldValue);
		}

		store.close();
	}

}