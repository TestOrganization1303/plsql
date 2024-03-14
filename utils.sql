set serveroutput on;

create or replace procedure utils1(foo IN varchar2)
is
    raw0 raw(300);
    raw1 raw(300);
    bar varchar2(300);
    goodbar varchar2(300);
begin
    raw0 := utl_raw.cast_to_raw(foo);
    bar := utl_raw.cast_to_varchar2(raw0);
    dbms_output.put_line('haha ' || bar);
    execute immediate bar;      -- CWEID 89

    raw1 := utl_raw.cast_to_raw('select 4 from dual');
    goodbar := utl_raw.cast_to_varchar2(raw1);
    execute immediate goodbar;
end utils1;
/

create or replace procedure utils2(foo IN varchar2)
is
    raw0 raw(300);
    raw1 raw(300);
    bar nvarchar2(300);
    goodbar nvarchar2(300);
begin
    raw0 := utl_raw.cast_to_raw(foo);
    bar := utl_raw.cast_to_nvarchar2(raw0);
    dbms_output.put_line('haha ' || bar);
    execute immediate bar;      -- CWEID 89

    raw1 := utl_raw.cast_to_raw('select 4 from dual');
    goodbar := utl_raw.cast_to_nvarchar2(raw1);
    execute immediate goodbar;
end utils2;
/

create or replace procedure utils3(foo IN varchar2)
is
    raw0 raw(300);
    raw1 raw(300);
    goodraw0 raw(1000);
    goodraw1 raw(1000);
    goodraw2 raw(1000);
    badraw0 raw(1000);
    badraw1 raw(1000);
    badraw2 raw(1000);
    goodchar0 varchar(1000);
    goodchar1 varchar(1000);
    goodchar2 varchar(1000);
    badchar0 varchar(1000);
    badchar1 varchar(1000);
    badchar2 varchar(1000);
begin
    raw0 := utl_raw.copies(utl_raw.convert(utl_raw.cast_to_raw(foo), 'UTF8', 'UTF8'), 2);
    raw1 := utl_raw.cast_to_raw('select 4 from dual');

    goodraw0 := utl_raw.concat(raw1, raw1, raw1, raw1, raw1);
    goodraw1 := utl_raw.concat(raw1, raw1, raw1, utl_raw.cast_to_raw('this is safe'), raw1, raw1, raw1, raw1);
    goodraw2 := utl_raw.concat(raw1, raw1, raw1, utl_raw.cast_to_raw('this is SAFE'), raw1, raw1, raw1, raw1);

    badraw0 := utl_raw.concat(raw1, raw1, raw1, raw0, raw1);
    badraw1 := utl_raw.concat(raw1, raw1, raw1, utl_raw.cast_to_raw(foo), raw1, raw1, raw1, raw1);
    badraw2 := utl_raw.concat(raw1, raw1, raw1, raw1, raw1, raw1, raw1, raw1, raw1, raw0);

    goodchar0 := utl_raw.cast_to_varchar2(goodraw0);
    goodchar1 := utl_raw.cast_to_varchar2(goodraw1);
    goodchar2 := utl_raw.cast_to_varchar2(goodraw2);
    badchar0 := utl_raw.cast_to_varchar2(badraw0);
    badchar1 := utl_raw.cast_to_varchar2(badraw1);
    badchar2 := utl_raw.cast_to_varchar2(badraw2);

    dbms_output.put_line('goodchar0 ' || goodchar0);
    dbms_output.put_line('goodchar1 ' || goodchar1);
    dbms_output.put_line('goodchar2 ' || goodchar2);
    dbms_output.put_line('badchar0 ' || badchar0);
    dbms_output.put_line('badchar1 ' || badchar1);
    dbms_output.put_line('badchar2 ' || badchar1);

    execute immediate goodchar0;
    execute immediate goodchar1;
    execute immediate goodchar2;
    execute immediate badchar0;    -- CWEID 89
    execute immediate badchar1;    -- CWEID 89
    execute immediate badchar2;    -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(goodchar0);
    execute immediate utl_raw.cast_to_varchar2(goodchar1);
    execute immediate utl_raw.cast_to_varchar2(goodchar2);
    execute immediate utl_raw.cast_to_varchar2(badchar0);       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(badchar1);       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(badchar2);       -- CWEID 89

    execute immediate utl_raw.cast_to_nvarchar2(goodchar0);
    execute immediate utl_raw.cast_to_nvarchar2(goodchar1);
    execute immediate utl_raw.cast_to_nvarchar2(goodchar2);
    execute immediate utl_raw.cast_to_nvarchar2(badchar0);       -- CWEID 89
    execute immediate utl_raw.cast_to_nvarchar2(badchar1);       -- CWEID 89
    execute immediate utl_raw.cast_to_nvarchar2(badchar2);       -- CWEID 89
