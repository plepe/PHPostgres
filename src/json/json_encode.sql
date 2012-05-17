CREATE OR REPLACE FUNCTION json_encode(text)
RETURNS text
AS $$
DECLARE
  value	ALIAS FOR $1;
  ret text;
BEGIN
  ret:=value;

-- Quote characters
  ret=replace(ret, E'\\', E'\\\\');
  ret=replace(ret, E'"', E'\\"');
  ret=replace(ret, E'\b', E'\\b');
  ret=replace(ret, E'\t', E'\\t');
  ret=replace(ret, E'\n', E'\\n');
  ret=replace(ret, E'\f', E'\\f');
  ret=replace(ret, E'\r', E'\\r');

-- Enclose in ", return
  return '"'||ret||'"';
END
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION json_encode(bigint)
RETURNS text
AS $$
  select cast($1 as text);
$$ LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION json_encode(float)
RETURNS text
AS $$
  select cast($1 as text);
$$ LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION json_encode(hstore)
RETURNS text
AS $$
DECLARE
  value	ALIAS FOR $1;
  entry	record;
  list	text[]=Array[]::text[];
BEGIN
  for entry in select * from each(value) loop
-- add to list of prepared return strings
    list:=array_append(list, json_encode(entry.key)||':'||json_encode(entry.value));
  end loop;

-- write {} around values and separate by ,
  return '{'||array_to_string(list, ',')||'}';
END
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION json_encode(anyarray)
RETURNS text
AS $$
DECLARE
  value	ALIAS FOR $1;
  entry	record;
  list	text[]=Array[]::text[];
BEGIN
  for entry in select unnest as value from unnest(value) loop
-- add to list of prepared return strings
    list:=array_append(list, json_encode(entry.value));
  end loop;

-- write {} around values and separate by ,
  return '['||array_to_string(list, ',')||']';
END
$$ LANGUAGE 'plpgsql';
