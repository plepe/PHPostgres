create or replace function strtr(text, text, text)
  returns text
  as $$
select replace($1, $2, $3);
$$ language 'sql' immutable;

create or replace function strtr(text, hstore)
  returns text
  as $$
declare
  str alias for $1;
  repl alias for $2;
  repl_keys text[];
  ret text;
begin
  repl_keys:=akeys(repl);
  ret:=str;

  for i in array_lower(repl_keys, 1)..array_upper(repl_keys, 1) loop
    ret:=replace(ret, repl_keys[i], repl->repl_keys[i]);
  end loop;
  
  return ret;
end;
$$ language 'plpgsql' immutable;