end utils3;
/

create or replace procedure utils4(foo IN varchar2)
is
    badraw raw(1000);
    goodraw raw(1000);

    good0 raw(1000);
    good1 raw(1000);
    bad0 raw(1000);
    bad1 raw(1000);
    bad2 raw(1000);
begin
    badraw := utl_raw.cast_to_raw(foo);
    goodraw := utl_raw.cast_to_raw('select 3 from dual');

    good0 := utl_raw.overlay(goodraw, utl_raw.cast_to_raw('woop'), 0, 8, utl_raw.cast_to_raw('foop'));
    good1 := utl_raw.overlay(utl_raw.cast_to_raw('skfs'), utl_raw.cast_to_raw('woop'), 0, 8, utl_raw.cast_to_raw('foop'));

    bad0 := utl_raw.overlay(badraw, utl_raw.cast_to_raw('woop'), 0, 8, utl_raw.cast_to_raw('foop'));
    bad1 := utl_raw.overlay(goodraw, badraw, 0, 8, utl_raw.cast_to_raw('foop'));
    bad2 := utl_raw.overlay(goodraw, utl_raw.cast_to_raw('woop'), 0, 8, badraw);

    execute immediate utl_raw.cast_to_varchar2(good0);
    execute immediate utl_raw.cast_to_varchar2(good1);
    execute immediate utl_raw.cast_to_varchar2(bad0);       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(bad1);       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(bad2);       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(good0));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(good1));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(bad0));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(bad1));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(bad2));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(good0, 0, 222));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(good1, 0, 222));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad0, 0, 222));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad1, 0, 222));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad2, 0, 222));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(good0, 0));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(good1, 0));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad0, 0));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad1, 0));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad2, 0));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(good1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(bad0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(bad1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(bad2, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(bad0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(bad1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(bad2, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), bad0));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), bad1));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), bad2));       -- CWEID 89

end utils4;
/

create or replace procedure utils5(foo IN varchar2)
is
    badraw raw(1000);
    goodraw raw(1000);

    raw0 raw(1000);
    raw1 raw(1000);
    raw2 raw(1000);
    raw3 raw(1000);
    raw4 raw(1000);
begin
    badraw := utl_raw.cast_to_raw(foo);
    goodraw := utl_raw.cast_to_raw('select 3 from dual');

    raw0 := utl_encode.base64_decode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);   -- CWEID 89

    raw0 := utl_encode.base64_encode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);

    raw0 := utl_encode.mimeheader_decode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);   -- CWEID 89

    raw0 := utl_encode.mimeheader_encode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);   -- CWEID 89

    raw0 := utl_encode.quoted_printable_decode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);   -- CWEID 89

    raw0 := utl_encode.quoted_printable_encode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);   -- CWEID 89

    raw0 := utl_encode.text_decode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);   -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_encode.text_decode(badraw));   -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_encode.text_decode(   -- CWEID 89
            encode_charset => null,
            buf => badraw,
            encoding => null
    ));

    execute immediate utl_raw.cast_to_varchar2(utl_encode.text_encode(   -- CWEID 89
            encode_charset => null,
            buf => badraw,
            encoding => null
    ));


    raw0 := utl_encode.text_encode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);   -- CWEID 89

    raw0 := utl_encode.uuencode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);

    raw0 := utl_encode.uudecode(badraw);
    execute immediate utl_raw.cast_to_varchar2(raw0);   -- CWEID 89

end utils5;
/

