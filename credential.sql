CREATE OR REPLACE procedure credential1(username in varchar2, password in varchar2)
is
begin
    DBMS_CLOUD.CREATE_CREDENTIAL(credential_name => 'foo', username => username, password => password); -- these 2 are acceptable
    DBMS_CLOUD.CREATE_CREDENTIAL('foo1', username, password);
    DBMS_CLOUD.DROP_CREDENTIAL(credential_name => 'foo');
    DBMS_CLOUD.DROP_CREDENTIAL('foo1');

    DBMS_CLOUD.CREATE_CREDENTIAL(credential_name => 'foo', username => 'admin', password => 'password123'); -- CWEID 798
    DBMS_CLOUD.CREATE_CREDENTIAL(credential_name => 'foo1', username => username, password => 'password123'); -- CWEID 798
    DBMS_CLOUD.CREATE_CREDENTIAL(credential_name => 'foo2', username => 'admin', password => password); -- CWEID 798

    DBMS_CLOUD.DROP_CREDENTIAL('foo');
    DBMS_CLOUD.DROP_CREDENTIAL('foo1');
    DBMS_CLOUD.DROP_CREDENTIAL('foo2');

    DBMS_CLOUD.CREATE_CREDENTIAL('foo', 'admin', 'password123'); -- CWEID 798
    DBMS_CLOUD.CREATE_CREDENTIAL('foo1', username, 'password123'); -- CWEID 798
    DBMS_CLOUD.CREATE_CREDENTIAL('foo2', 'admin', password); -- CWEID 798

    DBMS_CLOUD.UPDATE_CREDENTIAL('foo', 'PASSWORD', password); -- This is ok
    DBMS_CLOUD.UPDATE_CREDENTIAL('foo', 'PASSWORD', 'password123'); -- CWEID 798
    DBMS_CLOUD.UPDATE_CREDENTIAL('foo', 'USERNAME', username); -- This is ok
    DBMS_CLOUD.UPDATE_CREDENTIAL('foo', 'USERNAME', 'admin'); -- CWEID 798

    -- alternate syntax
    DBMS_CLOUD.UPDATE_CREDENTIAL( credential_name => 'foo', attribute => 'USERNAME', value => username); -- ok
    DBMS_CLOUD.UPDATE_CREDENTIAL( credential_name => 'foo', attribute => 'USERNAME', value => 'admin'); -- CWEID 798
    DBMS_CLOUD.UPDATE_CREDENTIAL( credential_name => 'foo', attribute => 'PASSWORD', value => password); -- ok
    DBMS_CLOUD.UPDATE_CREDENTIAL( credential_name => 'foo', attribute => 'PASSWORD', value => 'password123'); -- CWEID 798


    DBMS_CLOUD.DROP_CREDENTIAL('foo');
    DBMS_CLOUD.DROP_CREDENTIAL('foo1');
    DBMS_CLOUD.DROP_CREDENTIAL('foo2');


    -- syntax for DBMS_CREDENTIAL is essentially identical but there are 4 optional parameters for _CREATE
    DBMS_CREDENTIAL.CREATE_CREDENTIAL(credential_name => 'foo', username => username, password => password); -- these are acceptable
    DBMS_CREDENTIAL.CREATE_CREDENTIAL('foo1', username, password);
    DBMS_CREDENTIAL.CREATE_CREDENTIAL( credential_name => 'foo2', -- acceptable use with all optional parameters
                                        username => username,
                                        password => password,
                                        database_role => 'SYSDBA',
                                        windows_domain => 'somedomain',
                                        comments => 'a comment',
                                        enabled => TRUE
                                        );
    DBMS_CREDENTIAL.CREATE_CREDENTIAL( 'foo3', username, password, 'SYSDBA', 'somedomain', 'a comment', TRUE); -- using ordered parameter format

    DBMS_CREDENTIAL.DROP_CREDENTIAL(credential_name => 'foo');
    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo1');
    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo2');
    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo3');

    DBMS_CREDENTIAL.CREATE_CREDENTIAL(credential_name => 'foo', username => 'admin', password => 'password123'); -- CWEID 798
    DBMS_CREDENTIAL.CREATE_CREDENTIAL(credential_name => 'foo1', username => username, password => 'password123'); -- CWEID 798
    DBMS_CREDENTIAL.CREATE_CREDENTIAL(credential_name => 'foo2', username => 'admin', password => password); -- CWEID 798

    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo');
    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo1');
    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo2');

    DBMS_CREDENTIAL.CREATE_CREDENTIAL('foo', 'admin', 'password123'); -- CWEID 798
    DBMS_CREDENTIAL.CREATE_CREDENTIAL('foo1', username, 'password123'); -- CWEID 798
    DBMS_CREDENTIAL.CREATE_CREDENTIAL('foo2', 'admin', password); -- CWEID 798

    DBMS_CREDENTIAL.UPDATE_CREDENTIAL('foo', 'PASSWORD', password); -- This is ok
    DBMS_CREDENTIAL.UPDATE_CREDENTIAL('foo', 'PASSWORD', 'password123'); -- CWEID 798
    DBMS_CREDENTIAL.UPDATE_CREDENTIAL('foo', 'USERNAME', username); -- This is ok
    DBMS_CREDENTIAL.UPDATE_CREDENTIAL('foo', 'USERNAME', 'admin'); -- CWEID 798

    -- alternate syntax
    DBMS_CREDENTIAL.UPDATE_CREDENTIAL( credential_name => 'foo', attribute => 'USERNAME', value => username); -- ok
    DBMS_CREDENTIAL.UPDATE_CREDENTIAL( credential_name => 'foo', attribute => 'USERNAME', value => 'admin'); -- CWEID 798
    DBMS_CREDENTIAL.UPDATE_CREDENTIAL( credential_name => 'foo', attribute => 'PASSWORD', value => password); -- ok
    DBMS_CREDENTIAL.UPDATE_CREDENTIAL( credential_name => 'foo', attribute => 'PASSWORD', value => 'password123'); -- CWEID 798

    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo');
    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo1');
    DBMS_CREDENTIAL.DROP_CREDENTIAL('foo2');
end credential1;