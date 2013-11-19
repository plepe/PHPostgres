CREATE OR REPLACE FUNCTION array_diff(
  IN  array1 ANYARRAY,
  IN  array2 ANYARRAY,
  OUT ret ANYARRAY
)
AS $$
declare
  i int;
begin
  if array_upper(array1, 1) is null then
    return;
  end if;

  for i in 1..array_upper(array1, 1) loop
    if array_search(array1[i], array2) is null then
      ret := array_append(ret, array1[i]);
    end if;
  end loop;

  return;
end
$$ language 'plpgsql' immutable;
