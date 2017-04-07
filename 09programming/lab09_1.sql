SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;

-- there is a benefit to using either COUNT(1) , COUNT(*) or SUM(1) for simple counting queries.
SELECT COUNT(1) FROM Movie;

		-- Elapsed: 00:00:00.00
		-- Execution Plan
		----------------------------------------------------------
		-- Plan hash value: 30510313

		-----------------------------------------------------------------------------
		--| Id  | Operation             | Name        | Rows  | Cost (%CPU)| Time     |
		-------------------------------------------------------------------------------
		--|   0 | SELECT STATEMENT      |             |     1 |   222   (1)| 00:00:03 |
		--|   1 |  SORT AGGREGATE       |             |     1 |            |          |
		--|   2 |   INDEX FAST FULL SCAN| SYS_C007041 |   388K|   222   (1)| 00:00:03 |
		-------------------------------------------------------------------------------


		--Statistics
		------------------------------------------------------------
		--          1  recursive calls
		--          0  db block gets
		--        805  consistent gets
		--          0  physical reads
		--          0  redo size
		--        528  bytes sent via SQL*Net to client
		--        523  bytes received via SQL*Net from client
		--          2  SQL*Net roundtrips to/from client
		--         0  sorts (memory)
		--          0  sorts (disk)
		--          1  rows processed

SELECT COUNT(*) FROM Movie;

		-- Elapsed: 00:00:00.01

		-- Execution Plan
		------------------------------------------------------------
		--Plan hash value: 30510313
		--
		-------------------------------------------------------------------------------
		--| Id  | Operation             | Name        | Rows  | Cost (%CPU)| Time     |
		-------------------------------------------------------------------------------
		--|   0 | SELECT STATEMENT      |             |     1 |   222   (1)| 00:00:03 |
		--|   1 |  SORT AGGREGATE       |             |     1 |            |          |
		--|   2 |   INDEX FAST FULL SCAN| SYS_C007041 |   388K|   222   (1)| 00:00:03 |
		-------------------------------------------------------------------------------


		--Statistics
		------------------------------------------------------------
		--          1  recursive calls
		--          0  db block gets
		--        805  consistent gets
		--          0  physical reads
		--          0  redo size
		--        528  bytes sent via SQL*Net to client
		--        523  bytes received via SQL*Net from client
		--          2  SQL*Net roundtrips to/from client
		--          0  sorts (memory)
		--          0  sorts (disk)
		--          1  rows processed

SELECT SUM(1) FROM Movie;

		-- Elapsed: 00:00:00.01
		--
		--Execution Plan
		------------------------------------------------------------
		--Plan hash value: 30510313

		-------------------------------------------------------------------------------
		--| Id  | Operation             | Name        | Rows  | Cost (%CPU)| Time     |
		-------------------------------------------------------------------------------
		--|   0 | SELECT STATEMENT      |             |     1 |   222   (1)| 00:00:03 |
		--|   1 |  SORT AGGREGATE       |             |     1 |            |          |
		--|   2 |   INDEX FAST FULL SCAN| SYS_C007041 |   388K|   222   (1)| 00:00:03 |
		-------------------------------------------------------------------------------


		--Statistics
		------------------------------------------------------------
		--          1  recursive calls
		--          0  db block gets
		--        805  consistent gets
		--          0  physical reads
		--          0  redo size
		--        526  bytes sent via SQL*Net to client
		--        523  bytes received via SQL*Net from client
		--          2  SQL*Net roundtrips to/from client
		--          0  sorts (memory)
		--          0  sorts (disk)
		--          1  rows processed


-- There was not a noticable benefit from using any of the options.

--------------------------------------------------------------------------------------------------
-- Does the order of the tables listed in the FROM clause affects the way Oracle executes a join query.?
--------------------------------------------------------------------------------------------------
SELECT Count(1)
FROM Movie, Role
WHERE Role.MovieID = Movie.ID;

		-- Elapsed: 00:00:00.06

		-- Execution Plan
		-- ----------------------------------------------------------
		-- Plan hash value: 730482907

		-- ---------------------------------------------------------------------------
		-- | Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
		-- ---------------------------------------------------------------------------
		-- |   0 | SELECT STATEMENT   |      |     1 |     5 |  3156   (1)| 00:00:38 |
		-- |   1 |  SORT AGGREGATE    |      |     1 |     5 |            |          |
		-- |*  2 |   TABLE ACCESS FULL| ROLE |  3432K|    16M|  3156   (1)| 00:00:38 |
		-- ---------------------------------------------------------------------------

		-- Predicate Information (identified by operation id):
		-- ---------------------------------------------------

		   -- 2 - filter("ROLE"."MOVIEID" IS NOT NULL)


		-- Statistics
		-- ----------------------------------------------------------
				  -- 0  recursive calls
				  -- 0  db block gets
			  -- 11517  consistent gets
				  -- 0  physical reads
				  -- 0  redo size
				-- 529  bytes sent via SQL*Net to client
				-- 523  bytes received via SQL*Net from client
				  -- 2  SQL*Net roundtrips to/from client
				  -- 0  sorts (memory)
				  -- 0  sorts (disk)
				  -- 1  rows processed
		  
