-- Bank Loan Analysis
SELECT
	*
FROM
	bank_loan;

-- KPI's Requirement
-- Total Loan Applications
SELECT
	COUNT(id) AS total_loan_applications
FROM
	bank_loan;

-- Total Loan Applications by Month to Date
SELECT
	COUNT(id) AS mtd_loan_applications
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT
	COUNT(id) AS pmtd_loan_applications
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Total Funded Amount
SELECT
	SUM(loan_amount) AS mtd_total_funded_amt
FROM
	bank_loan
WHERE 
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT
	SUM(loan_amount) AS pmtd_total_funded_amt
FROM
	bank_loan
WHERE 
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Total Amount Received
-- MTD Total Amount Received
SELECT
	SUM(total_payment) AS mtd_total_amt_received
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD Total Amount Received
SELECT
	SUM(total_payment) AS mtd_total_amt_received
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Average Interest Rate
-- MTD
SELECT
	ROUND(AVG(int_rate),4) * 100 AS mtd_avg_int_rate
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD
SELECT
	ROUND(AVG(int_rate),4) * 100 AS pmtd_avg_int_rate
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Average Debt-to-income
-- MTD
SELECT
	ROUND(AVG(dti),4) * 100 AS mtd_avg_dti
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD
SELECT
	AVG(dti) * 100 AS pmtd_avg_dti
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Good Loan's KPI
-- Good Loan applications %
SELECT
	COUNT(CASE WHEN loan_status = 'Fully Paid' or loan_status = 'Current' THEN id END) * 100
	/
	COUNT(id) AS good_loan_ptg
FROM
	bank_loan;

-- Good Loan applications
SELECT
	COUNT(id) AS good_loan_applications
FROM
	bank_loan
WHERE
	loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Funded Amount
SELECT
	SUM(loan_amount) AS good_loan_funded_amt
FROM
	bank_loan
WHERE
	loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Total Received amount
SELECT
	SUM(total_payment) AS good_loan_total_received_amt
FROM
	bank_loan
WHERE
	loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Bad Loan's KPI
-- Bad Loan Applications Percentage
SELECT
	COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0
	/
	COUNT(id) AS bad_loan_ptg
FROM
	bank_loan;

-- Bad Loan Applications
SELECT
	COUNT(id) AS bad_loan_applications
FROM
	bank_loan
WHERE
	loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT
	SUM(loan_amount) AS bad_loan_funded_amt
FROM
	bank_loan
WHERE
	loan_status = 'Charged Off';

-- Bad Loan Total Received Amount
SELECT
	SUM(total_payment) AS bad_loan_total_received_amt
FROM
	bank_loan
WHERE
	loan_status = 'Charged Off';

-- Loan Status
SELECT
	loan_status,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount,
	AVG(int_rate) AS avg_int_rate,
	AVG(dti) AS avg_dti
FROM
	bank_loan
GROUP BY loan_status
ORDER BY total_received_amount DESC;

-- Loan Status by MTD
SELECT
	loan_status,
	SUM(loan_amount) AS mtd_funded_amount,
	SUM(total_payment) AS mtd_total_received
FROM
	bank_loan
WHERE
	MONTH(issue_date) = 12
GROUP BY loan_status;

SELECT
	MONTH(issue_date) AS month_number,
	DATENAME(MONTH, issue_date) AS month_name,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount,
	AVG(int_rate) AS avg_int_rate,
	AVG(dti) AS avg_dti
FROM
	bank_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY month_number;

-- State
SELECT
	address_state,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_payment_amount
FROM
	bank_loan
GROUP BY address_state
ORDER BY address_state;

-- Terms
SELECT
	term,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_payment_amount
FROM
	bank_loan
GROUP BY term
ORDER BY term;

-- Employees Length
SELECT
	emp_length,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_payment_amount
FROM
	bank_loan
GROUP BY emp_length
ORDER BY emp_length;

-- Purpose
SELECT
	purpose,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_payment_amount
FROM
	bank_loan
GROUP BY purpose
ORDER BY purpose;

-- Home Ownership
SELECT
	home_ownership,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_payment_amount
FROM
	bank_loan
GROUP BY home_ownership
ORDER BY home_ownership;

-- Grade
SELECT
	grade,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_payment_amount
FROM
	bank_loan
GROUP BY grade
ORDER BY grade;