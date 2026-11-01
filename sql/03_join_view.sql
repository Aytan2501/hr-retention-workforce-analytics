-- Matches the view built and verified in the student's pgAdmin session.
CREATE OR REPLACE VIEW public.vw_employee_retention AS
SELECT e.employee_id,e.employee_code,e.age,e.gender,d.department_name,d.office_city,
 e.job_title,e.hire_date,e.employment_status,e.overtime,e.job_satisfaction,
 e.work_life_balance,e.monthly_salary_eur,e.contract_type,c.weekly_hours,
 x.exit_date,x.exit_reason,
 CASE WHEN x.employee_id IS NOT NULL THEN 1 ELSE 0 END AS attrition_flag
FROM public.employees e
JOIN public.departments d ON e.department_id=d.department_id
LEFT JOIN public.contracts c ON e.employee_id=c.employee_id
LEFT JOIN public.employee_exits x ON e.employee_id=x.employee_id;

SELECT * FROM public.vw_employee_retention LIMIT 10;
SELECT COUNT(*) AS total_employees,SUM(attrition_flag) AS exited_employees,
 ROUND(100.0*SUM(attrition_flag)/NULLIF(COUNT(*),0),2) AS attrition_percentage
FROM public.vw_employee_retention;
