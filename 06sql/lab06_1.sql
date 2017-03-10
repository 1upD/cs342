-- Get the names and mandate statements of all teams along with the ID of their “chair” member. If a chair member does not exist, include NULL for the ID.
SELECT Team.Name, Team.Mandate, PersonID
FROM Team LEFT OUTER JOIN (SELECT * FROM PersonTeam WHERE PersonTeam.Role = 'chair')
ON Team.Name = TeamName;

-- If you’re looking for a challenge, modify the previous query to return the chair person’s full name instead of just their ID.
SELECT Name, Mandate, PersonID, firstName, lastName
FROM Person RIGHT OUTER JOIN (Team LEFT OUTER JOIN (SELECT * FROM PersonTeam WHERE PersonTeam.Role = 'chair')
ON Team.Name = TeamName)
ON Person.ID = PersonID;