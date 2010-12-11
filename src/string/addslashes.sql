create or replace function addslashes(text)
  returns text
  as $$
declare
  str alias for $1;
  ret text;
begin
  ret:=replace(str, E'''', E'\\''');
  ret:=replace(ret, E'"', E'\\"');
  ret:=replace(ret, E'\\', E'\\\\');

  return ret;
end;
$$ language 'plpgsql' immutable;
