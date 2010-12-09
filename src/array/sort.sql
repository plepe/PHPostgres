create or replace function sort(anyarray)
returns anyarray language sql
as $$
select array(
  select $1[s.i] as "foo"
  from generate_series(array_lower($1,1), array_upper($1,1)) as s(i)
  order by foo
);
$$;


