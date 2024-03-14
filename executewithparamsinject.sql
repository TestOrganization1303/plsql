CREATE OR REPLACE PROCEDURE executewithparamsinject(p_nameinout IN OUT varchar2, p_name IN varchar2, p_nameout OUT varchar2, p_nameimplict varchar2)
is
    propagated varchar2(300);
    STMT varchar2(300);
    STMT2 varchar2(300); 
    STMT3 varchar2(300);
BEGIN
    propagated := p_name; -- Propagates taint to `propagated` variable
    p_nameout := 'stroopwafels'; 

    STMT := 'INSERT INTO book_tbl (title, description) values (''inserted from inject1'', ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE STMT; -- No issue
    
    STMT2 := 'INSERT INTO book_tbl (title, description) values (''' || p_name || ''', ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE STMT2; -- CWEID 89, because `p_name` is directly concatenated into query. 

    EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || p_nameinout || ''', ''description of book inserted from inject1'')'; -- CWEID 89, because `p_nameinout` is directly concatenated into query and is both `IN` and `OUT` parameter.
    EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || p_nameimplict || ''', ''description of book inserted from inject1'')'; -- CWEID 89, because `p_nameimplict` is directly concatenated into query and implicit `IN` parameter.
    EXECUTE IMMEDIATE 'INSERT INTO book_tbl (title, description) values (''' || p_nameout || ''', ''description of book inserted from inject1'')'; -- No issue, because `p_nameout` is output parameter and not considered tainted.

    STMT3 := 'INSERT INTO book_tbl (title, description) values (:1, ''description of book inserted from inject1'')';
    EXECUTE IMMEDIATE STMT3 USING p_name; -- No issue, due to parameterized query with placeholders

    STMT3 := 'INSERT INTO book_tbl (title, description) values (:1, :2)';
    EXECUTE IMMEDIATE STMT3 USING p_name, p_nameinout; -- No issue, due to parameterized query with placeholders
    
    p_nameinout := 'amsterdam';

end executewithparamsinject;