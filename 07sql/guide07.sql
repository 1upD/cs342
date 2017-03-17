--Write a simple view specification. For details on Oracle views, see Managing Views.
	CREATE VIEW MovieCastingPerformers AS
		SELECT * 
		FROM Movie, Performer, Casting
		WHERE Casting.movieID = Movie.ID AND Casting.performerID = Performer.ID;

--Define the following terms (in the comments of your SQL command file).

	-- Base Tables
		-- A table whose tuples are always physically stored in the database.
	-- Join Views
		-- A view containing the result of a join query for easier access.
		
	-- Updateable Join Views
		-- A join view that can be updated. The join view will have to update the underlying base views.
	
	-- Key-Preserved Tables
		-- Any view where each row has a key that can be mapped onto the underlying base table.

	-- Views that are implemented via query modification vs materialization. (For details on Oracle materialization, see Materialized View Concepts and Architecture, focusing on the “What is a Materialized View?” and “Why Use Materialized Views” sections.)
		-- Materialization uses a new base table to store the view that is updated when any of the tables the view is based on are modified. Query modification accesses the table by running a query each time it is needed.
		
