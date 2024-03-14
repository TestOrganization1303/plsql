set serveroutput on;

create or replace procedure tcp1(host in varchar2)
is
    conn utl_tcp.connection;
    retval pls_integer;
    data varchar2(1024);
    baddata varchar2(2000);
    baddata2 nvarchar2(2000);
    baddata3 varchar2(2000);
    baddata4 nvarchar2(2000);
    badraw raw(2000);
begin
    conn := utl_tcp.open_connection('localhost', 44444);
    retval := utl_tcp.write_line(conn, 'hello');

    baddata := utl_tcp.get_line(conn, false, false);
    dbms_output.put_line(baddata);
    execute immediate substr(baddata, 5, 1000);     -- CWEID 89

    baddata2 := utl_tcp.get_line_nchar(conn, false, false);
    dbms_output.put_line(baddata2);
    execute immediate substr(baddata2, 5, 1000);     -- CWEID 89

    baddata3 := utl_tcp.get_text(conn, 100, false);
    dbms_output.put_line(baddata3);
    execute immediate substr(baddata3, 5, 1000);     -- CWEID 89

    baddata4 := utl_tcp.get_text_nchar(conn, 100, false);
    dbms_output.put_line(baddata4);
    execute immediate substr(baddata4, 5, 1000);     -- CWEID 89

    badraw := utl_tcp.get_raw(conn, 100, false);
    execute immediate substr(utl_raw.cast_to_varchar2(badraw), 5, 1000);    -- CWEID 89
utl_tcp.close_connection(conn);
end tcp1;
/

create or replace procedure tcp2(host in varchar2)
is
    conn utl_tcp.connection;
    retval pls_integer;
    data varchar2(1024);
    baddata varchar2(2000);
    baddata2 nvarchar2(2000);
    baddata3 varchar2(2000);
    baddata4 nvarchar2(2000);
    badraw raw(2000);
begin
    conn := utl_tcp.open_connection(host, 44444);       -- CWEID 441
    retval := utl_tcp.write_line(conn, 'hello');

    baddata := utl_tcp.get_line(conn, false, false);
    dbms_output.put_line(baddata);
    execute immediate substr(baddata, 5, 1000);     -- CWEID 89

    baddata2 := utl_tcp.get_line_nchar(conn, false, false);
    dbms_output.put_line(baddata2);
    execute immediate substr(baddata2, 5, 1000);     -- CWEID 89

    baddata3 := utl_tcp.get_text(conn, 100, false);
    dbms_output.put_line(baddata3);
    execute immediate substr(baddata3, 5, 1000);     -- CWEID 89

    baddata4 := utl_tcp.get_text_nchar(conn, 100, false);
    dbms_output.put_line(baddata4);
    execute immediate substr(baddata4, 5, 1000);     -- CWEID 89

    badraw := utl_tcp.get_raw(conn, 100, false);
    execute immediate substr(utl_raw.cast_to_varchar2(badraw), 5, 1000);    -- CWEID 89
utl_tcp.close_connection(conn);
end tcp2;
/

create or replace procedure tcp3(host in varchar2)
is
    conn utl_tcp.connection;
    retval pls_integer;
    data varchar2(1024);
    baddata varchar2(2000);
    baddata2 nvarchar2(2000);
    baddata3 varchar2(2000);
    baddata4 nvarchar2(2000);
    badraw raw(2000);
begin
    conn := utl_tcp.open_connection('localhost', 44444, host);       -- CWEID 441
    retval := utl_tcp.write_line(conn, 'hello');

    retval := utl_tcp.read_line(conn, baddata, false);
    dbms_output.put_line(baddata);
    execute immediate substr(baddata, 5, 1000);     -- CWEID 89

    retval := utl_tcp.read_text(conn, baddata2, 1000, false);
    dbms_output.put_line(baddata2);
    execute immediate substr(baddata2, 5, 1000);     -- CWEID 89

    retval := utl_tcp.read_raw(conn, badraw, 100, false);
    execute immediate substr(utl_raw.cast_to_varchar2(badraw), 5, 1000);    -- CWEID 89
    utl_tcp.close_connection(conn);
end tcp3;
/

create or replace procedure postcp1(host in varchar2, port in number)
is
    conn utl_tcp.connection;
    retval pls_integer;
    data varchar2(1024);
    baddata varchar2(2000);
    baddata2 nvarchar2(2000);
    baddata3 varchar2(2000);
    baddata4 nvarchar2(2000);
    badraw raw(2000);
