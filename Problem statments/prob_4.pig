-- Problem Statement- 4: Which route (origin & destination) has seen the maximum diversion?

flight_data = LOAD '/Users/stapa1/Documents/Big_Data/flights_details.csv' USING PigStorage(',');
gen_flight_data_3 = FOREACH flight_data GENERATE (chararray)$17 AS origin, (chararray)$18 AS dest, (int)$24 AS diversion;
flt_1 = FILTER gen_flight_data_3 BY (origin IS NOT NULL) AND (dest IS NOT NULL) AND (diversion == 1);
grp_1 = GROUP flt_1 BY (origin, dest);
count_div = FOREACH grp_1 GENERATE group AS route, COUNT(flt_1.diversion) AS diversion_count;
order_desc = ORDER count_div BY diversion_count DESC;
result_1 = LIMIT order_desc 10;
DUMP result_1;