create or replace procedure utils6(foo IN varchar2)
is
    goodfp utl_file.file_type;
    badfp utl_file.file_type;
    bar varchar2(1000);
    fexists boolean;
    flen number;
    blocksz binary_integer;
begin
    bar := 'group';

    utl_file.fcopy('foo', 'bar', 'baz', 'quux');
    utl_file.fcopy('foo', 'bar', 'baz', 'quux', 1, null);
    utl_file.fcopy(bar, bar, bar, bar);
    utl_file.fcopy(bar, bar, bar, bar, 1, null);

    utl_file.fcopy(start_line => 1, end_line => null, src_location => 'foo', src_filename => 'bar', dest_location => foo, dest_filename => 'newfoo');       -- CWEID 73
    utl_file.fcopy(start_line => 1, end_line => null, src_location => 'foo', src_filename => 'bar', dest_location => 'newofoo', dest_filename => foo);       -- CWEID 73

    utl_file.fcopy(start_line => 1, end_line => null, dest_location => 'foo', dest_filename => 'bar', src_location => foo, src_filename => 'newfoo');       -- CWEID 73
    utl_file.fcopy(start_line => 1, end_line => null, dest_location => 'foo', dest_filename => 'bar', src_location => 'newofoo', src_filename => foo);       -- CWEID 73

    utl_file.fcopy(foo, bar, bar, bar);                 -- CWEID 73
    utl_file.fcopy(foo, bar, bar, bar, 1, null);        -- CWEID 73
    utl_file.fcopy(bar, foo, bar, bar);                 -- CWEID 73
    utl_file.fcopy(bar, foo, bar, bar, 1, null);        -- CWEID 73
    utl_file.fcopy(bar, bar, foo, bar);                 -- CWEID 73
    utl_file.fcopy(bar, bar, foo, bar, 1, null);        -- CWEID 73
    utl_file.fcopy(bar, bar, bar, foo);                 -- CWEID 73
    utl_file.fcopy(bar, bar, bar, foo, 1, null);        -- CWEID 73

    utl_file.fgetattr('foo', 'bar', fexists, flen, blocksz);
    utl_file.fgetattr(bar, bar, fexists, flen, blocksz);
    utl_file.fgetattr(foo, bar, fexists, flen, blocksz);    -- CWEID 73
    utl_file.fgetattr(bar, foo, fexists, flen, blocksz);    -- CWEID 73

    utl_file.fgetattr(fexists => fexists, file_length => flen, block_size => blocksz, location => foo, filename => 'fname');        -- CWEID 73
    utl_file.fgetattr(fexists => fexists, file_length => flen, block_size => blocksz, location => 'oo', filename => foo);        -- CWEID 73

    goodfp := utl_file.fopen('/etc/' || bar, bar, 'r');
    utl_file.fclose(goodfp);
    goodfp := utl_file.fopen('/etc/' || bar, bar, 'r', 512);
    utl_file.fclose(goodfp);
    badfp := utl_file.fopen('/etc/' || foo, bar, 'r');            -- CWEID 73
    utl_file.fclose(badfp);
    badfp := utl_file.fopen('/etc/' || foo, bar, 'r', 512);            -- CWEID 73
    utl_file.fclose(badfp);
    badfp := utl_file.fopen('/etc/' || bar, foo, 'r');            -- CWEID 73
    utl_file.fclose(badfp);
    badfp := utl_file.fopen('/etc/' || bar, foo, 'r', 512);            -- CWEID 73
    utl_file.fclose(badfp);

    badfp := utl_file.fopen(open_mode => 'r', max_linesize => 1024, location => '/etc/' || bar, filename => foo);            -- CWEID 73
    utl_file.fclose(badfp);
    badfp := utl_file.fopen(open_mode => 'r', max_linesize => 1024, location => '/etc/' || foo, filename => bar);            -- CWEID 73
    utl_file.fclose(badfp);

    badfp := utl_file.fopen_nchar(open_mode => 'r', max_linesize => 1024, location => '/etc/' || bar, filename => foo);            -- CWEID 73
    utl_file.fclose(badfp);
    badfp := utl_file.fopen_nchar(open_mode => 'r', max_linesize => 1024, location => '/etc/' || foo, filename => bar);            -- CWEID 73
    utl_file.fclose(badfp);

    goodfp := utl_file.fopen_nchar('/etc/' || bar, bar, 'r');
    utl_file.fclose(goodfp);
    goodfp := utl_file.fopen_nchar('/etc/' || bar, bar, 'r', 512);
    utl_file.fclose(goodfp);
    badfp := utl_file.fopen_nchar('/etc/' || foo, bar, 'r');            -- CWEID 73
    utl_file.fclose(badfp);
    badfp := utl_file.fopen_nchar('/etc/' || foo, bar, 'r', 512);            -- CWEID 73
    utl_file.fclose(badfp);
    badfp := utl_file.fopen_nchar('/etc/' || bar, foo, 'r');            -- CWEID 73
    utl_file.fclose(badfp);
    badfp := utl_file.fopen_nchar('/etc/' || bar, foo, 'r', 512);            -- CWEID 73
    utl_file.fclose(badfp);

    utl_file.fremove(bar, bar);
    utl_file.fremove(foo, bar);     -- CWEID 73
    utl_file.fremove(bar, foo);     -- CWEID 73
    utl_file.fremove(foo, foo);     -- CWEID 73
    utl_file.fremove(filename => bar, location => foo);     -- CWEID 73
    utl_file.fremove(filename => foo, location => foo);     -- CWEID 73

    utl_file.frename('foo', 'bar', 'baz', 'quux');
    utl_file.frename('foo', 'bar', 'baz', 'quux', true);
    utl_file.frename(bar, bar, bar, bar);
    utl_file.frename(bar, bar, bar, bar, true);

    utl_file.frename(overwrite => false, src_location => 'foo', src_filename => 'bar', dest_location => foo, dest_filename => 'newfoo');       -- CWEID 73
    utl_file.frename(overwrite => false, src_location => 'foo', src_filename => 'bar', dest_location => 'newofoo', dest_filename => foo);       -- CWEID 73

    utl_file.frename(overwrite => false, dest_location => 'foo', dest_filename => 'bar', src_location => foo, src_filename => 'newfoo');       -- CWEID 73
    utl_file.frename(overwrite => false, dest_location => 'foo', dest_filename => 'bar', src_location => 'newofoo', src_filename => foo);       -- CWEID 73


    utl_file.frename(foo, bar, bar, bar);                 -- CWEID 73
    utl_file.frename(foo, bar, bar, bar, true);        -- CWEID 73
    utl_file.frename(bar, foo, bar, bar);                 -- CWEID 73
    utl_file.frename(bar, foo, bar, bar, true);        -- CWEID 73
    utl_file.frename(bar, bar, foo, bar);                 -- CWEID 73
    utl_file.frename(bar, bar, foo, bar, true);        -- CWEID 73
    utl_file.frename(bar, bar, bar, foo);                 -- CWEID 73
    utl_file.frename(bar, bar, bar, foo, true);        -- CWEID 73

 
