Level Design Database (LDDB) Prototype
Derek Dik (drd26)

How to Use:
From an Oracle account with admin privileges, run create.sql to create the lddbUser account. If you are using the system for production, replace 'bjarne' with your password in create.sql. 
The user lddbUser is now created with all of the tables populated.

After the user account is created, load.sql is run, which runs drop.sql, schema.sql, data.sql, queries.sql, procedures.ssql, and triggers.sql in that order.

There are a few stored procedures that can be used to submit a new review. The definitions of these stored procedures can be found in procedures.sql.
The first, submitChapterReview, reviews a chapter of a game. If the game review is not already started, it will start one for you. 
submitChatperReview requires parameters reviewedGameID, userID, chapterNum, datePlayed, chapterRating, minutesPlayed, and chapterComment.
Similarly, submitGameReview finishes your review. It requires parameters reviewedGameID, userID, userRating, and newReviewComment. It uses the current date as the date of review submission.

queries.sql contains definitions for useful views as well as a few query examples.

triggers.sql defines triggers which protect data integrity.