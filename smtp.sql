set serveroutput on;

create or replace procedure smtp1(name in varchar2, place in varchar2, address in varchar2)
is
    conn utl_smtp.connection;
begin
    conn := UTL_SMTP.OPEN_CONNECTION('us-smtp-inbound-1.mimecast.com');
    utl_smtp.helo(conn, 'veracode.com');
    utl_smtp.mail(conn, 'bcreighton@veracode.com');
    utl_smtp.auth(conn, 'username', 'password');        -- CWEID 798
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com');
    utl_smtp.open_data(conn);
    utl_smtp.write_data(conn, 'From: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'To: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'Subject: hello' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, UTL_TCP.CRLF || 'buh');
    utl_smtp.close_data(conn);
    utl_smtp.quit(conn);
exception
    when utl_smtp.transient_error or utl_SMTP.permanent_error then 
        utl_smtp.quit(conn);
end smtp1;
/

create or replace procedure smtp2(name in varchar2, place in varchar2, address in varchar2, username in varchar2, password in varchar2)
is
    conn utl_smtp.connection;
    replies utl_smtp.replies;
begin
    conn := UTL_SMTP.OPEN_CONNECTION('us-smtp-inbound-1.mimecast.com', 25, null, null, null, false, place);     -- CWEID 441
    utl_smtp.helo(conn, 'veracode.com');
    utl_smtp.mail(conn, address);                   -- CWEID 441
    utl_smtp.mail(conn, 'bcreighton@veracode.com', address);                   -- CWEID 441
    utl_smtp.auth(conn, username, 'password');        -- CWEID 798
    utl_smtp.auth(conn, username, password);
    utl_smtp.command(conn, 'HELO');
    utl_smtp.command(conn, name);                   -- CWEID 441
    utl_smtp.command(conn, 'NULL', address);        -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'HELO');
    replies := utl_smtp.command_replies(conn, name);                   -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'EXPN', address);        -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com');
    utl_smtp.open_data(conn);
    utl_smtp.write_data(conn, 'From: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'To: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'Subject: hello' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, UTL_TCP.CRLF || 'buh');
    utl_smtp.close_data(conn);
    utl_smtp.quit(conn);
exception
    when utl_smtp.transient_error or utl_SMTP.permanent_error then 
        utl_smtp.quit(conn);
end smtp2;
/

create or replace procedure smtp3(name in varchar2, place in varchar2, address in varchar2, username in varchar2, password in varchar2)
is
    conn utl_smtp.connection;
    replies utl_smtp.replies;
begin
    conn := UTL_SMTP.OPEN_CONNECTION(place, 25, null, null, null, false, null);     -- CWEID 441
    utl_smtp.helo(conn, 'veracode.com');
    utl_smtp.mail(conn, address);                   -- CWEID 441
    utl_smtp.mail(conn, 'bcreighton@veracode.com', address);                   -- CWEID 441
    utl_smtp.auth(conn, username, 'password');        -- CWEID 798
    utl_smtp.auth(conn, username, password);
    utl_smtp.command(conn, 'HELO');
    utl_smtp.command(conn, name);                   -- CWEID 441
    utl_smtp.command(conn, 'NULL', address);        -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'HELO');
    replies := utl_smtp.command_replies(conn, name);                   -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'EXPN', address);        -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com');
    utl_smtp.open_data(conn);
    utl_smtp.write_data(conn, 'From: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'To: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'Subject: hello' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, UTL_TCP.CRLF || 'buh');
    utl_smtp.close_data(conn);
    utl_smtp.quit(conn);
exception
    when utl_smtp.transient_error or utl_SMTP.permanent_error then 
        utl_smtp.quit(conn);
end smtp3;
/

create or replace procedure smtp4(name in varchar2, place in varchar2, address in varchar2, username in varchar2, password in varchar2)
is
    conn utl_smtp.connection;
    replies utl_smtp.replies;
