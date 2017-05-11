import models.PlayerEntity;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class LDDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual player record.
     *
     * @param id the ID of the player to retrieve
     * @return a player record
     */
    @GET
    @Path("player/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PlayerEntity getPlayerEntity(@PathParam("id") long id) {
        return em.find(PlayerEntity.class, id);
    }

    /**
     * GET all players using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all player records
     */
    @GET
    @Path("players")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PlayerEntity> getPlayers() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(PlayerEntity.class)).getResultList();
    }

    @PUT
    @Path("player/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void putPlayerEntity(@PathParam("id") long id, PlayerEntity player) {
        em.merge(player); // Is this the correct method? Am I passing the correct parameters?
    }

    @POST
    @Path("players")
    @Consumes(MediaType.APPLICATION_JSON)
    public void postPlayerEntity(PlayerEntity player) {
        em.persist(player);
    }

    @DELETE
    @Path("player/{id}")
    public void deletePlayerEntity(@PathParam("id") long id) {
        em.remove(id);
    }


}