begin
    conn := utl_tcp.open_connection(remote_port => port, remote_host => 'localhost', local_host => null, local_port => null, in_buffer_size => null, out_buffer_size => null, charset => null, newline => UTL_TCP.crlf, tx_timeout => null, wallet_path => 'wallet.dat', wallet_password => 'secret333');      -- CWEID 798
    retval := utl_tcp.write_line(conn, 'hello');

    baddata := utl_tcp.get_line(conn, false, false);
    dbms_output.put_line(baddata);
    execute immediate substr(baddata, 5, 1000);     -- CWEID 89

    baddata2 := utl_tcp.get_line_nchar(conn, false, false);
    dbms_output.put_line(baddata2);
    execute immediate substr(baddata2, 5, 1000);     -- CWEID 89

    baddata3 := utl_tcp.get_text(conn, 100, false);
    dbms_output.put_line(baddata3);
    execute immediate substr(baddata3, 5, 1000);     -- CWEID 89

    baddata4 := utl_tcp.get_text_nchar(conn, 100, false);
    dbms_output.put_line(baddata4);
    execute immediate substr(baddata4, 5, 1000);     -- CWEID 89

    badraw := utl_tcp.get_raw(conn, 100, false);
    execute immediate substr(utl_raw.cast_to_varchar2(badraw), 5, 1000);    -- CWEID 89
utl_tcp.close_connection(conn);
end postcp1;
/

create or replace procedure postcp2(host in varchar2, port in integer)
is
    conn utl_tcp.connection;
    retval pls_integer;
    data varchar2(1024);
    baddata varchar2(2000);
    baddata2 nvarchar2(2000);
    baddata3 varchar2(2000);
    baddata4 nvarchar2(2000);
    badraw raw(2000);
begin
    conn := utl_tcp.open_connection(remote_port => port, remote_host => host);      -- CWEID 441
    retval := utl_tcp.write_line(conn, 'hello');

    baddata := utl_tcp.get_line(conn, false, false);
    dbms_output.put_line(baddata);
    execute immediate substr(baddata, 5, 1000);     -- CWEID 89

    baddata2 := utl_tcp.get_line_nchar(conn, false, false);
    dbms_output.put_line(baddata2);
    execute immediate substr(utl_url.unescape(baddata2), 5, 1000);     -- CWEID 89

    baddata3 := utl_tcp.get_text(conn, 100, false);
    dbms_output.put_line(baddata3);
    execute immediate substr(utl_url.unescape(url_charset => 'null', url => baddata3), 5, 1000);     -- CWEID 89

    baddata4 := utl_tcp.get_text_nchar(conn, 100, false);
    dbms_output.put_line(baddata4);
    execute immediate substr(baddata4, 5, 1000);     -- CWEID 89

    badraw := utl_tcp.get_raw(conn, 100, false);
    execute immediate substr(utl_raw.cast_to_varchar2(badraw), 5, 1000);    -- CWEID 89
utl_tcp.close_connection(conn);
end postcp2;
/

create or replace procedure postcp3(host in varchar2)
is
    conn utl_tcp.connection;
    retval pls_integer;
    data varchar2(1024);
    baddata varchar2(2000);
    baddata2 nvarchar2(2000);
    baddata3 varchar2(2000);
    baddata4 nvarchar2(2000);
    badraw raw(2000);
begin
    conn := utl_tcp.open_connection(remote_host => 'localhost', local_host => host, remote_port => 44444);       -- CWEID 441
    retval := utl_tcp.write_line(conn, 'hello');

    retval := utl_tcp.read_line(data => baddata, c => conn, peek => false);
    dbms_output.put_line(baddata);
    execute immediate substr(utl_url.escape(baddata), 5, 1000);     -- CWEID 89

    retval := utl_tcp.read_text(data => baddata2, c => conn, len => 1000, peek => false);
    dbms_output.put_line(baddata2);
    execute immediate substr(utl_url.escape(escape_reserved_chars => false, url => baddata2), 5, 1000);     -- CWEID 89

    retval := utl_tcp.read_raw(data => badraw, c => conn, len => 100, peek => false);
    execute immediate substr(utl_raw.cast_to_varchar2(badraw), 5, 1000);    -- CWEID 89

    utl_tcp.close_connection(conn);
end postcp3;
/


