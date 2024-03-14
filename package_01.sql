set serveroutput on;

DROP TABLE book_tbl;
CREATE TABLE book_tbl (
    id number NOT NULL,
    title varchar2(1000),
    description varchar2(2000)
);

INSERT INTO book_tbl (id, title, description) VALUES (1, 'book one', 'This is the first book in the series.');
INSERT INTO book_tbl (id, title, description) VALUES (2, 'book two', 'This is the second book in the series.');

DROP SEQUENCE book_tbl_id_seq;
CREATE SEQUENCE book_tbl_id_seq START WITH 100;

CREATE TRIGGER book_tbl_id_trig 
BEFORE INSERT ON book_tbl
FOR EACH ROW
BEGIN
    SELECT book_tbl_id_seq.nextval INTO :new.id FROM DUAL;
END;
/