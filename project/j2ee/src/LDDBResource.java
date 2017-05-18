import models.GameEntity;
import models.PlayerEntity;
import models.ReviewEntity;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * This code was adapted from Lab12 to work with the LDDB for my databases project.
 * It provides several URL paths to the database which return records in JSON format.
 *
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
 *
 * @author kvlinden
 * @authord drd26
 * @version Spring, 2017
 *
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

    /**
     * GET an individual review record.
     *
     * @param id the ID of the review to retrieve
     * @return a review record
     */
    @GET
    @Path("review/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public ReviewEntity getReviewEntity(@PathParam("id") long id) {
        return em.find(ReviewEntity.class, id);
    }

    /**
     * GET all reviews using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all review records
     */
    @GET
    @Path("reviews")
    @Produces(MediaType.APPLICATION_JSON)
    public List<ReviewEntity> getReviews() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(ReviewEntity.class)).getResultList();
    }

    @PUT
    @Path("review/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void putReviewEntity(@PathParam("id") long id, ReviewEntity review) {
        em.merge(review); // Is this the correct method? Am I passing the correct parameters?
    }

    @POST
    @Path("reviews")
    @Consumes(MediaType.APPLICATION_JSON)
    public void postReviewEntity(ReviewEntity review) {
        em.persist(review);
    }

    @DELETE
    @Path("review/{id}")
    public void deleteReviewEntity(@PathParam("id") long id) {
        em.remove(id);
    }

    /**
     * GET an individual game record.
     *
     * @param id the ID of the game to retrieve
     * @return a game record
     */
    @GET
    @Path("game/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public GameEntity getGameEntity(@PathParam("id") long id) {
        return em.find(GameEntity.class, id);
    }

    /**
     * GET all games using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all game records
     */
    @GET
    @Path("games")
    @Produces(MediaType.APPLICATION_JSON)
    public List<GameEntity> getGames() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(GameEntity.class)).getResultList();
    }

    @PUT
    @Path("game/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void putGameEntity(@PathParam("id") long id, GameEntity game) {
        em.merge(game); // Is this the correct method? Am I passing the correct parameters?
    }

    @POST
    @Path("games")
    @Consumes(MediaType.APPLICATION_JSON)
    public void postGameEntity(GameEntity game) {
        em.persist(game);
    }

    @DELETE
    @Path("game/{id}")
    public void deleteGameEntity(@PathParam("id") long id) {
        em.remove(id);
    }

}