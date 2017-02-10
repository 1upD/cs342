-- Load the small Internet Movie Database. 
-- See ../README.md for details.

-- Drop the previous table declarations.
@&imdb\drop
commit;
-- Reload the table declarations.
@&imdb\schema
commit;
-- Load the table data.
@&imdb\data
commit;

