CREATE OR REPLACE PROCEDURE CursorParamInj(descr_p in varchar2, descr_pinout in out varchar2, descr_impl varchar2, outputonly out varchar2, cursor_out in out SYS_REFCURSOR)
is
    type numlist is table of number;
    stmt varchar2(300);
    stmt2 varchar2(300);
    stmt3 varchar2(300);
    ids numlist;
    cursor_local SYS_REFCURSOR;

begin
    open cursor_local for 'select id from book_tbl'; -- No issue, although cursor is also IN parameter we should not consider left hand side of `for` as tainted. 
    fetch cursor_local bulk collect into ids;
    close cursor_local;

    open cursor_out for 'select id from book_tbl where description = ''' || descr_p || ' '''; -- CWEID 89, concat of `descr_p` into for selection. 
    fetch cursor_out bulk collect into ids;
    close cursor_out;

    stmt := 'select id from book_tbl where description = ''' || descr_p || ' ''';
    open cursor_out for stmt; -- CWEID 89, on `descr_p` being concatenated in `stmt`. 
    fetch cursor_out bulk collect into ids;
    close cursor_out;

    open cursor_local for stmt; -- CWEID 89, on `descr_p` being concatenated in `stmt`. 
    fetch cursor_local bulk collect into ids;
    close cursor_local;

    stmt2 := 'select id from book_tbl where description = ''' || descr_pinout || ' ''';
    open cursor_local for stmt2; -- CWEID 89, on `descr_pinout` (IN and OUT param) being concatenated in `stmt`. 
    fetch cursor_local bulk collect into ids;
    close cursor_local;

    outputonly := 'test';
    stmt3 := 'select id from book_tbl where description = ''' || outputonly || ' ''';
    open cursor_local for stmt3; -- No issue, `outputonly` does not contain tainted data being an OUT parameter. 
    fetch cursor_local bulk collect into ids;
    close cursor_local;

    open cursor_out for 'select id from book_tbl where description = :1' using descr_p; -- No issue, parameterized `desc_p`. 
    fetch cursor_out bulk collect into ids;
    close cursor_out;

    open cursor_local for 'select id from book_tbl where description = :1' using descr_pinout; -- No issue, parameterized `desc_pinout`. 
    fetch cursor_local bulk collect into ids;
    close cursor_local;

    open cursor_local for 'select id from book_tbl where description = :1 OR description = :2' using descr_p, descr_pinout; -- No issue, parameterized both `desc_p` and `desc_pinout`. 
    fetch cursor_local bulk collect into ids;
    close cursor_local;
    
    open cursor_local for 'select id from book_tbl where description = :1' using descr_p; -- No issue, parameterized `desc_p`. 
    fetch cursor_local bulk collect into ids;
    close cursor_local;

    open cursor_out for 'select id from book_tbl';  -- No issue, although cursor is also IN it should never flag on lefthand side of `for`.
    fetch cursor_out bulk collect into ids;
    close cursor_out;

end CursorParamInj;