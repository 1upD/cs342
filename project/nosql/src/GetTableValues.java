/**
 *
 * Gets a value out of the review join table where reviewID = 0.
 * Uses a multiget to retrieve all minor keys associated with the major key review/0
 *
 * Prints the results to console
 * Created by drd26 on 5/11/2017.
 * @author drd26
 */
public class GetTableValues
{
    public static void main(String[] args){
        LddbStore.GetTableValues();
    }
}
