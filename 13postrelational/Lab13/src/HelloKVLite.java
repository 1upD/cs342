import java.util.Arrays;

import oracle.kv.KVStore;
import oracle.kv.KVStoreConfig;
import oracle.kv.KVStoreFactory;
import oracle.kv.Key;
import oracle.kv.Value;

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
public class HelloKVLite {

	public static void main(String[] args) {
		
		KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

		// C(reate)
		// This initializes an arbitrary key-value pair and stores it in KVLite.
		// The key-value structure is /helloKey : $value
		String keyString = "helloKey", valueString = "Hello, Oracle NoSQL!";
		Key key = Key.createKey(Arrays.asList(keyString));
		Value value = Value.createValue(valueString.getBytes());
		store.put(key, value);

		// R(ead)
		// This queries KVLite using the same key.
		// The result, a byte array, is converted into a string.
		String result = new String(store.get(key).getValue().getValue());
		System.out.println(key.toString() + " : " + result);

		// U(pdate)
		// This modifies the value, puts the new value, overwriting the old
		// value, and gets/prints it again.
		valueString = "Hello, KVLite!";
		value = Value.createValue(valueString.getBytes());
		store.put(key, value);
		result = new String(store.get(key).getValue().getValue());
		System.out.println(key.toString() + " : " + result);

		// D(elete)
		// This deletes the key-value pair.
		store.delete(key);
		if (store.get(key) == null) {
			System.out.println("Good, key successfully deleted...");
		} else {
			System.out.println("Oops, key not deleted...");
		}

		// Second key value pair
		key = Key.createKey(Arrays.asList("secondKey"));
		value = Value.createValue("This is the second key value pair.".getBytes());
		store.put(key, value);

		System.out.println("Found second key-value pair: " + key.toString() + " : " + new String(store.get(key).getValue().getValue()));
		store.delete(key);
		if (store.get(key) == null) {
			System.out.println("Good, key successfully deleted...");
		} else {
			System.out.println("Oops, key not deleted...");
		}


		store.close();
	}

}