SELECT Count(1)
FROM Role, Movie
WHERE Role.MovieID = Movie.ID;

		-- Elapsed: 00:00:00.06

		-- Execution Plan
		-- ----------------------------------------------------------
		-- Plan hash value: 730482907

		-- ---------------------------------------------------------------------------
		-- | Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
		-- ---------------------------------------------------------------------------
		-- |   0 | SELECT STATEMENT   |      |     1 |     5 |  3156   (1)| 00:00:38 |
		-- |   1 |  SORT AGGREGATE    |      |     1 |     5 |            |          |
		-- |*  2 |   TABLE ACCESS FULL| ROLE |  3432K|    16M|  3156   (1)| 00:00:38 |
		-- ---------------------------------------------------------------------------

		-- Predicate Information (identified by operation id):
		-- ---------------------------------------------------

		   -- 2 - filter("ROLE"."MOVIEID" IS NOT NULL)


		-- Statistics
		-- ----------------------------------------------------------
				  -- 1  recursive calls
				  -- 0  db block gets
			  -- 11517  consistent gets
				  -- 0  physical reads
				  -- 0  redo size
				-- 529  bytes sent via SQL*Net to client
				-- 523  bytes received via SQL*Net from client
				  -- 2  SQL*Net roundtrips to/from client
				  -- 0  sorts (memory)
				  -- 0  sorts (disk)
				  -- 1  rows processed

-- No, the order of tables listed in a join query does not affect the performance of the query at all. Oracle must reorder the tables in whichever way it finds more efficient.

-------------------------------------------------------------------------------------------------------------------------------------------------		  
-- The use of arithmetic expressions in join conditions (e.g., FROM Table1 JOIN Table2 ON Table1.id+0=Table2.id+0 ) affects a query’s efficiency.
-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT Count(1) FROM
Movie JOIN Role
On Role.movieID = Movie.ID;

		-- Elapsed: 00:00:00.06

		-- Execution Plan
		-- ----------------------------------------------------------
		-- Plan hash value: 730482907

		-- ---------------------------------------------------------------------------
		-- | Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
		-- ---------------------------------------------------------------------------
		-- |   0 | SELECT STATEMENT   |      |     1 |     5 |  3156   (1)| 00:00:38 |
		-- |   1 |  SORT AGGREGATE    |      |     1 |     5 |            |          |
		-- |*  2 |   TABLE ACCESS FULL| ROLE |  3432K|    16M|  3156   (1)| 00:00:38 |
		-- ---------------------------------------------------------------------------

		-- Predicate Information (identified by operation id):
		-- ---------------------------------------------------

		   -- 2 - filter("ROLE"."MOVIEID" IS NOT NULL)


		-- Statistics
		-- ----------------------------------------------------------
				  -- 1  recursive calls
				  -- 0  db block gets
			  -- 11517  consistent gets
				  -- 0  physical reads
				  -- 0  redo size
				-- 529  bytes sent via SQL*Net to client
				-- 523  bytes received via SQL*Net from client
				  -- 2  SQL*Net roundtrips to/from client
				  -- 0  sorts (memory)
				  -- 0  sorts (disk)
				  -- 1  rows processed

