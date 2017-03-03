-- Produce an appropriate phone-book entry for “traditional” family entries, e.g.:
-- VanderLinden, Keith and Brenda - 111-222-3333 - 2347 Oxford St.
SELECT (Husband.lastName || ', ' || Husband.firstName || ' and ' || Wife.firstName || ' - ' || Household.phoneNumber || '-' || Household.street ) AS phoneBookEntry 
FROM Person Husband, Person Wife, HouseHold HouseHold,
WHERE Husband.householdRole = 'Husband', Wife.householdRole = 'Wife', Husband.householdID = HouseHold.ID AND Wife.householdID = HouseHold.ID;

-- Extend your solution to handle families in which both spouses keep their own names, e.g.:
-- VanderLinden, Keith and Brenda Roorda - 111-222-3333 - 2347 Oxford St.

-- Finally, extend your solution to include single-adult families, e.g.:
-- Doe, Jane - 111-222-3333 - 2347 Main St.