begin
    conn := UTL_SMTP.OPEN_CONNECTION('mail.veracode.com', 25, null, null, null, false, null);
    utl_smtp.helo(conn, 'veracode.com');
    utl_smtp.mail(conn, address);                   -- CWEID 441
    utl_smtp.mail(conn, 'bcreighton@veracode.com', address);                   -- CWEID 441
    utl_smtp.auth(conn, username, 'password');        -- CWEID 798
    utl_smtp.auth(conn, username, password);
    utl_smtp.command(conn, 'HELO');
    utl_smtp.command(conn, name);                   -- CWEID 441
    utl_smtp.command(conn, 'NULL', address);        -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'HELO');
    replies := utl_smtp.command_replies(conn, name);                   -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'EXPN', address);        -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com');
    utl_smtp.rcpt(conn, address);       -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com', address);       -- CWEID 441
    utl_smtp.open_data(conn);
    utl_smtp.write_data(conn, 'From: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'To: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'Subject: hello' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, UTL_TCP.CRLF || 'buh');
    utl_smtp.close_data(conn);
    utl_smtp.quit(conn);
exception
    when utl_smtp.transient_error or utl_SMTP.permanent_error then 
        utl_smtp.quit(conn);
end smtp4;
/

create or replace procedure smtp5(name in varchar2, place in varchar2, address in varchar2, username in varchar2, password in varchar2)
is
    conn utl_smtp.connection;
    replies utl_smtp.replies;
begin
    conn := UTL_SMTP.OPEN_CONNECTION(           -- CWEID 441
        port => 25,
        host => name,
        wallet_path => null,
        wallet_password => null,
        secure_connection_before_smtp => false
    );
    utl_smtp.helo(conn, 'veracode.com');
    utl_smtp.mail(conn, address);                   -- CWEID 441
    utl_smtp.mail(conn, 'bcreighton@veracode.com', address);                   -- CWEID 441
    utl_smtp.auth(conn, username, 'password');        -- CWEID 798
    utl_smtp.auth(conn, username, password);
    utl_smtp.command(conn, 'HELO');
    utl_smtp.command(conn, name);                   -- CWEID 441
    utl_smtp.command(conn, 'NULL', address);        -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'HELO');
    replies := utl_smtp.command_replies(conn, name);                   -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'EXPN', address);        -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com');
    utl_smtp.rcpt(conn, address);       -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com', address);       -- CWEID 441
    utl_smtp.open_data(conn);
    utl_smtp.write_data(conn, 'From: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'To: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'Subject: hello' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, UTL_TCP.CRLF || 'buh');
    utl_smtp.close_data(conn);
    utl_smtp.quit(conn);
exception
    when utl_smtp.transient_error or utl_SMTP.permanent_error then 
        utl_smtp.quit(conn);
end smtp5;
/

create or replace procedure smtp6(name in varchar2, place in varchar2, address in varchar2, username in varchar2, password in varchar2)
is
    conn utl_smtp.connection;
    replies utl_smtp.replies;
begin
    conn := UTL_SMTP.OPEN_CONNECTION(           -- CWEID 441
        port => 25,
        host => 'mail.veracode.com',
        secure_host => name,
        wallet_path => null,
        wallet_password => null,
        secure_connection_before_smtp => false
    );
    utl_smtp.helo(conn, 'veracode.com');
    utl_smtp.mail(conn, address);                   -- CWEID 441
    utl_smtp.mail(conn, 'bcreighton@veracode.com', address);                   -- CWEID 441
    utl_smtp.mail(sender => address, c => conn);    -- CWEID 441
    utl_smtp.mail(parameters => password, sender => 'bcreighton@veracode.com', c => conn);    -- CWEID 441
    utl_smtp.auth(conn, username, 'password');        -- CWEID 798
    utl_smtp.auth(conn, username, password);
    utl_smtp.auth(username => username, c => conn, schemes => null, password => 'secret123');       -- CWEID 798
    utl_smtp.auth(username => 'username', c => conn, schemes => null, password => password);       -- CWEID 798
    utl_smtp.command(conn, 'HELO');
    utl_smtp.command(conn, name);                   -- CWEID 441

    utl_smtp.command(cmd => name, c => conn);                   -- CWEID 441
    utl_smtp.command(arg => name, cmd => 'NOOP', c => conn);    -- CWEID 441

    replies := utl_smtp.command_replies(cmd => name, c => conn);                   -- CWEID 441
    replies := utl_smtp.command_replies(arg => name, cmd => 'NOOP', c => conn);    -- CWEID 441

    utl_smtp.command(conn, 'NULL', address);        -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'HELO');
    replies := utl_smtp.command_replies(conn, name);                   -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'EXPN', address);        -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com');
    utl_smtp.rcpt(conn, address);       -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com', address);       -- CWEID 441
    utl_smtp.rcpt(recipient => address, c => conn, parameters => null);     -- CWEID 441
    utl_smtp.rcpt(parameters => address, c => conn, recipient => 'bcreighton@veracode.com');     -- CWEID 441
    utl_smtp.open_data(conn);
    utl_smtp.write_data(conn, 'From: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'To: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'Subject: hello' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, UTL_TCP.CRLF || 'buh');
    utl_smtp.close_data(conn);
    utl_smtp.quit(conn);