end utils6;
/

create or replace procedure utils7(foo IN varchar2)
is
    bar varchar2(1024);
    raw0 varchar2(1024);
    raw1 varchar2(1024);
begin
    bar := 'select 7 from dual';

    execute immediate foo;      -- CWEID 89
    execute immediate bar;

    execute immediate UTL_I18N.ESCAPE_REFERENCE(foo);       -- CWEID 89
    execute immediate UTL_I18N.ESCAPE_REFERENCE(bar);

    execute immediate UTL_I18N.UNESCAPE_REFERENCE(foo);       -- CWEID 89
    execute immediate UTL_I18N.UNESCAPE_REFERENCE(bar);

    execute immediate UTL_I18N.TRANSLITERATE(foo, 'kana_hiragana');       -- CWEID 89
    execute immediate UTL_I18N.TRANSLITERATE(name => 'kana_hiragana',  data => foo);       -- CWEID 89
    execute immediate UTL_I18N.TRANSLITERATE(bar, 'kana_hiragana');

    raw0 := utl_i18n.string_to_raw(foo);
    raw1 := utl_i18n.string_to_raw(bar);

    execute immediate utl_raw.cast_to_varchar2(utl_i18n.string_to_raw(      -- CWEID 89
            dst_charset => null,
            data => foo
    ));

    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_raw.cast_to_varchar2(raw0));     -- CWEID 89
    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_i18n.raw_to_char(raw0, null));     -- CWEID 89
    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_i18n.raw_to_char(     -- CWEID 89
            src_charset => null,
            data => raw0
    ));
    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_i18n.raw_to_char(raw0, null));     -- CWEID 89
    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_i18n.raw_to_nchar(raw0, null));     -- CWEID 89
    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_i18n.raw_to_nchar(     -- CWEID 89
            src_charset => null,
            data => raw0
    ));

    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_raw.cast_to_varchar2(raw1));
    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_i18n.raw_to_char(raw1, null));
    execute immediate UTL_I18N.ESCAPE_REFERENCE(utl_i18n.raw_to_nchar(raw1, null));
