select 4. + 3.5 from dual;

select 4.f from dual;

select 0.31337 from dual;

select 3.00e+10 from dual;
select 3.00e-10 from dual;
select 3.00e10 from dual;
select 2d from dual;
select 3f from dual;
select 1E8 from dual;
select 1E8D from dual;

select .80e+10 from dual;
select .80e-10 from dual;
select .80e10 from dual;
select .80E10 from dual;
select 1.E15 from dual;

create or replace function getthree
return number
is
begin
    return 3;
end getthree;
/

create or replace procedure dostuff
is
    v_num1 number;
    e8 number;
    e number;
    f number;
    g number;
    psql varchar2(2000);
begin
    v_num1 := 4;
    psql := q'[wat]';
    psql := q'~wat~';
    psql := n'~wat~';

    FOR v_LoopIndex IN 1..v_num1 LOOP
        dbms_output.put_line('loop: ' || v_LoopIndex);
    END LOOP;

    FOR v_LoopIndex IN 1.0..v_num1 LOOP
        dbms_output.put_line('loop: ' || v_LoopIndex);
    END LOOP;
    FOR v_LoopIndex IN 0.5..v_num1 LOOP
        dbms_output.put_line('loop: ' || v_LoopIndex);
    END LOOP;
    FOR v_LoopIndex IN .5..v_num1 LOOP
        dbms_output.put_line('loop: ' || v_LoopIndex);
    END LOOP;
    FOR v_LoopIndex IN getthree()..v_num1 LOOP
        dbms_output.put_line('loop: ' || v_LoopIndex);
    END LOOP;
    FOR v_LoopIndex IN 1.f..v_num1 LOOP
        dbms_output.put_line('loop: ' || v_LoopIndex);
    END LOOP;
    FOR v_LoopIndex IN 2.00e+0..v_num1 LOOP
        dbms_output.put_line('loop: ' || v_LoopIndex);
    END LOOP;

    if e > 1.e15 then
        dbms_output.put_line('greater than');
    end if;
    if e > 1e8 then
        dbms_output.put_line('greater than');
    end if;


end dostuff;
/

exec dostuff;
