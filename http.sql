set serveroutput on;

create or replace procedure http1(username IN varchar2, password IN varchar2)
is
    hrq utl_http.req;
    hrs utl_http.resp;
    data varchar2(1024);
    gooddata varchar2(1024);
    hdrname varchar2(1024);
    hdrvalue varchar2(1024);
begin
    hrq := UTL_HTTP.BEGIN_REQUEST('http://www.veracode.com');
    UTL_HTTP.SET_AUTHENTICATION(hrq, username, password);       -- this is okay; variable derived from elsewhere
    UTL_HTTP.SET_AUTHENTICATION(hrq, 'admin', 'Secret123!');    -- CWEID 798
    UTL_HTTP.SET_AUTHENTICATION(hrq, 'admin', password);    -- CWEID 798
    UTL_HTTP.SET_AUTHENTICATION(hrq, username, 'Secret123!');    -- CWEID 798
    UTL_HTTP.SET_HEADER(hrq, 'X-Host', 'http://www.veracode.com');
    UTL_HTTP.SET_HEADER(hrq, 'X-Foo', 'hmm ' || username);              -- CWEID 441
    gooddata := upper('nothing to see here');
    hrs := utl_http.get_response(hrq);
    for i in 1..utl_http.get_header_count(hrs) loop
        utl_http.get_header(hrs, i, hdrname, hdrvalue);
        dbms_output.put_line('header: ' || hdrname || ': ' || hdrvalue);
        execute immediate substr(hdrname, 5, 100);                  -- CWEID 89
        execute immediate substr(hdrvalue, 5, 100);                 -- CWEID 89
    end loop;
    loop
        utl_http.read_line(hrs, data, true);
        dbms_output.put_line(data);
    end loop;
    execute immediate substr(data, 5, 100);                 -- CWEID 89
    execute immediate substr(gooddata, 5, 100);
    utl_http.end_response(hrs);
exception
    when utl_http.end_of_body then
        utl_http.end_response(hrs);
end http1;
/


create or replace procedure http2(username IN varchar2, password IN varchar2, HOST IN varchar2)
is
    hrq utl_http.req;
    hrs utl_http.resp;
    data varchar2(1024);
    gooddata varchar2(1024);
    hdrname varchar2(1024);
    hdrvalue varchar2(1024);
    secondhdr varchar2(1024);
begin
    hrq := UTL_HTTP.BEGIN_REQUEST('http://'|| host, 'GET', UTL_HTTP.HTTP_VERSION_1_0, null, 'www.veracode.com');        -- CWEID 441
    UTL_HTTP.SET_AUTHENTICATION(hrq, username, password);       -- this is okay; variable derived from elsewhere
    UTL_HTTP.SET_AUTHENTICATION(hrq, 'admin', 'Secret123!');    -- CWEID 798
    UTL_HTTP.SET_AUTHENTICATION(hrq, 'admin', password);    -- CWEID 798
    UTL_HTTP.SET_AUTHENTICATION(hrq, username, 'Secret123!');    -- CWEID 798
    UTL_HTTP.SET_HEADER(hrq, 'X-Host', 'http://www.veracode.com');
    UTL_HTTP.SET_HEADER(hrq, 'X-Foo', 'hmm ' || username);              -- CWEID 441
    gooddata := upper('nothing to see here');
    hrs := utl_http.get_response(hrq);
    for i in 1..utl_http.get_header_count(hrs) loop
        utl_http.get_header(hrs, i, hdrname, hdrvalue);
        dbms_output.put_line('header: ' || hdrname || ': ' || hdrvalue);
        execute immediate substr(hdrname, 5, 100);                  -- CWEID 89
        execute immediate substr(hdrvalue, 5, 100);                 -- CWEID 89
    end loop;
    secondhdr := UTL_HTTP.GET_HEADER_BY_NAME(hrs, 'Host', secondhdr, 1);
    execute immediate secondhdr;        -- CWEID 89
    loop
        utl_http.read_line(hrs, data);
        dbms_output.put_line(data);
    end loop;
    execute immediate substr(data, 5, 100);                 -- CWEID 89
    execute immediate substr(gooddata, 5, 100);
    utl_http.end_response(hrs);
