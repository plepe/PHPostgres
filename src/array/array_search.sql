CREATE OR REPLACE FUNCTION array_search(text[], text)
RETURNS int
AS $$
declare
haystack   alias for $1;
needle     alias for $2;
i int:=1;
begin
  while i<=sizeof(haystack) loop
    if haystack[i]=needle then
      return i;
    end if;
    i:=i+1;
  end loop;

  return null;
end
$$ language 'plpgsql';


