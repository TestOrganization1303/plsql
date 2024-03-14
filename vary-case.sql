set serveroutput on;

CREATE or replace PROCEDURE vary_inject1("p_name" IN varchar2)
AS
    STMT VARCHAR2(250);
    "P_NAME" varchar2(250);
BEGIN
    "P_NAME" := 'this is safe';
    STMT := 'INSERT INTO book_tbl (title, description) values (''inserted from inject1'', ''description of book inserted from inject1'')';
    DBMS_OUTPUT.PUT_LINE(stmt);

    -- EXECUTE IMMEDIATE stmt;
    STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_name || ''', ''description of book inserted from inject1'')';
    DBMS_OUTPUT.PUT_LINE(stmt);
    EXECUTE IMMEDIATE stmt;

    STMT := 'INSERT INTO book_tbl (title, description) values (''' || P_NAME || ''', ''description of book inserted from inject1'')';
    DBMS_OUTPUT.PUT_LINE(stmt);
    EXECUTE IMMEDIATE stmt;

    STMT := 'INSERT INTO book_tbl (title, description) values (''' || "P_NAME" || ''', ''description of book inserted from inject1'')';
    DBMS_OUTPUT.PUT_LINE(stmt);
    EXECUTE IMMEDIATE stmt;

    STMT := 'INSERT INTO book_tbl (title, description) values (''' || "p_name" || ''', ''description of book inserted from inject1'')';
    DBMS_OUTPUT.PUT_LINE(stmt);
    EXECUTE IMMEDIATE stmt;     -- CWEID 89
end;
/


CREATE or replace PROCEDURE vary_inject2("P_NAME" IN varchar2)
AS
    STMT VARCHAR2(250);
    "p_name" varchar2(250);
BEGIN
    "p_name" := 'this is safe';
    STMT := 'INSERT INTO book_tbl (title, description) values (''inserted from inject1'', ''description of book inserted from inject1'')';
    DBMS_OUTPUT.PUT_LINE(stmt);
    EXECUTE IMMEDIATE stmt;

    -- EXECUTE IMMEDIATE stmt;
    STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_name || ''', ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE stmt;     -- CWEID 89

    STMT := 'INSERT INTO book_tbl (title, description) values (''' || P_NAME || ''', ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE stmt;     -- CWEID 89

    STMT := 'INSERT INTO book_tbl (title, description) values (''' || "P_NAME" || ''', ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE stmt;     -- CWEID 89

    STMT := 'INSERT INTO book_tbl (title, description) values (''' || "p_name" || ''', ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE stmt;
end;
/
show errors;

create or replace procedure "vary_inject3"("foo" IN VARCHAR2)
as
    foo varchar2(100);
    "data" varchar2(10240);
    "DATA" varchar2(10240);
begin
    FOO := 'http://www.veracode.com';
    DBMS_OUTPUT.PUT_LINE(foo);
    DBMS_OUTPUT.PUT_LINE(FOO);
    DBMS_OUTPUT.PUT_LINE("foo");
    DBMS_OUTPUT.PUT_LINE("FOO");
    "data" := utl_http.request("foo", '', null, null);        -- CWEID 441
    "data" := "UTL_HTTP"."REQUEST"(foo, '', null, null);
    "data" := utl_http.request("FOO", '', null, null);
    "data" := utl_http.request(FOO, '', null, null);

end;
/