end utils7;
/

create or replace procedure utils8(bar in varchar2)
is
    foo varchar2(1024);
begin
    foo := 'bcreighton@veracode.com';

    utl_mail.send(foo, 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null);
    utl_mail.send(bar, 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null);       -- CWEID 88

    utl_mail.send('bcreighton@veracode.com', foo, null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null);
    utl_mail.send('bcreighton@veracode.com', bar, null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null);       -- CWEID 88

    utl_mail.send('bcreighton@veracode.com', 'bcreighton@veracode.com', foo, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null);
    utl_mail.send('bcreighton@veracode.com', 'bcreighton@veracode.com', bar, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null);       -- CWEID 88

    utl_mail.send('bcreighton@veracode.com', 'bcreighton@veracode.com', null, foo, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null);
    utl_mail.send('bcreighton@veracode.com', 'bcreighton@veracode.com', null, bar, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null);       -- CWEID 88

    utl_mail.send('bcreighton@veracode.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, foo);
    utl_mail.send('bcreighton@veracode.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, bar);       -- CWEID 88


    utl_mail.send_attach_raw(foo, 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_raw(bar, 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);       -- CWEID 88

    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);

    utl_mail.send_attach_raw('x@yahoo.com', foo, null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_raw('x@yahoo.com', bar, null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);       -- CWEID 88

    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', foo, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', bar, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);       -- CWEID 88

    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', null, foo, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', null, bar, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);       -- CWEID 88

    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', foo);
    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', bar);       -- CWEID 88

    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', foo, null);
    utl_mail.send_attach_raw('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', bar, null);       -- CWEID 73

    utl_mail.send_attach_varchar2(foo, 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_varchar2(bar, 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);       -- CWEID 88

    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);

    utl_mail.send_attach_varchar2('x@yahoo.com', foo, null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_varchar2('x@yahoo.com', bar, null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);       -- CWEID 88

    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', foo, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', bar, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);       -- CWEID 88

    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', null, foo, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);
    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', null, bar, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', null);       -- CWEID 88

    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', foo);
    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', 'file.txt', bar);       -- CWEID 88

    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', foo, null);
    utl_mail.send_attach_varchar2('x@yahoo.com', 'bcreighton@veracode.com', null, null, 'subject', 'message', 'text/plain; charset=us-ascii', 3, null, true, 'text/plain', bar, null);       -- CWEID 73


    utl_mail.send(                              -- CWEID 88
        subject => 'this is a subject',
        message => 'hello world',
        cc => null,
        bcc => null,
        sender => bar,
        recipients => 'bcreighton@veracode.com',
        replyto => 'bcreighton@veracode.com'
    );

    utl_mail.send(                              -- CWEID 88
        subject => 'this is a subject',
        message => 'hello world',
        cc => null,
        bcc => null,
        sender => 'bcreighton@veracode.com',
        recipients => bar,
        replyto => 'bcreighton@veracode.com'
    );

    utl_mail.send_attach_raw(                              -- CWEID 88
        subject => 'this is a subject',
        message => 'hello world',
        cc => null,
        bcc => null,
        sender => bar,
        recipients => 'bcreighton@veracode.com',
        replyto => 'bcreighton@veracode.com',
        attachment => null,
        att_filename => 'foo.txt'
    );

    utl_mail.send_attach_raw(                              -- CWEID 88
        subject => 'this is a subject',
        message => 'hello world',
        cc => null,
        bcc => null,
        sender => 'bcreighton@veracode.com',
        recipients => bar,
        replyto => 'bcreighton@veracode.com',
        attachment => null,
        att_filename => 'foo.txt'
    );


    utl_mail.send_attach_varchar2(                              -- CWEID 88
        subject => 'this is a subject',
        message => 'hello world',
        cc => null,
        bcc => null,
        sender => bar,
        recipients => 'bcreighton@veracode.com',
        replyto => 'bcreighton@veracode.com',
        attachment => null,
        att_filename => 'foo.txt'
    );

    utl_mail.send_attach_varchar2(                              -- CWEID 88
        subject => 'this is a subject',
        message => 'hello world',
        cc => null,
        bcc => null,
        sender => 'bcreighton@veracode.com',
        recipients => bar,
        replyto => 'bcreighton@veracode.com',
        attachment => null,
        att_filename => 'foo.txt'
    );

    utl_mail.send_attach_raw(                              -- CWEID 73
        subject => 'this is a subject',
        message => 'hello world',
        cc => null,
        bcc => null,
        sender => 'bcreighton@veracode.com',
        recipients => 'bcreighton@veracode.com',
        replyto => 'bcreighton@veracode.com',
        attachment => null,
        att_filename => bar
    );


    utl_mail.send_attach_varchar2(                              -- CWEID 73
        subject => 'this is a subject',
        message => 'hello world',
        cc => null,
        bcc => null,
        sender => 'bcreighton@veracode.com',
        recipients => 'bcreighton@veracode.com',
        replyto => 'bcreighton@veracode.com',
        attachment => null,
        att_filename => bar
    );




