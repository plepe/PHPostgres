CREATE OR REPLACE FUNCTION json_encode(hstore)
RETURNS text
AS $$
DECLARE
  value	ALIAS FOR $1;
  entry	record;
  list	text[]=Array[]::text[];
BEGIN
  for entry in select * from each(value) loop
-- Quote characters
    entry.key=replace(entry.key, E'\\', E'\\\\');
    entry.key=replace(entry.key, E'"', E'\\"');
    entry.key=replace(entry.key, E'\b', E'\\b');
    entry.key=replace(entry.key, E'\t', E'\\t');
    entry.key=replace(entry.key, E'\n', E'\\n');
    entry.key=replace(entry.key, E'\f', E'\\f');
    entry.key=replace(entry.key, E'\r', E'\\r');
    entry.value=replace(entry.value, E'\\', E'\\\\');
    entry.value=replace(entry.value, E'"', E'\\"');
    entry.value=replace(entry.value, E'\b', E'\\b');
    entry.value=replace(entry.value, E'\t', E'\\t');
    entry.value=replace(entry.value, E'\n', E'\\n');
    entry.value=replace(entry.value, E'\f', E'\\f');
    entry.value=replace(entry.value, E'\r', E'\\r');

-- add to list of prepared return strings
    list:=array_append(list, '"'||entry.key||'":"'||entry.value||'"');
  end loop;

-- write {} around values and separate by ,
  return '{'||array_to_string(list, ',')||'}';
END
$$ LANGUAGE 'plpgsql';
