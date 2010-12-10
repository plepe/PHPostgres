-- Changes to php behaviour:
-- It will always print the content of the parameter AND return the value
create or replace function print_r(anyelement)
returns anyelement
as $$
begin
  raise notice '%', $1;
  return $1;
end
$$ language 'plpgsql';

