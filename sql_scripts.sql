-- Find the neighborhoods for each trip's start and end locations
select t.trip_id, h."LISTNAME" as start_hood, h2."LISTNAME" as end_hood from indego_trips_smallest t
left join philly_hoods h 
on ST_COVERS(
  ST_GEOGFROMGEOJSON(h."Geometry"),
  ST_GEOGFROMTEXT('POINT(' || t.start_lon || ' ' || t.start_lat || ')')
) 
left join philly_hoods h2
on ST_COVERS(
  ST_GEOGFROMGEOJSON(h2."Geometry"),
  ST_GEOGFROMTEXT('POINT(' || t.end_lon || ' ' || t.end_lat || ')')
);

-- Count trips by start neighborhoods
select h."LISTNAME" as start_hood, count(*) as count from indego_trips_smallest t
left join philly_hoods h 
on ST_COVERS(
  ST_GEOGFROMGEOJSON(h."Geometry"),
  ST_GEOGFROMTEXT('POINT(' || t.start_lon || ' ' || t.start_lat || ')')
) 
group by h."LISTNAME"
order by count desc;

-- Count trips by end neighborhoods
select h."LISTNAME" as end_hood, count(*) as count from indego_trips_smallest t
left join philly_hoods h 
on ST_COVERS(
  ST_GEOGFROMGEOJSON(h."Geometry"),
  ST_GEOGFROMTEXT('POINT(' || t.end_lon || ' ' || t.end_lat || ')')
) 
group by h."LISTNAME"
order by count desc;

-- Find the longest trips and their start and end neighborhoods
select t.trip_id, t.duration, h."LISTNAME" as start_hood, h2."LISTNAME" as end_hood from indego_trips_smallest t
left join philly_hoods h 
on ST_COVERS(
  ST_GEOGFROMGEOJSON(h."Geometry"),
  ST_GEOGFROMTEXT('POINT(' || t.start_lon || ' ' || t.start_lat || ')')
) 
left join philly_hoods h2
on ST_COVERS(
  ST_GEOGFROMGEOJSON(h2."Geometry"),
  ST_GEOGFROMTEXT('POINT(' || t.end_lon || ' ' || t.end_lat || ')')
)
order by duration desc limit 20;