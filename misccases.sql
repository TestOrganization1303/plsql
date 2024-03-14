set serveroutput on;

drop table departments;

create table departments (
    department_id number
);

DROP TABLE dept_temp;
CREATE TABLE dept_temp AS
  SELECT * FROM departments;

CREATE OR REPLACE PROCEDURE p (
  dept_no NUMBER
) AUTHID CURRENT_USER AS
BEGIN
  DELETE FROM dept_temp
  WHERE department_id = dept_no;

  IF SQL%FOUND THEN
    DBMS_OUTPUT.PUT_LINE (
      'Delete succeeded for department number ' || dept_no
    );
  ELSE
    DBMS_OUTPUT.PUT_LINE ('No department number ' || dept_no);
  END IF;
END;
/
BEGIN
  p(270);
  p(400);
END;
/

drop table employees;
create table employees (
    manager_id number(6),
    salary number(9),
    last_name varchar(200)
);



DECLARE
  CURSOR c1 IS
    SELECT last_name, salary FROM employees
    WHERE ROWNUM < 11
    ORDER BY last_name;

  my_ename   employees.last_name%TYPE;
  my_salary  employees.salary%TYPE;
BEGIN
  OPEN c1;
  LOOP
    FETCH c1 INTO my_ename, my_salary;
    IF c1%FOUND THEN  -- fetch succeeded
      DBMS_OUTPUT.PUT_LINE('Name = ' || my_ename || ', salary = ' || my_salary);
    ELSE  -- fetch failed
      EXIT;
    END IF;
  END LOOP;
END;
/

drop table employees_temp;
CREATE TABLE employees_temp AS
  SELECT * FROM employees;

DECLARE
  mgr_no NUMBER(6) := 122;
BEGIN
  DELETE FROM employees_temp WHERE manager_id = mgr_no;
  DBMS_OUTPUT.PUT_LINE ('Number of employees deleted: ' || TO_CHAR(SQL%ROWCOUNT));
  DBMS_OUTPUT.PUT_LINE ('Number of employees deleted: ' || TO_CHAR(SQL%BULK_ROWCOUNT(0)));
  DBMS_OUTPUT.PUT_LINE ('Number of employees deleted: ' || TO_CHAR(SQL%BULK_EXCEPTIONS.count));
  DBMS_OUTPUT.PUT_LINE ('Number of employees deleted: ' || TO_CHAR(SQL%BULK_EXCEPTIONS(0).error_index));
  DBMS_OUTPUT.PUT_LINE ('Number of employees deleted: ' || TO_CHAR(SQL%BULK_EXCEPTIONS(0).error_code));
END;
/
