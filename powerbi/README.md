> **DATA TRANSPARENCY — AI-SYNTHESIZED DATA**  
> All five datasets in this repository contain fictional, AI-generated synthetic HR records. They are **not real employee or company data**. All metrics and dashboard insights are illustrative and must not be interpreted as findings about a real organization.

# Power BI — Two-Page HR Retention Report

Open [`HR_Retention_Analytics.pbix`](HR_Retention_Analytics.pbix) in Power BI Desktop. This file contains two pages verified from the report definition:

## Page 1: Retention Analytics
Four cards (900 employees, 156 exited, 17.33% historical exit proportion, 744 without recorded exit), a department exit proportion chart, an exit distribution donut, and slicers for department, gender, and overtime.

![Retention Analytics](screenshots/retention_overview.png)

## Page 2: Workforce Risk Drivers
Charts comparing exit proportion by overtime, job satisfaction and work-life balance, plus average monthly salary by exit status. The second page exists in the `.pbix`, but a separate screenshot still needs to be exported from Power BI Desktop to `screenshots/workforce_risk_drivers.png`.

## Core DAX measures

The Power BI table name is shown below as imported. If your local model uses another table name, adjust it accordingly.

```dax
Total Employees = DISTINCTCOUNT('public vw_employee_retention'[employee_id])

Exited Employees =
CALCULATE(
    DISTINCTCOUNT('public vw_employee_retention'[employee_id]),
    'public vw_employee_retention'[attrition_flag] = 1
)

Attrition % = DIVIDE([Exited Employees], [Total Employees], 0)

Employees Without Exit = [Total Employees] - [Exited Employees]

Average Monthly Salary = AVERAGE('public vw_employee_retention'[monthly_salary_eur])
```

Format `Attrition %` as percentage with two decimals and `Average Monthly Salary` as EUR currency. A useful optional calculated column is:

```dax
Exit Status = IF('public vw_employee_retention'[attrition_flag] = 1, "Exited", "No Recorded Exit")
```

## Refreshing the dataset

The report imports `public.vw_employee_retention` from PostgreSQL database `hr_retention_analysis`. To connect it to your own local server, update **Transform data → Data source settings** and provide your own PostgreSQL credentials. Never commit passwords or tokens.

## Interpretation

The data are synthetic. Historical exit proportion is not an annualized turnover rate. Slicer selections change the denominator, so filtered percentages describe the selected employee segment.


## Dashboard screenshots

- [Retention Analytics](screenshots/retention_overview.png)
- [Workforce Risk Drivers](screenshots/workforce_risk_drivers.png)

Both screenshots were extracted from the author-supplied project evidence document.
