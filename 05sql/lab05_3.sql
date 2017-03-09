-- Produce an appropriate phone-book entry for “traditional” family entries, e.g.:
-- VanderLinden, Keith and Brenda - 111-222-3333 - 2347 Oxford St.
SELECT (H.lastName || ', ' || H.firstName || ' and ' || W.firstName || ' - ' || Household.phoneNumber || ' - ' || Household.street ) AS phoneBookEntry 
FROM Person H, Person W, HouseHold
WHERE H.householdRole = 'husband' AND W.householdRole = 'wife' AND H.householdID = HouseHold.ID AND W.householdID = HouseHold.ID;

-- Extend your solution to handle families in which both spouses keep their own names, e.g.:
-- VanderLinden, Keith and Brenda Roorda - 111-222-3333 - 2347 Oxford St.
(SELECT (H.lastName || ', ' || H.firstName || ' and ' || W.firstName || ' - ' || Household.phoneNumber || ' - ' || Household.street ) AS phoneBookEntry 
FROM Person H, Person W, HouseHold
WHERE H.householdRole = 'husband' AND W.householdRole = 'wife' AND H.householdID = HouseHold.ID AND W.householdID = HouseHold.ID AND H.lastName = W.lastName)
UNION
(SELECT (H.lastName || ', ' || H.firstName || ' and ' || W.firstName || ' ' || W.lastName || ' - ' || Household.phoneNumber || ' - ' || Household.street ) AS phoneBookEntry 
FROM Person H, Person W, HouseHold
WHERE H.householdRole = 'husband' AND W.householdRole = 'wife' AND H.householdID = HouseHold.ID AND W.householdID = HouseHold.ID AND H.lastName <> W.lastName);

-- Finally, extend your solution to include single-adult families, e.g.:
-- Doe, Jane - 111-222-3333 - 2347 Main St.
SELECT * 
FROM ((SELECT (H.lastName || ', ' || H.firstName || ' and ' || W.firstName || ' - ' || Household.phoneNumber || ' - ' || Household.street ) AS phoneBookEntry 
FROM Person H, Person W, HouseHold
WHERE H.householdRole = 'husband' AND W.householdRole = 'wife' AND H.householdID = HouseHold.ID AND W.householdID = HouseHold.ID AND H.lastName = W.lastName)
UNION
(SELECT (H.lastName || ', ' || H.firstName || ' and ' || W.firstName || ' ' || W.lastName || ' - ' || Household.phoneNumber || ' - ' || Household.street ) AS phoneBookEntry 
FROM Person H, Person W, HouseHold
WHERE H.householdRole = 'husband' AND W.householdRole = 'wife' AND H.householdID = HouseHold.ID AND W.householdID = HouseHold.ID AND H.lastName <> W.lastName)
UNION
(SELECT (S.lastName || ', ' || S.firstName || ' - ' || Household.phoneNumber || ' - ' || Household.street ) AS phoneBookEntry 
FROM Person S, HouseHold
WHERE S.householdRole = 'single' AND S.householdID = HouseHold.ID))
ORDER BY phoneBookEntry;