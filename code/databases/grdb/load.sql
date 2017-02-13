-- Load the grading database. 
-- See ../README.md for details.

-- Drop the previous table declarations.
@&grdb\drop         
commit;
-- Reload the table declarations.
@&grdb\schema
commit;
-- Load the table data.
@&grdb\data
commit;
-- Add constraints that cannot be added before the data.
@&grdb\constraints
commit;
