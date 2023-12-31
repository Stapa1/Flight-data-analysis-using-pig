-- Case Study on Flight Data

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

-- Problem Statement- 2: Which month has seen the most number of cancellations due to bad weather?

flight_data = LOAD '/Users/stapa1/Documents/Big_Data/flights_details.csv' USING PigStorage(',');
gen_flight_data_1 = FOREACH flight_data GENERATE (int)$2 AS month, (int)$10 AS flight_num, (int)$22 AS cancelled, (chararray)$23 AS cancel_code;
fltr_data = FILTER gen_flight_data_1 BY cancelled == 1 AND cancel_code == 'B';
grp_month = GROUP fltr_data BY month;
gen_grp = FOREACH grp_month GENERATE group AS month, COUNT(fltr_data.cancelled) AS cancellation_count;
DUMP gen_grp;

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

-- Problem Statement- 4: Which route (origin & destination) has seen the maximum diversion?

flight_data = LOAD '/Users/stapa1/Documents/Big_Data/flights_details.csv' USING PigStorage(',');
gen_flight_data_3 = FOREACH flight_data GENERATE (chararray)$17 AS origin, (chararray)$18 AS dest, (int)$24 AS diversion;
flt_1 = FILTER gen_flight_data_3 BY (origin IS NOT NULL) AND (dest IS NOT NULL) AND (diversion == 1);
grp_1 = GROUP flt_1 BY (origin, dest);
count_div = FOREACH grp_1 GENERATE group AS route, COUNT(flt_1.diversion) AS diversion_count;
order_desc = ORDER count_div BY diversion_count DESC;
result_1 = LIMIT order_desc 10;
DUMP result_1;