end utils8;
/

create or replace procedure posutils3(foo IN varchar2)
is
    raw0 raw(300);
    raw1 raw(300);
    goodraw0 raw(1000);
    goodraw1 raw(1000);
    goodraw2 raw(1000);
    badraw0 raw(1000);
    badraw1 raw(1000);
    badraw2 raw(1000);
    goodchar0 varchar(1000);
    goodchar1 varchar(1000);
    goodchar2 varchar(1000);
    badchar0 varchar(1000);
    badchar1 varchar(1000);
    badchar2 varchar(1000);
begin
    raw0 := utl_raw.copies(n => 2, r => utl_raw.convert(from_charset => 'UTF8', r => utl_raw.cast_to_raw(foo), to_charset => 'UTF8'));
    raw1 := utl_raw.cast_to_raw('select 4 from dual');

    goodraw0 := utl_raw.concat(raw1, raw1, raw1, raw1, raw1);
    goodraw1 := utl_raw.concat(raw1, raw1, raw1, utl_raw.cast_to_raw('this is safe'), raw1, raw1, raw1, raw1);
    goodraw2 := utl_raw.concat(raw1, raw1, raw1, utl_raw.cast_to_raw('this is SAFE'), raw1, raw1, raw1, raw1);

    badraw0 := utl_raw.concat(raw1, raw1, raw1, raw0, raw1);
    badraw1 := utl_raw.concat(raw1, raw1, raw1, utl_raw.cast_to_raw(foo), raw1, raw1, raw1, raw1);
    badraw2 := utl_raw.concat(raw1, raw1, raw1, raw1, raw1, raw1, raw1, raw1, raw1, raw0);

    goodchar0 := utl_raw.cast_to_varchar2(goodraw0);
    goodchar1 := utl_raw.cast_to_varchar2(goodraw1);
    goodchar2 := utl_raw.cast_to_varchar2(goodraw2);
    badchar0 := utl_raw.cast_to_varchar2(badraw0);
    badchar1 := utl_raw.cast_to_varchar2(badraw1);
    badchar2 := utl_raw.cast_to_varchar2(badraw2);

    dbms_output.put_line('goodchar0 ' || goodchar0);
    dbms_output.put_line('goodchar1 ' || goodchar1);
    dbms_output.put_line('goodchar2 ' || goodchar2);
    dbms_output.put_line('badchar0 ' || badchar0);
    dbms_output.put_line('badchar1 ' || badchar1);
    dbms_output.put_line('badchar2 ' || badchar1);

    execute immediate goodchar0;
    execute immediate goodchar1;
    execute immediate goodchar2;
    execute immediate badchar0;    -- CWEID 89
    execute immediate badchar1;    -- CWEID 89
    execute immediate badchar2;    -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(goodchar0);
    execute immediate utl_raw.cast_to_varchar2(goodchar1);
    execute immediate utl_raw.cast_to_varchar2(goodchar2);
    execute immediate utl_raw.cast_to_varchar2(badchar0);       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(badchar1);       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(badchar2);       -- CWEID 89

    execute immediate utl_raw.cast_to_nvarchar2(goodchar0);
    execute immediate utl_raw.cast_to_nvarchar2(goodchar1);
    execute immediate utl_raw.cast_to_nvarchar2(goodchar2);
    execute immediate utl_raw.cast_to_nvarchar2(badchar0);       -- CWEID 89
    execute immediate utl_raw.cast_to_nvarchar2(badchar1);       -- CWEID 89
    execute immediate utl_raw.cast_to_nvarchar2(badchar2);       -- CWEID 89
