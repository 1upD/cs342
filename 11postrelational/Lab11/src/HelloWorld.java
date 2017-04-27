import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;

// The Java class will be hosted at the URI path "/helloworld"
@Path("/hello")
public class HelloWorld {
    // The Java method will process HTTP GET requests
    @GET
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("text/plain")
    public String getClichedMessage() {
        // Return some cliched textual content
        return "Hello World";
    }

    // curl -H "Content-Type: text/plain" -X PUT http://localhost:8080/Lab11_war_exploded/hello -d 1
    @PUT
    @Consumes("text/plain")
    public String putCliche(int someNumber){
        return "Putting: " + someNumber;
    }

    // curl -H "Content-Type: text/plain" -X POST http://localhost:8080/Lab11_war_exploded/hello -d "This is a test."
    @POST
    @Consumes("text/plain")
    public String postCliche(String clichedMessage){
        return "Posting: " + clichedMessage;
    }

    // curl -H "Content-Type: text/plain" -X DELETE http://localhost:8080/Lab11_war_exploded/hello -d 1
    @DELETE
    @Consumes("text/plain")
    public String deleteCliche(int someNumber){
        return "Deleting: " + someNumber;
    }
}