SELECT Count(1) FROM
Movie JOIN Role
On Role.movieID + 1 = Movie.ID + 1;

		-- Elapsed: 00:00:00.89

		-- Execution Plan
		-- ----------------------------------------------------------
		-- Plan hash value: 1057883000

		-- --------------------------------------------------------------------------------
		-- --------------

		-- | Id  | Operation              | Name        | Rows  | Bytes |TempSpc| Cost (%CP
		-- U)| Time     |

		-- --------------------------------------------------------------------------------
		-- --------------

		-- |   0 | SELECT STATEMENT       |             |     1 |    10 |       | 43497  (8
		-- 6)| 00:08:42 |

		-- |   1 |  SORT AGGREGATE        |             |     1 |    10 |       |
		  -- |          |

		-- |*  2 |   HASH JOIN            |             |    13G|   124G|  6448K| 43497  (8
		-- 6)| 00:08:42 |

		-- |   3 |    INDEX FAST FULL SCAN| SYS_C007041 |   388K|  1895K|       |   222   (
		-- 1)| 00:00:03 |

		-- |   4 |    TABLE ACCESS FULL   | ROLE        |  3432K|    16M|       |  3155   (
		-- 1)| 00:00:38 |

		-- --------------------------------------------------------------------------------
		-- --------------


		-- Predicate Information (identified by operation id):
		-- ---------------------------------------------------

		   -- 2 - access("ROLE"."MOVIEID"+1="MOVIE"."ID"+1)


		-- Statistics
		-- ----------------------------------------------------------
				  -- 0  recursive calls
				  -- 0  db block gets
			  -- 12322  consistent gets
				  -- 0  physical reads
				  -- 0  redo size
				-- 529  bytes sent via SQL*Net to client
				-- 523  bytes received via SQL*Net from client
				  -- 2  SQL*Net roundtrips to/from client
				  -- 0  sorts (memory)
				  -- 0  sorts (disk)
				  -- 1  rows processed

-- Adding arithmetic operators to a join condition has a significant impact on performance.
				  
-----------------------------------------------------------------
-- running the same query more than once affects its performance.
-----------------------------------------------------------------
SELECT Count(1) FROM
Movie JOIN Role
On Role.movieID = Movie.ID;

		-- Elapsed: 00:00:00.06

		-- Execution Plan
		-- ----------------------------------------------------------
		-- Plan hash value: 730482907

		-- ---------------------------------------------------------------------------
		-- | Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
		-- ---------------------------------------------------------------------------
		-- |   0 | SELECT STATEMENT   |      |     1 |     5 |  3156   (1)| 00:00:38 |
		-- |   1 |  SORT AGGREGATE    |      |     1 |     5 |            |          |
		-- |*  2 |   TABLE ACCESS FULL| ROLE |  3432K|    16M|  3156   (1)| 00:00:38 |
		-- ---------------------------------------------------------------------------

		-- Predicate Information (identified by operation id):
		-- ---------------------------------------------------

		   -- 2 - filter("ROLE"."MOVIEID" IS NOT NULL)


		-- Statistics
		-- ----------------------------------------------------------
				  -- 0  recursive calls
				  -- 0  db block gets
			  -- 11517  consistent gets
				  -- 0  physical reads
				  -- 0  redo size
				-- 529  bytes sent via SQL*Net to client
				-- 523  bytes received via SQL*Net from client
				  -- 2  SQL*Net roundtrips to/from client
				  -- 0  sorts (memory)
				  -- 0  sorts (disk)
				  -- 1  rows processed
				  
		-- Elapsed: 00:00:00.06

		-- Execution Plan
		-- ----------------------------------------------------------
		-- Plan hash value: 730482907

		-- ---------------------------------------------------------------------------
		-- | Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
		-- ---------------------------------------------------------------------------
		-- |   0 | SELECT STATEMENT   |      |     1 |     5 |  3156   (1)| 00:00:38 |
		-- |   1 |  SORT AGGREGATE    |      |     1 |     5 |            |          |
		-- |*  2 |   TABLE ACCESS FULL| ROLE |  3432K|    16M|  3156   (1)| 00:00:38 |
		-- ---------------------------------------------------------------------------

		-- Predicate Information (identified by operation id):
		-- ---------------------------------------------------

		   -- 2 - filter("ROLE"."MOVIEID" IS NOT NULL)


		-- Statistics
		-- ----------------------------------------------------------
				  -- 0  recursive calls
				  -- 0  db block gets
			  -- 11517  consistent gets
				  -- 0  physical reads
				  -- 0  redo size
				-- 529  bytes sent via SQL*Net to client
				-- 523  bytes received via SQL*Net from client
				  -- 2  SQL*Net roundtrips to/from client
				  -- 0  sorts (memory)
				  -- 0  sorts (disk)
				  -- 1  rows processed
				  
-- Running the same query multiple times has no effect on performance.

-------------------------------------------------------------------------------------------------------------------
-- adding a concatenated index on a join table improves performance (see the create index command described above).
-------------------------------------------------------------------------------------------------------------------
CREATE INDEX RoleIndex ON Role(movieID, actorID);
-- ERROR at line 1:
-- ORA-01652: unable to extend temp segment by 128 in tablespace SYSTEM

-- I encountered a memory error while creating the index.