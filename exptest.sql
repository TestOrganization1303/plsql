set serveroutput on;

DROP TABLE book_tbl;
CREATE TABLE book_tbl (
    id number NOT NULL,
    title varchar2(1000),
    description varchar2(2000)
);

INSERT INTO book_tbl (id, title, description) VALUES (1, 'book one', 'This is the first book in the series.');
INSERT INTO book_tbl (id, title, description) VALUES (2, 'book two', 'This is the second book in the series.');

DROP SEQUENCE book_tbl_id_seq;
CREATE SEQUENCE book_tbl_id_seq START WITH 100;

CREATE TRIGGER book_tbl_id_trig 
BEFORE INSERT ON book_tbl
FOR EACH ROW
BEGIN
    SELECT book_tbl_id_seq.nextval INTO :new.id FROM DUAL;
END;
/

DROP PROCEDURE hello;
CREATE PROCEDURE hello(p_name in varchar2)
is
BEGIN
    DBMS_OUTPUT.PUT_LINE('hello, ' || p_name);
END;
/

DROP PROCEDURE inject1;
CREATE PROCEDURE inject1(p_name IN varchar2)
AS
    STMT VARCHAR2(250);
BEGIN
    STMT := 'INSERT INTO book_tbl (title, description) values (''inserted from inject1'', ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE stmt;
    STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_name || ''', ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE stmt;     -- CWEID 89
end;
/


DROP FUNCTION inject2;
CREATE FUNCTION inject2(p_title varchar2)
RETURN NUMBER
IS
    OKNAME VARCHAR2(200);
    BADNAME VARCHAR2(200);
BEGIN
    EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''inserted from inject2'', ''description of book inserted from inject2'')';
    EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from inject2'')';         -- CWEID 89
    OKNAME := 'TAOCP';
    BADNAME := 'something ' || p_title;
    EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || okname|| ''', ''description of book inserted from inject2'')';
    EXECUTE IMMEDIATE 'insert into book_tbl (title, description) values (''' || badname || ''', ''description of book inserted from inject2'')';         -- CWEID 89
    RETURN 1;
END;
/

CREATE OR REPLACE PROCEDURE inject3(bookid IN varchar2)
AS
    X VARCHAR2(200);
    Y VARCHAR2(200);
    Z VARCHAR2(200);
    STMT VARCHAR2(300);
    TYPE books_tab IS TABLE OF book_tbl%rowtype;
    books books_tab;
BEGIN
    X := bookid;
    Y := '0' || X;
    Z := UPPER(X);

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || x;
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || y;
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || z;
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || ltrim(rtrim(z));
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || rtrim(z);
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || lower(z);
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || initcap(z);
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || substr(z, 0, 100);
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || lpad(z, 5, ' ');
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = ' || rpad(z, 5, ' ');
    execute immediate stmt BULK COLLECT into books;     -- CWEID 89

    STMT := 'SELECT * FROM book_tbl WHERE ID = 1';
    execute immediate stmt BULK COLLECT into books;

    STMT := 'INSERT INTO book_tbl (title, description) values (''inserted from inject3'', ''description of book inserted from inject3'')';
    EXECUTE IMMEDIATE stmt;
end inject3;
/


CREATE OR REPLACE PACKAGE exptest_pkg AS
    goodname varchar(200);

    badname0 varchar(200);
    badname1 varchar(200);
    badname2 varchar(200);
    badname3 varchar(200);
    badname4 varchar(200);
    badname5 varchar(200);
    badname6 varchar(200);
    badname7 varchar(200);
    badname8 varchar(200);
    badname9 varchar(200);
    badname10 varchar(200);
    badname11 varchar(200);
    badname12 varchar(200);
    badname13 varchar(200);
    badname14 varchar(200);
    badname15 varchar(200);
    badname16 varchar(200);
    badname17 varchar(200);
    badname18 varchar(200);
    badname19 varchar(200);
    badname20 varchar(200);
    badname21 varchar(200);
    badname22 varchar(200);
    badname23 varchar(200);
    badname24 varchar(200);
    badname25 varchar(200);
    badname26 varchar(200);
    badname27 varchar(200);
    badname28 varchar(200);
    badname29 varchar(200);
    PROCEDURE insert1(p_title varchar2);
    PROCEDURE delayed_insert;
END exptest_pkg;
/

CREATE OR REPLACE PACKAGE BODY exptest_pkg AS
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
        EXECUTE IMMEDIATE stmt;
    end insert4;

    function passthrough(str_arg varchar2)
    return varchar2
    is
    begin
        return 'PT' || str_arg;
    end passthrough;


    PROCEDURE insert1(p_title varchar2)
    IS
        STMT VARCHAR2(250);
    BEGIN
        STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from insert1'')';
        goodname := 'TAOCP';
        badname0 := p_title;
        badname1 := asciistr(p_title);
        badname2 := compose(p_title);
        badname3 := coalesce(NULL, p_title);
        badname4 := concat('foo', p_title);
        badname5 := concat(p_title, 'foo');
        badname6 := convert(p_title, 'US7ASCII', 'US7ASCII');
        badname7 := decompose(p_title);
        badname8 := greatest('less', 'less', p_title);
        badname9 := least('less', 'less', p_title);
        badname10 := nvl(p_title, 'foo');
        badname11 := nvl(null, p_title);
        badname12 := nls_initcap(p_title);
        badname13 := nls_lower(p_title);
        badname14 := nls_upper(p_title);
        badname15 := nullif(p_title, 'TAOCP');
        badname16 := nvl(p_title, 'one');
        badname17 := nvl(null, p_title);
        badname18 := passthrough(p_title);
        badname19 := regexp_replace(p_title, 'foo', 'bar');
        badname20 := regexp_substr(p_title, '.+');
        badname21 := replace(p_title, 'foo', 'bar');
        badname22 := replace('foo', 'o', p_title);
        badname23 := to_char(p_title);
        badname24 := to_char(to_clob(p_title));
        badname25 := to_nchar(p_title);
        badname26 := to_nchar(to_nclob(p_title));
        badname27 := translate(p_title, 'foo', 'bar');
        badname28 := trim(p_title);
        badname29 := unistr(p_title);

        EXECUTE IMMEDIATE stmt;     -- CWEID 89
        exptest_pkg.insert3('hmm' || p_title);
        exptest_pkg.insert4('TAOCP');
    end insert1;

    PROCEDURE delayed_insert
    IS
    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || goodname || ''', ''description of book inserted from delayed_insert'')';

        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname0 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname1 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname2 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname3 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname4 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname5 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname6 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname7 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname8 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname9 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname10 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname11 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname12 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname13 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname14 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname15 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname16 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname17 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname18 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname19 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname20 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname21 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname22 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname23 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname24 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname25 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname26 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname27 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname28 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89
        EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || badname29 || ''', ''description of book inserted from delayed_insert'')';        -- CWEID 89

    END delayed_insert;

    PROCEDURE insert2(p_title varchar2)
    IS
        STMT VARCHAR2(250);
    BEGIN
        STMT := 'INSERT INTO book_tbl (title, description) values (''' || p_title || ''', ''description of book inserted from insert2'')';
        EXECUTE IMMEDIATE stmt;
    end insert2;

END exptest_pkg;
/

CREATE OR REPLACE PROCEDURE inject5(descr_p in varchar2)
is
    type cur_t is ref cursor;
    type numlist is table of number;
    stmt varchar2(300);
    cv cur_t;
    cursval integer;
    foo_exc exception;
    retval integer;
    ids numlist;
begin
    open cv for 'select id from book_tbl';
    fetch cv bulk collect into ids;
    close cv;

    open cv for 'select id from book_tbl where description = ''' || descr_p || ' ''';       -- CWEID 89
    fetch cv bulk collect into ids;
    close cv;

    stmt := 'select id from book_tbl where description = ''' || descr_p || ' ''';
    open cv for stmt;       -- CWEID 89
    fetch cv bulk collect into ids;
    close cv;

    raise foo_exc;

