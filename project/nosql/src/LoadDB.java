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
 * Created by drd26 on 5/11/2017.
 */
public class LoadDB
{
    public static void main(String[] args){
        LddbStore.LoadDB();
    }
}