exception
    when utl_smtp.transient_error or utl_SMTP.permanent_error then 
        utl_smtp.quit(conn);
end smtp6;
/

create or replace procedure smtp7(name in varchar2, place in varchar2, address in varchar2, username in varchar2, password in varchar2)
is
    conn utl_smtp.connection;
    replies utl_smtp.replies;
begin
    conn := UTL_SMTP.OPEN_CONNECTION(           -- CWEID 798
        port => 25,
        host => 'mail.veracode.com',
        secure_host => 'mail.veracode.com',
        wallet_path => 'wallet.dat',
        wallet_password => 'secrethaha',
        secure_connection_before_smtp => false
    );
    utl_smtp.helo(conn, 'veracode.com');
    utl_smtp.mail(conn, address);                   -- CWEID 441
    utl_smtp.mail(conn, 'bcreighton@veracode.com', address);                   -- CWEID 441
    utl_smtp.mail(sender => address, c => conn);    -- CWEID 441
    utl_smtp.mail(parameters => password, sender => 'bcreighton@veracode.com', c => conn);    -- CWEID 441
    utl_smtp.auth(conn, username, 'password');        -- CWEID 798
    utl_smtp.auth(conn, username, password);
    utl_smtp.auth(username => username, c => conn, schemes => null, password => 'secret123');       -- CWEID 798
    utl_smtp.auth(username => 'username', c => conn, schemes => null, password => password);       -- CWEID 798
    utl_smtp.command(conn, 'HELO');
    utl_smtp.command(conn, name);                   -- CWEID 441

    utl_smtp.command(cmd => name, c => conn);                   -- CWEID 441
    utl_smtp.command(arg => name, cmd => 'NOOP', c => conn);    -- CWEID 441

    replies := utl_smtp.command_replies(cmd => name, c => conn);                   -- CWEID 441
    replies := utl_smtp.command_replies(arg => name, cmd => 'NOOP', c => conn);    -- CWEID 441

    utl_smtp.command(conn, 'NULL', address);        -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'HELO');
    replies := utl_smtp.command_replies(conn, name);                   -- CWEID 441
    replies := utl_smtp.command_replies(conn, 'EXPN', address);        -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com');
    utl_smtp.rcpt(conn, address);       -- CWEID 441
    utl_smtp.rcpt(conn, 'bcreighton@veracode.com', address);       -- CWEID 441
    utl_smtp.rcpt(recipient => address, c => conn, parameters => null);     -- CWEID 441
    utl_smtp.rcpt(parameters => address, c => conn, recipient => 'bcreighton@veracode.com');     -- CWEID 441
    utl_smtp.open_data(conn);
    utl_smtp.write_data(conn, 'From: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'To: "bcreighton" <bcreighton@veracode.com>' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, 'Subject: hello' || UTL_TCP.CRLF);
    utl_smtp.write_data(conn, UTL_TCP.CRLF || 'buh');
    utl_smtp.close_data(conn);
    utl_smtp.quit(conn);
exception
    when utl_smtp.transient_error or utl_SMTP.permanent_error then 
        utl_smtp.quit(conn);
end smtp7;
/

