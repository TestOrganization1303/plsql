set serveroutput on;
drop table departments;

create table departments (
    department_id number,
    name varchar2(200)
);

INSERT INTO departments (department_id, name) values (1, 'one');
INSERT INTO departments (department_id, name) values (2, 'two');

CREATE OR REPLACE PACKAGE curstest
IS
PROCEDURE loadsomething;
END curstest;
/
show errors;


CREATE OR REPLACE PACKAGE BODY curstest
IS

    CURSOR c_whatever(name varchar2) IS
        SELECT * FROM departments
        WHERE department_id = 2
        ORDER BY department_id;

    PROCEDURE LoadSomething
    IS
        x_num   number;
        v_prev_partner number;
    BEGIN
      x_num := 5;
      IF (v_prev_partner <> 5) OR c_whatever%rowcount = 1 THEN
         x_num := c_whatever%rowcount;
      END IF;
      COMMIT;

    END LoadSomething;

END curstest;
/
show errors;
