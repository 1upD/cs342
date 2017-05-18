import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

/**
 * The following routes are provided by the web service:
 * player/$id
 * players
 * review/$id
 * reviews
 * game/$id
 * games
 *
 * The web service provides access to the Player, Review, and Games tables and returns the requested records
 * (either individually or the entire table) as model objects. The ReviewEntity model class has a one to many relationship
 * with Player (each ReviewEntity object has a player object) and a many to many relationship with ReviewChapter
 * (each ReviewEntity object has a list of ReviewchapterEntity objects)
 *
 * Unfortunately, I can't seem to get Glassfish server to deploy the project.
 */
//Defines the base URI for all resource URIs.
@ApplicationPath("/")
//The java class declares root resource and provider classes
public class MyApplication extends Application{
    //The method returns a non-empty collection with classes, that must be included in the published JAX-RS application
    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add( LDDBResource.class );
        return h;
    }
}
