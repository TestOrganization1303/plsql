set serveroutput on;
drop table departments;

create table departments (
    department_id number,
    name varchar2(200)
);

INSERT INTO departments (department_id, name) values (1, 'one');
INSERT INTO departments (department_id, name) values (2, 'two');


create or replace procedure dofrom
is
begin
    delete from departments where department_id = 31337;
    if sql% found then
        dbms_output.put_line('found');
    else
        dbms_output.put_line('not found');
    end if;
end dofrom;
/

