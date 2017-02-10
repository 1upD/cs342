-- Run common, helpful formatting setting for the course databases.
-- To work, Windows cmd must also be configured to have window/buffer widths of 200.
-- Run this by calling @format as needed.

-- General output settings
SET LINES 200;   
SET TRIMOUT ON;  
SET PAGES 1000;

-- Formatting for wide columns
COLUMN age FORMAT 999;
COLUMN aid FORMAT 99;
COLUMN code FORMAT A3;
COLUMN department FORMAT A5;
COLUMN email FORMAT A8;
COLUMN firstname FORMAT A15;
COLUMN lastname FORMAT A15;
COLUMN fullname FORMAT A20;
COLUMN id FORMAT 999999;
COLUMN name FORMAT A35;
COLUMN professor FORMAT A18;
COLUMN semester FORMAT A2;
COLUMN year FORMAT 9999;
COLUMN column_name FORMAT A10;