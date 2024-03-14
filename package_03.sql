CREATE OR REPLACE PACKAGE BODY packagetwofuncs AS
    PROCEDURE insert3(p_title varchar2)
    IS
        STMT VARCHAR2(250);
    BEGIN
        STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from insert3'')';
        EXECUTE IMMEDIATE stmt; -- CWEID 89
    end insert3;

    PROCEDURE insert4(p_title varchar2)
    IS
        STMT VARCHAR2(250);
    BEGIN
        STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from insert4'')';
        EXECUTE IMMEDIATE stmt; -- CWEID 89
    end insert4;

    FUNCTION inject1(p_title varchar2)
    RETURN NUMBER
    IS
        OKNAME VARCHAR2(200);
        BADNAME VARCHAR2(200);
    BEGIN
        EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''inserted from inject2'', ''description of book inserted from inject2'')';
        EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from inject2'')'; -- CWEID 89
        OKNAME := 'TAOCP';
        BADNAME := 'something ' || p_title;
        EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || okname|| ''', ''description of book inserted from inject2'')';
        EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || badname || ''', ''description of book inserted from inject2'')'; -- CWEID 89
        RETURN 1;
    END inject1;

    FUNCTION inject2(p_title varchar2)
    RETURN NUMBER
    IS
        OKNAME VARCHAR2(200);
        BADNAME VARCHAR2(200);
    BEGIN
        EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''inserted from inject2'', ''description of book inserted from inject2'')';
        EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from inject2'')'; --CWEID 89
        OKNAME := 'TAOCP';
        BADNAME := 'something ' || p_title;
        EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || okname|| ''', ''description of book inserted from inject2'')';
        EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || badname || ''', ''description of book inserted from inject2'')'; --CWEID 89
        RETURN 2;
    END inject2;

    PROCEDURE insert1(p_title varchar2)
    IS
        STMT VARCHAR2(250);
    BEGIN
        STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from insert1'')';
        EXECUTE IMMEDIATE stmt;     -- CWEID 89
        packagetwofuncs.insert3('hmm' || p_title);
        packagetwofuncs.insert4('TAOCP');
    end insert1;

    PROCEDURE insert2(p_title varchar2)
    IS
        STMT VARCHAR2(250);
    BEGIN
        STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from insert2'')';
        EXECUTE IMMEDIATE stmt; -- CWEID 89
    end insert2;

END packagetwofuncs;
/