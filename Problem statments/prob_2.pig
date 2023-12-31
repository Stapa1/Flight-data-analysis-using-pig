-- Load data
flight_data = LOAD '/Users/stapa1/Documents/Big_Data/flights_details.csv' USING PigStorage(',');
gen_flight_data_1 = FOREACH flight_data GENERATE (int)$2 AS month, (int)$10 AS flight_num, (int)$22 AS cancelled, (chararray)$23 AS cancel_code;

-- Filter data for cancellations due to bad weather
fltr_data = FILTER gen_flight_data_1 BY cancelled == 1 AND cancel_code == 'B';

-- Group data by month
grp_month = GROUP fltr_data BY month;

-- Count cancellations for each month
gen_grp = FOREACH grp_month GENERATE group AS month, COUNT(fltr_data) AS cancellation_count;

-- Find the month with the most cancellations
most_cancellations_month = ORDER gen_grp BY cancellation_count DESC;
most_cancellations_month = LIMIT most_cancellations_month 1;

-- Output the result for the month with the most cancellations (without flight number)
top_month_no_flight_num = FOREACH most_cancellations_month GENERATE month, cancellation_count;

-- Display the top result without the flight number
DUMP top_month_no_flight_num;

-- Load data
flight_data = LOAD '/Users/stapa1/Documents/Big_Data/flights_details.csv' USING PigStorage(',');
gen_flight_data_1 = FOREACH flight_data GENERATE (int)$2 AS month, (int)$10 AS flight_num, (int)$22 AS cancelled, (chararray)$23 AS cancel_code;

-- Group data by month and flight number
grp_month_flight = GROUP gen_flight_data_1 BY (month, flight_num);

-- Count cancellations for each month and flight number
gen_grp_flight = FOREACH grp_month_flight GENERATE
    group.month AS month,
    group.flight_num AS flight_num,
    COUNT(gen_flight_data_1.cancelled) AS cancellation_count;

-- Find the top 3 months with the most cancellations
top3_months = ORDER gen_grp_flight BY cancellation_count DESC;
top3_months = LIMIT top3_months 3;

-- Output the top 3 months with the most cancellations
DUMP top_month_no_flight_num;
DUMP top3_months;
