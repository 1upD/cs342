-- Look at the scehema of dual
DESCRIBE dual

-- There is one column in dual. It is called 'Dummy'.
-- Dummy is non-nullable and stores a varchar with length 1

-- Look at the contents of dual
SELECT * from dual

-- There is one value in dual. It is the letter X.

-- I can't really understand the purpose of this table. 
-- It may have been used for unit testing or maybe the X has 
-- some sort of implicit meaning that I don't understand.