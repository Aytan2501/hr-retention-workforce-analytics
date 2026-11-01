-- Four analytical questions, compatible with 03_join_view.sql.
-- 1. Which departments have the highest exit proportions?
SELECT department_name,COUNT(*) AS total_employees,SUM(attrition_flag) AS exited_employees,
 ROUND(100.0*SUM(attrition_flag)/NULLIF(COUNT(*),0),2) AS attrition_percentage
FROM public.vw_employee_retention GROUP BY department_name ORDER BY attrition_percentage DESC;

-- 2. Is overtime associated with recorded exits?
SELECT overtime,COUNT(*) AS total_employees,SUM(attrition_flag) AS exited_employees,
 ROUND(100.0*SUM(attrition_flag)/NULLIF(COUNT(*),0),2) AS attrition_percentage
FROM public.vw_employee_retention GROUP BY overtime ORDER BY attrition_percentage DESC;

-- 3. How do exits differ across job satisfaction scores?
SELECT job_satisfaction,COUNT(*) AS total_employees,SUM(attrition_flag) AS exited_employees,
 ROUND(100.0*SUM(attrition_flag)/NULLIF(COUNT(*),0),2) AS attrition_percentage
FROM public.vw_employee_retention GROUP BY job_satisfaction ORDER BY job_satisfaction;

-- 4. How do average salaries compare between exit groups?
SELECT CASE WHEN attrition_flag=1 THEN 'Exited' ELSE 'No recorded exit' END AS employee_group,
 COUNT(*) AS total_employees,ROUND(AVG(monthly_salary_eur),2) AS average_monthly_salary_eur
FROM public.vw_employee_retention GROUP BY attrition_flag ORDER BY attrition_flag DESC;
