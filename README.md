# Flight-data-analysis-using-pig

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Abstract
This project utilizes Apache Pig for in-depth analysis of flight data, focusing on specific problem statements within the aviation domain. The dataset encompasses detailed flight information and airport data, requiring extensive data exploration, cleaning, and targeted analyses. The project identifies the top 5 most visited destinations, determines the month with the highest cancellations due to adverse weather conditions, lists the top ten origins with the highest average departure delay, and presents routes with the maximum number of diversions. Leveraging Pig Latin scripts, the analysis involves join operations and insightful data enrichment, offering actionable insights for airlines to optimize routes, allocate resources, and enhance operational efficiency.

## Project Description
Introduction:
This project aims to conduct a comprehensive analysis of flight data, focusing on various aspects such as top destinations, cancellations due to bad weather, departure delays, and diversions. By leveraging Pig Latin scripting, we intend to extract meaningful insights from the provided datasets.

Objectives:
Identify and analyze the top 5 most visited destinations.
Determine the month with the highest number of cancellations due to bad weather.
Explore the top ten origins with the highest average departure delay.
Identify the routes (origin-destination pairs) that have experienced the maximum diversions.

Context:
In the aviation industry, understanding patterns and trends in flight data is crucial for enhancing operational efficiency and passenger experience. Through this analysis, we aim to provide actionable insights for stakeholders, including airlines, airports, and regulatory bodies.

Datasets:
The primary datasets used in this analysis are:

flights_details.csv: Contains detailed information about individual flights, including origin, destination, cancellation details, and departure delays.
airports.csv: Provides additional information about airports, including location details and country information.
Key Fields in Datasets
flights_details.csv:

Year (Column 1)
Flight Number (Column 10)
Origin Airport Code (Column 17)
Destination Airport Code (Column 18)
Month (Column 2)
Cancellation Information (Columns 22 and 23)
Departure Delay (Column 16)
Diversion Information (Column 24)
Airports.csv:

Airport Code (Column 0)
City (Column 2)
Country (Column 4)
These key fields form the basis for our analysis, allowing us to derive meaningful insights related to flight destinations, cancellations, delays, and diversions.


## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Contact](#contact)
- [Support](#support)

## Installation

Describe any specific installation steps or dependencies that users need to be aware of.

```bash
git clone https://github.com/your-username/your-repository.git
cd your-repository
npm install  # or other dependency management commands
