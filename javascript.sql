set serveroutput on;

create or replace procedure javascript1(person_name in varchar2)
is
  ctx dbms_mle.context_handle_t;
  source clob;
  greeting varchar2(100);
begin
  ctx := dbms_mle.create_context();
  dbms_mle.export_to_mle(ctx, 'person', person_name); -- no issue, correct way to get data from SQL to JS.
  source := q'~
    var bindings = require("mle-js-bindings");
    var person = bindings.importValue("person");
    var greeting = "Hello, " + person + "!";
    bindings.exportValue("greeting", greeting);
  ~';
  dbms_mle.eval(ctx, 'JAVASCRIPT', source); 
  dbms_mle.import_from_mle(ctx, 'greeting', greeting);
  dbms_output.put_line('Greetings from MLE: ' || greeting); -- fine because output from JS will be escaped
  dbms_mle.drop_context(ctx);

  ctx := dbms_mle.create_context();
  -- the following is CWEID 89 due to the concatenation
  -- Technically "arbitrary" JS could be executed but primary danger is the SQL API due to JS env constraints
  source := q'~
    var bindings = require("mle-js-bindings");
    var person = bindings.importValue("person"); 
    var greeting = "Hello, ~' || person_name || q'~ !"; 
    bindings.exportValue("greeting", greeting);~';
  dbms_mle.eval(ctx, 'JAVASCRIPT', source); 
  dbms_mle.import_from_mle(ctx, 'greeting', greeting);
  dbms_output.put_line('Greetings from MLE: ' || greeting); -- fine because output from JS will be escaped
  dbms_mle.drop_context(ctx);
end javascript1;
/