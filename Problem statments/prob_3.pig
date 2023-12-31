-- Problem Statement- 3: Top ten origins with the highest AVG departure delay

flight_data = LOAD '/Users/stapa1/Documents/Big_Data/flights_details.csv' USING PigStorage(',');
gen_flight_data_2 = FOREACH flight_data GENERATE (int)$16 AS dep_delay, (chararray)$17 AS origin;
flt = FILTER gen_flight_data_2 BY dep_delay IS NOT NULL AND origin IS NOT NULL;
grp = GROUP flt BY origin;
avg_delay = FOREACH grp GENERATE group AS origin, AVG(flt.dep_delay) AS avg_dep_delay;
result = ORDER avg_delay BY avg_dep_delay DESC;
top_ten = LIMIT result 10;
DUMP top_ten;
-- Loading airport data for origin lookup

lookup = LOAD '/Users/stapa1/Documents/Big_Data/airports.csv' USING PigStorage(',');
lookup_1 = FOREACH lookup GENERATE (chararray)$0 AS origin, (chararray)$2 AS city, (chararray)$4 AS country;
DUMP lookup_1;

-- Joining data to get city and country for the top 10 origins with highest AVG departure delay

joined = JOIN lookup_1 BY origin, top_ten BY origin;
final = FOREACH joined GENERATE $0 AS origin, $1 AS avg_dep_delay, $2 AS city, $4 AS country;
final_result = ORDER final BY avg_dep_delay DESC;
DUMP final_result;