exception
    when utl_http.end_of_body then
        utl_http.end_response(hrs);
end http2;
/

create or replace procedure http3(username IN varchar2, password IN varchar2, HOST IN varchar2)
is
    hrq utl_http.req;
    hrs utl_http.resp;
    data raw(1024);
    gooddata raw(1024);
    hdrname varchar2(1024);
    hdrvalue varchar2(1024);
    secondhdr varchar2(1024);
begin
    hrq := UTL_HTTP.BEGIN_REQUEST('http://'|| host, 'GET', UTL_HTTP.HTTP_VERSION_1_0, null, 'www.veracode.com');        -- CWEID 441
    UTL_HTTP.SET_AUTHENTICATION(hrq, username, password);       -- this is okay; variable derived from elsewhere
    UTL_HTTP.SET_AUTHENTICATION(hrq, 'admin', 'Secret123!');    -- CWEID 798
    UTL_HTTP.SET_AUTHENTICATION(hrq, 'admin', password);    -- CWEID 798
    UTL_HTTP.SET_AUTHENTICATION(hrq, username, 'Secret123!');    -- CWEID 798
    UTL_HTTP.SET_HEADER(hrq, 'X-Host', 'http://www.veracode.com');
    UTL_HTTP.SET_HEADER(hrq, 'X-Foo', 'hmm ' || username);              -- CWEID 441
    gooddata := utl_raw.cast_to_raw(upper('nothing to see here'));
    hrs := utl_http.get_response(hrq);
    for i in 1..utl_http.get_header_count(hrs) loop
        utl_http.get_header(hrs, i, hdrname, hdrvalue);
        dbms_output.put_line('header: ' || hdrname || ': ' || hdrvalue);
        execute immediate substr(hdrname, 5, 100);                  -- CWEID 89
        execute immediate substr(hdrvalue, 5, 100);                 -- CWEID 89
    end loop;
    loop
        utl_http.read_raw(hrs, data);
        dbms_output.put_line(utl_raw.cast_to_varchar2(data));
    end loop;
    execute immediate substr(utl_raw.cast_to_varchar2(data), 5, 100);                 -- CWEID 89
    execute immediate substr(utl_raw.cast_to_varchar2(gooddata), 5, 100);
    utl_http.end_response(hrs);
exception
    when utl_http.end_of_body then
        utl_http.end_response(hrs);
end http3;
/

create or replace procedure http4(username IN varchar2, password IN varchar2)
is
    hrq utl_http.req;
    hrs utl_http.resp;
    data varchar2(1024);
    gooddata varchar2(1024);
    hdrname varchar2(1024);
    hdrvalue varchar2(1024);
begin
    hrq := UTL_HTTP.BEGIN_REQUEST('http://www.veracode.com');
    UTL_HTTP.SET_AUTHENTICATION(hrq, username, password);       -- this is okay; variable derived from elsewhere
    UTL_HTTP.SET_AUTHENTICATION(hrq, 'admin', 'Secret123!');    -- CWEID 798
    UTL_HTTP.SET_AUTHENTICATION(hrq, 'admin', password);    -- CWEID 798
    UTL_HTTP.SET_AUTHENTICATION(hrq, username, 'Secret123!');    -- CWEID 798
    UTL_HTTP.SET_HEADER(hrq, 'X-Host', 'http://www.veracode.com');
    UTL_HTTP.SET_HEADER(hrq, 'X-Foo', 'hmm ' || username);              -- CWEID 441
    gooddata := upper('nothing to see here');
    hrs := utl_http.get_response(hrq);
    for i in 1..utl_http.get_header_count(hrs) loop
        utl_http.get_header(hrs, i, hdrname, hdrvalue);
        dbms_output.put_line('header: ' || hdrname || ': ' || hdrvalue);
        execute immediate substr(hdrname, 5, 100);                  -- CWEID 89
        execute immediate substr(hdrvalue, 5, 100);                 -- CWEID 89
    end loop;
    loop
        utl_http.read_text(hrs, data);
        dbms_output.put_line(data);
    end loop;
    execute immediate substr(data, 5, 100);                 -- CWEID 89
    execute immediate substr(gooddata, 5, 100);
    utl_http.end_response(hrs);
