-- Run statements individually and screenshot query WITH its output.
-- Use a transaction and ROLLBACK so demonstration does not alter the original dataset.
BEGIN;
-- CREATE (INSERT): a new department, safe because it has no dependent records.
INSERT INTO departments(department_id,department_name,office_city,division,annual_budget_eur,active)
VALUES (99,'Workforce Innovation Lab','Bremen','Corporate',350000.00,TRUE)
RETURNING *;
-- READ (SELECT): retrieve the inserted record.
SELECT * FROM departments WHERE department_id=99;
-- UPDATE: modify exactly the inserted record.
UPDATE departments SET annual_budget_eur=375000.00 WHERE department_id=99 RETURNING *;
-- DELETE: delete exactly the inserted record.
DELETE FROM departments WHERE department_id=99 RETURNING *;
ROLLBACK;
-- Confirm it is absent after rollback.
SELECT * FROM departments WHERE department_id=99;
