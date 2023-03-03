CREATE TABLE IF NOT EXISTS departments (
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS titles (
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(50) NOT NULL
);


CREATE TABLE IF NOT EXISTS employees (
	emp_no INTEGER PRIMARY KEY,
	emp_title_id VARCHAR(5) NOT NULL,
	birth_date TIMESTAMP,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date TIMESTAMP NOT NULL,
	FOREIGN KEY(emp_title_id) 
		REFERENCES titles(title_id)
);

CREATE TABLE IF NOT EXISTS dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INTEGER NOT NULL,
	FOREIGN KEY(dept_no) 
		REFERENCES departments(dept_no),
	FOREIGN KEY(emp_no) 
		REFERENCES employees(emp_no)
);


CREATE TABLE IF NOT EXISTS dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY(emp_no) 
		REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) 
		REFERENCES departments(dept_no)
);


CREATE TABLE IF NOT EXISTS salaries (
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	FOREIGN KEY(emp_no) 
		REFERENCES employees(emp_no)
);


-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e FULL OUTER JOIN salaries as s
ON e.emp_no = s.emp_no;


-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE extract(year from hire_date) = 1986;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, dept_name, emp_no, last_name, first_name
FROM employees as e FULL OUTER JOIN salaries as s

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments as d FULL OUTER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
INNER JOIN employees as e
on e.emp_no = dm.emp_no


-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no, e.last_name, e.first_name, de.emp_no, d.dept_name
FROM departments as d FULL OUTER JOIN dept_emp as de
ON d.dept_no = de.dept_no
INNER JOIN employees as e
on e.emp_no = de.emp_no


-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE (first_name = 'Hercules') and (last_name like 'B%');


-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name FROM
dept_emp as de
INNER JOIN employees as e
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'


-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM
dept_emp as de
INNER JOIN employees as e
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' or d.dept_name = 'Development'


-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, count(last_name) as Frequency
FROM employees
GROUP BY last_name
order by frequency DESC;