exception
    when utl_http.end_of_body then
        utl_http.end_response(hrs);
end http4;
/

create or replace procedure http5(proxy IN varchar2, password IN varchar2, site in varchar2)
is
    baddata0 varchar2(10240);
    baddata1 varchar2(10240);
    baddata2 varchar2(10240);

    gooddata varchar2(10240);
begin
    gooddata := 'select 5 from dual';
    baddata0 := utl_http.request('http://www.example.com', proxy, 'wallet.dat', password);        -- CWEID 441

    dbms_output.put_line(gooddata);
    dbms_output.put_line(baddata0); 

    execute immediate substr(gooddata, 10, 1000);
    execute immediate substr(baddata0, 10, 1000);       -- CWEID 89

    baddata1 := utl_http.request(site, proxy, null, null, null);        -- CWEID 441
    execute immediate substr(baddata1, 10, 1000);       -- CWEID 89

    baddata2 := utl_http.request('http://www.veracode.com', proxy, 'wallet.dat', 'secret999', 'www.veracode.com');      -- CWEID 798
    execute immediate substr(baddata2, 10, 1000);       -- CWEID 89

    baddata2 := utl_http.request('http://www.veracode.com', proxy, null, null, site);        -- CWEID 441
    execute immediate substr(baddata2, 10, 1000);       -- CWEID 89

end http5;
/

create or replace procedure http6(proxy IN varchar2, password IN varchar2, site in varchar2)
is
    badp0 utl_http.html_pieces;
    badp1 utl_http.html_pieces;
    badp2 utl_http.html_pieces;
    badp3 utl_http.html_pieces;
    badp4 utl_http.html_pieces;
begin
    utl_http.set_proxy('proxy.local', 'example.com');
    utl_http.set_proxy(proxy, 'example.com');       -- CWEID 441
    utl_http.set_proxy('proxy.local', site);       -- CWEID 441
    utl_http.set_wallet('wallet.dat', 'password1');     -- CWEID 798
    utl_http.set_wallet('wallet.dat', password);
    utl_http.set_wallet('/etc/wallets/' || site, password); -- CWEID 73

    badp0 := utl_http.request_pieces('http://www.example.com', 100, null, null, null, null);
    for i in 1..badp0.count LOOP
        execute immediate badp0(i);     -- CWEID 89
    END LOOP;

    badp1 := utl_http.request_pieces(site, 100, null, null, null, null);        -- CWEID 441
    for i in 1..badp1.count LOOP
        execute immediate badp1(i);     -- CWEID 89
    END LOOP;

    badp2 := utl_http.request_pieces('http://www.example.com', 100, proxy, null, null, null);       -- CWEID 441
    for i in 1..badp2.count LOOP
        execute immediate badp2(i);     -- CWEID 89
    END LOOP;

    badp3 := utl_http.request_pieces('http://www.example.com', 100, null, 'wallet.dat', password, site);       -- CWEID 441
    for i in 1..badp3.count LOOP
        execute immediate badp3(i);     -- CWEID 89
    END LOOP;

    badp4 := utl_http.request_pieces('http://www.example.com', 100, null, 'wallet.dat', 'secret55', null);       -- CWEID 798
    for i in 1..badp4.count LOOP
        execute immediate badp4(i);     -- CWEID 89
    END LOOP;


end http6;
/
