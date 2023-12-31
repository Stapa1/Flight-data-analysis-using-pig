
-- Problem Statement- 1: Find out the top 5 most visited destinations.

flight_data = LOAD '/Users/stapa1/Documents/Big_Data/flights_details.csv' USING PigStorage(',');

gen_flight_data = FOREACH flight_data GENERATE (int) $1 as year, (int)$10 as flight_num, (chararray)$17 as origin, (chararray)$18 as dest;
filter_null_values = FILTER gen_flight_data BY dest IS NOT NULL;
grp_dest = GROUP filter_null_values BY dest;
gen_count_dest = FOREACH grp_dest GENERATE group, COUNT(filter_null_values.dest) AS dest_count;
order_count_desc = ORDER gen_count_dest BY dest_count DESC;
limit_dest = LIMIT order_count_desc 5;
DUMP limit_dest;

-- Loading airport data
airport_data = LOAD '/Users/stapa1/Documents/Big_Data/airports.csv' USING PigStorage(',');

gen_airport_data = FOREACH airport_data GENERATE (chararray)$0 AS dest, (chararray)$2 AS city, (chararray)$4 AS country;
DUMP gen_airport_data;

-- Joining data to get city and country for the top 5 destinations

joined_data = JOIN limit_dest BY group, gen_airport_data BY dest;
count_desc = ORDER joined_data BY dest_count DESC;
data = FOREACH count_desc GENERATE $0 AS dest, $1 AS dest_count, $3 AS city, $4 AS country;
DUMP data;