exception
    when foo_exc then
        dbms_output.put_line('exception');

        cursval := dbms_sql.open_cursor;
        dbms_sql.parse(cursval, 'INSERT INTO book_tbl (title) values (''WWWWWWWWWWWWWWWWWWWWW'')', DBMS_SQL.NATIVE);
        retval := dbms_sql.execute(cursval);
        dbms_sql.close_cursor(cursval);

        cursval := dbms_sql.open_cursor;
        dbms_sql.parse(cursval, 'INSERT INTO book_tbl (title) values (''' || descr_p || ''')', DBMS_SQL.NATIVE);       -- CWEID 89
        retval := dbms_sql.execute(cursval);
        dbms_sql.close_cursor(cursval);

end inject5;
/

CREATE OR REPLACE PROCEDURE inject6(descr_p in varchar2)
is
    type cur_t is ref cursor;
    type numlist is table of number;
    stmt varchar2(300);
    cv cur_t;
    cursval integer;
    foo_exc exception;
    retval integer;
    ids numlist;
begin
    open cv for select id from book_tbl;
    fetch cv bulk collect into ids;
    close cv;
    dbms_output.put_line('ids has ' || ids.COUNT || ' elements');

    open cv for select id from book_tbl where description like '%' || descr_p || '%';
    fetch cv bulk collect into ids;
    close cv;
    dbms_output.put_line('ids has ' || ids.COUNT || ' elements');

end inject6;
/


