-- RUN THIS SCRIPT INSIDE THE hr_retention_analysis DATABASE (create it first in pgAdmin).
-- All five tables are original for this assignment. Do not run on existing important tables.
DROP TABLE IF EXISTS employee_exits CASCADE;
DROP TABLE IF EXISTS performance_reviews CASCADE;
DROP TABLE IF EXISTS contracts CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
CREATE TABLE departments (
  department_id INTEGER PRIMARY KEY,
  department_name VARCHAR(80) NOT NULL UNIQUE,
  office_city VARCHAR(60) NOT NULL,
  division VARCHAR(50) NOT NULL,
  annual_budget_eur NUMERIC(13,2) NOT NULL CHECK(annual_budget_eur>=0),
  active BOOLEAN NOT NULL
);

CREATE TABLE employees (
  employee_id INTEGER PRIMARY KEY,employee_code VARCHAR(12) NOT NULL UNIQUE,first_name VARCHAR(60) NOT NULL,last_name VARCHAR(60) NOT NULL,age SMALLINT NOT NULL CHECK(age BETWEEN 18 AND 75),gender VARCHAR(20),department_id INTEGER NOT NULL REFERENCES departments(department_id),job_title VARCHAR(90) NOT NULL,hire_date DATE NOT NULL,employment_status VARCHAR(12) NOT NULL CHECK(employment_status IN ('Active','Exited')),
  work_arrangement VARCHAR(12) NOT NULL,
  job_level SMALLINT NOT NULL CHECK(job_level BETWEEN 1 AND 5),
  education_level VARCHAR(30),
  commute_km INTEGER CHECK(commute_km>=0),
  overtime BOOLEAN NOT NULL,
  job_satisfaction SMALLINT CHECK(job_satisfaction BETWEEN 1 AND 4),
  work_life_balance SMALLINT CHECK(work_life_balance BETWEEN 1 AND 4),
  monthly_salary_eur NUMERIC(10,2) NOT NULL CHECK(monthly_salary_eur>0),
  currency CHAR(3) NOT NULL,
  contract_type VARCHAR(20) NOT NULL,
  full_time BOOLEAN NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE contracts (
  contract_id INTEGER PRIMARY KEY,
  employee_id INTEGER NOT NULL UNIQUE REFERENCES employees(employee_id),
  start_date DATE NOT NULL,
  end_date DATE,
  monthly_base_eur NUMERIC(10,2) NOT NULL,
  annual_base_eur NUMERIC(12,2) NOT NULL,
  weekly_hours SMALLINT NOT NULL,
  bonus_target_pct NUMERIC(5,2) NOT NULL,
  is_signed BOOLEAN NOT NULL
);

CREATE TABLE performance_reviews (
  review_id INTEGER PRIMARY KEY,
  employee_id INTEGER NOT NULL REFERENCES employees(employee_id),
  review_date DATE NOT NULL,
  performance_rating SMALLINT NOT NULL CHECK(performance_rating BETWEEN 1 AND 5),
  job_satisfaction SMALLINT CHECK(job_satisfaction BETWEEN 1 AND 4),
  manager_support_rating SMALLINT CHECK(manager_support_rating BETWEEN 1 AND 4),
  work_life_balance SMALLINT CHECK(work_life_balance BETWEEN 1 AND 4),
  training_hours INTEGER NOT NULL,
  promotion_readiness SMALLINT NOT NULL,
  review_outcome VARCHAR(40) NOT NULL,
  development_plan BOOLEAN NOT NULL
);

CREATE TABLE employee_exits (
  exit_id INTEGER PRIMARY KEY,
  employee_id INTEGER NOT NULL UNIQUE REFERENCES employees(employee_id),
  exit_date DATE NOT NULL,
  exit_reason VARCHAR(60) NOT NULL,
  exit_interview_completed BOOLEAN NOT NULL,
  regrettable_exit BOOLEAN NOT NULL,
  final_settlement_eur NUMERIC(10,2) NOT NULL
);

CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_reviews_employee ON performance_reviews(employee_id);
