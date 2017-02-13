-- Drop the previous table declarations.
@&cpdbTest\drop         
commit;
-- Reload the table declarations.
@&cpdbTest\schema
commit;
-- Reload the data.
@&cpdbTest\data
commit;


