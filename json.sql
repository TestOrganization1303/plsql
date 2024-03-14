set serveroutput on;

create or replace procedure json1(foo in varchar2)
is
    badobj json_object_t;
    badobj2 json_object_t;
    badobj3 json_object_t;
    badobj4 json_object_t;
    badelem json_element_t;
    badarr json_array_t;
    badclob clob;
    badblob blob;

    goodobj json_object_t;
    goodobj2 json_object_t;
    goodobj3 json_object_t;
    goodobj4 json_object_t;
    goodelem json_element_t;
    goodarr json_array_t;
    goodclob clob;
    goodblob blob;
begin
    goodobj := json_object_t.parse('{foo: "FOO", bar: { foo: "BARFOO" }, baz: ["BAZFOO"]}');
    dbms_output.put_line(json_object_t.get_string(goodobj, 'foo'));
    goodelem := json_object_t.get(goodobj, 'bar');
    goodobj2 := treat(goodelem as json_object_t);
    dbms_output.put_line(json_object_t.get_string(goodobj2, 'foo'));
    goodclob := json_object_t.get_clob(goodobj2, 'foo');
    dbms_output.put_line(to_char(goodclob));
    goodblob := json_object_t.get_blob(goodobj2, 'foo');
    dbms_output.put_line(utl_raw.cast_to_varchar2(dbms_lob.substr(goodblob)));
    goodobj3 := json_object_t.get_object(goodobj, 'bar');
    dbms_output.put_line(json_object_t.get_string(goodobj3, 'foo'));
    goodobj4 := json_object_t.clone(goodobj3);
    dbms_output.put_line(json_object_t.get_string(goodobj4, 'foo'));
    goodarr := json_object_t.get_array(goodobj, 'baz');
    dbms_output.put_line(json_array_t.get_string(goodarr, 0));

    execute immediate json_object_t.get_string(goodobj, 'foo');
    execute immediate json_object_t.get_string(goodobj2, 'foo');
    execute immediate to_char(goodclob);
    execute immediate utl_raw.cast_to_varchar2(dbms_lob.substr(goodblob));
    execute immediate json_object_t.get_string(goodobj3, 'foo');
    execute immediate json_object_t.get_string(goodobj4, 'foo');
    execute immediate json_array_t.get_string(goodarr, 0);

    badobj := json_object_t.parse(foo);
    dbms_output.put_line(json_object_t.get_string(badobj, 'foo'));
    badelem := json_object_t.get(badobj, 'bar');
    badobj2 := treat(badelem as json_object_t);
    dbms_output.put_line(json_object_t.get_string(badobj2, 'foo'));
    badclob := json_object_t.get_clob(badobj2, 'foo');
    dbms_output.put_line(to_char(badclob));
    badblob := json_object_t.get_blob(badobj2, 'foo');
    dbms_output.put_line(utl_raw.cast_to_varchar2(dbms_lob.substr(badblob)));
    badobj3 := json_object_t.get_object(badobj, 'bar');
    dbms_output.put_line(json_object_t.get_string(badobj3, 'foo'));
    badobj4 := json_object_t.clone(badobj3);
    dbms_output.put_line(json_object_t.get_string(badobj4, 'foo'));
    badarr := json_object_t.get_array(badobj, 'baz');
    dbms_output.put_line(json_array_t.get_string(badarr, 0));

    execute immediate json_object_t.get_string(badobj, 'foo');                  -- CWEID 89
    execute immediate json_object_t.get_string(badobj2, 'foo');                 -- CWEID 89
    execute immediate to_char(badclob);                 -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(dbms_lob.substr(badblob));                   -- CWEID 89
    execute immediate json_object_t.get_string(badobj3, 'foo');                 -- CWEID 89
    execute immediate json_object_t.get_string(badobj4, 'foo');                 -- CWEID 89
    execute immediate json_array_t.get_string(badarr, 0);                   -- CWEID 89
end json1;
/

create or replace procedure json2(foo in varchar2)
is
    badobj json_object_t;
    badobj2 json_object_t;
    badobj3 json_object_t;
    badobj4 json_object_t;
    badelem json_element_t;
    badarr json_array_t;
    badclob clob;
    badblob blob;

    goodobj json_object_t;
    goodobj2 json_object_t;
    goodobj3 json_object_t;
    goodobj4 json_object_t;
    goodelem json_element_t;
    goodarr json_array_t;
    goodclob clob;
    goodblob blob;
begin
    goodobj := json_object_t.parse('{foo: "FOO", bar: { foo: "BARFOO" }, baz: ["BAZFOO"]}');
    dbms_output.put_line(goodobj.get_string('foo'));
    goodelem := goodobj.get('bar');
    goodobj2 := treat(goodelem as json_object_t);
    dbms_output.put_line(goodobj2.get_string('foo'));
    goodclob := goodobj2.get_clob('foo');
    dbms_output.put_line(to_char(goodclob));
    goodblob := goodobj2.get_blob('foo');
    dbms_output.put_line(utl_raw.cast_to_varchar2(dbms_lob.substr(goodblob)));
    goodobj3 := goodobj.get_object('bar');
    dbms_output.put_line(goodobj3.get_string('foo'));
    goodobj4 := goodobj3.clone();
    dbms_output.put_line(goodobj4.get_string('foo'));
    goodarr := goodobj.get_array('baz');
    dbms_output.put_line(goodarr.get_string(0));

    execute immediate goodobj.get_string('foo');
    execute immediate goodobj2.get_string('foo');
    execute immediate to_char(goodclob);
    execute immediate utl_raw.cast_to_varchar2(dbms_lob.substr(goodblob));
    execute immediate goodobj3.get_string('foo');
    execute immediate goodobj4.get_string('foo');
    execute immediate goodarr.get_string(0);

    badobj := json_object_t.parse(foo);
    dbms_output.put_line(badobj.get_string('foo'));
    badelem := badobj.get('bar');
    badobj2 := treat(badelem as json_object_t);
    dbms_output.put_line(badobj2.get_string('foo'));
    badclob := badobj2.get_clob('foo');
    dbms_output.put_line(to_char(badclob));
    badblob := badobj2.get_blob('foo');
    dbms_output.put_line(utl_raw.cast_to_varchar2(dbms_lob.substr(badblob)));
    badobj3 := badobj.get_object('bar');
    dbms_output.put_line(badobj3.get_string('foo'));
    badobj4 := badobj3.clone();
    dbms_output.put_line(badobj4.get_string('foo'));
    badarr := badobj.get_array('baz');
    dbms_output.put_line(badarr.get_string(0));

    execute immediate badobj.get_string('foo');                             -- CWEID 89
    execute immediate badobj2.get_string('foo');                                -- CWEID 89
    execute immediate to_char(badclob);                             -- CWEID 89
    execute immediate utl_raw.cast_to_varchar2(dbms_lob.substr(badblob));                               -- CWEID 89
    execute immediate badobj3.get_string('foo');                                -- CWEID 89
    execute immediate badobj4.get_string('foo');                                -- CWEID 89
    execute immediate badarr.get_string(0);                             -- CWEID 89

end json2;
/
