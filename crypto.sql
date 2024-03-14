set serveroutput on;

create or replace procedure crypto1(foo in varchar2)
is
    inraw raw(1000);
    outraw raw(1000);
begin
    outraw := dbms_crypto.hash(to_clob('foo'), DBMS_CRYPTO.HASH_MD5);       -- CWEID 327
    dbms_output.put_line(outraw);
    outraw := dbms_crypto.hash(to_clob('foo'), DBMS_CRYPTO.HASH_MD4);       -- CWEID 327
    dbms_output.put_line(outraw);
    outraw := dbms_crypto.hash(to_clob('foo'), DBMS_CRYPTO.HASH_SH1);
    dbms_output.put_line(outraw);
    outraw := dbms_crypto.hash(to_clob('foo'), DBMS_CRYPTO.HASH_SH256);
    dbms_output.put_line(outraw);

    dbms_crypto.encrypt(                        -- CWEID 798
        src => outraw,
        dst => inraw, 
        typ => DBMS_CRYPTO.ENCRYPT_AES128 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5, 
        key => utl_raw.cast_to_raw('secret123')
    );
    dbms_output.put_line(inraw);

    dbms_crypto.encrypt(                        -- CWEID 327
        src => outraw,
        dst => inraw, 
        typ => DBMS_CRYPTO.ENCRYPT_DES, 
        key => utl_raw.cast_to_raw(foo)
    );
    dbms_output.put_line(inraw);

    dbms_crypto.encrypt(                        -- CWEID 327
        src => outraw,
        dst => inraw, 
        typ => DBMS_CRYPTO.ENCRYPT_3DES_2KEY, 
        key => utl_raw.cast_to_raw(foo)
    );
    dbms_output.put_line(inraw);

    dbms_crypto.encrypt(                        -- CWEID 327
        src => outraw,
        dst => inraw, 
        typ => DBMS_CRYPTO.ENCRYPT_3DES, 
        key => utl_raw.cast_to_raw(foo)
    );
    dbms_output.put_line(inraw);

    dbms_crypto.encrypt(                        -- CWEID 327
        src => outraw,
        dst => inraw, 
        typ => DBMS_CRYPTO.ENCRYPT_RC4, 
        key => utl_raw.cast_to_raw(foo)
    );
    dbms_output.put_line(inraw);


end crypto1;
/

