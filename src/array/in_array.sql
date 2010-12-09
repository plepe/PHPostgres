create or replace function in_array(text, text[])
  returns bool
  as $$
declare
  val alias for $1;
  arr alias for $2;
  i   int:=1;
begin
  if array_lower(arr, 1) is null then
    return false;
  end if;

  for i in array_lower(arr, 1)..array_upper(arr, 1) loop
    if arr[i]=val then
      return true;
    end if;
  end loop;
  return false;
end;
$$ language 'plpgsql';


