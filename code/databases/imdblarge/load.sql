-- This approach to loading the data takes around 2 hours.
-- Use the impdp utility if possible.

@drop         
commit;
@schema
commit;
SET DEFINE OFF
SET TERM ON
PROMPT loading actors...
SET TERM OFF
@data_actor
commit;
SET TERM ON
PROMPT loading directors...
SET TERM OFF
@data_director
commit;
SET TERM ON
PROMPT loading director/genres...
SET TERM OFF
@data_directorGenre
commit;
SET TERM ON
PROMPT loading movies...
SET TERM OFF
@data_movie
commit;
SET TERM ON
PROMPT loading movie/directors...
SET TERM OFF
@data_movieDirector
commit;
SET TERM ON
PROMPT loading movie/genres...
SET TERM OFF
@data_movieGenre
commit;
SET TERM ON
PROMPT loading roles...
SET TERM OFF
@data_role
commit;
SET TERM ON
SET DEFINE ON