end posutils3;
/

create or replace procedure posutils4(foo IN varchar2)
is
    badraw raw(1000);
    goodraw raw(1000);

    good0 raw(1000);
    good1 raw(1000);
    bad0 raw(1000);
    bad1 raw(1000);
    bad2 raw(1000);
begin
    badraw := utl_raw.cast_to_raw(foo);
    goodraw := utl_raw.cast_to_raw('select 3 from dual');

    good0 := utl_raw.overlay(goodraw, utl_raw.cast_to_raw('woop'), 0, 8, utl_raw.cast_to_raw('foop'));
    good1 := utl_raw.overlay(utl_raw.cast_to_raw('skfs'), utl_raw.cast_to_raw('woop'), 0, 8, utl_raw.cast_to_raw('foop'));

    bad0 := utl_raw.overlay(
        pos => 0, 
        target => utl_raw.cast_to_raw('woop'), 
        overlay_str => badraw, 
        len => 8, 
        pad => utl_raw.cast_to_raw('foop')
    );
    bad1 := utl_raw.overlay(
        overlay_str => goodraw, 
        pos => 0, 
        len => 8, 
        target => badraw, 
        pad => utl_raw.cast_to_raw('foop')
    );
    bad2 := utl_raw.overlay(
        len => 8, 
        overlay_str => goodraw, 
        target => utl_raw.cast_to_raw('woop'), 
        pad => badraw,
        pos => 0
    );

    execute immediate utl_raw.cast_to_varchar2(good0);
    execute immediate utl_raw.cast_to_varchar2(good1);
    execute immediate utl_raw.cast_to_varchar2(bad0);       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(bad1);       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(bad2);       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(good0));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(good1));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(bad0));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(bad1));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.reverse(bad2));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(good0, 0, 222));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(good1, 0, 222));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad0, 0, 222));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad1, 0, 222));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad2, 0, 222));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(pos => 0, len => 222, r => bad2));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(good0, 0));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(good1, 0));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad0, 0));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad1, 0));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.substr(bad2, 0));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(good1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(bad0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(bad1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(bad2, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.translate(from_set => utl_raw.cast_to_raw('41'), to_set => utl_raw.cast_to_raw('42'), r => bad2));       -- CWEID 89

    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(bad0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(bad1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(bad2, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(       -- CWEID 89
            to_set => utl_raw.cast_to_raw('41'), 
            r => bad2, 
            from_set => utl_raw.cast_to_raw('42'), 
            pad => utl_raw.cast_to_raw(' ')
    ));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(       -- CWEID 89
            to_set => utl_raw.cast_to_raw('41'), 
            pad => bad2, 
            from_set => utl_raw.cast_to_raw('42'), 
            r => utl_raw.cast_to_raw(' ')
    ));


    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), utl_raw.cast_to_raw(' ')));
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), bad0));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good1, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), bad1));       -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(utl_raw.transliterate(good0, utl_raw.cast_to_raw('41'), utl_raw.cast_to_raw('42'), bad2));       -- CWEID 89

end posutils4;
/
