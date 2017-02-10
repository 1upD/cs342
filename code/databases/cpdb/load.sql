-- Load the Centrepointe church database. 
-- See ../README.md for details.

-- Drop the previous table declarations.
@&cpdb\drop         
commit;
-- Reload the table declarations.
@&cpdb\schema
commit;
-- Load the table data.
@&cpdb\data
commit;

