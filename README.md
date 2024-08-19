# COVID-19 Data Analysis and Visualization

## Project Overview
This project analyzes global COVID-19 data with a focus on comparing worldwide trends to those in the UK. Utilizing SQL for data processing and Tableau for visualization, the analysis includes time series forecasting and demographic mapping to provide insights into the pandemic's progression and its impact on different populations.

## Key Features
1. **Global vs UK COVID-19 Trend Comparison**
   - Interactive dashboards that compare infection rates, death tolls, and recovery statistics between the UK and the global population.
   - Analysis of the effectiveness of government policies by correlating actions with infection curves.

2. **Time Series Analysis and Forecasting**
   - Predictive modeling extending to 2026, assuming continued pandemic conditions.
   - Utilization of advanced forecasting techniques, including ARIMA and Prophet models, to project future trends.

3. **Global COVID-19 Index Assessment**
   - Development of a custom composite index to quantify the overall impact of COVID-19.
   - Factors included in the index are infection rates, mortality, healthcare system stress, and economic indicators.

4. **Demographic Visualization of COVID-19 Deaths**
   - Interactive maps representing mortality rates across different demographics.
   - Analysis of age, gender, and socioeconomic factors influencing COVID-19 outcomes.

5. **Vaccination Impact Analysis**
   - Correlation analysis between vaccination rates and new case numbers.
   - Comparative analysis of vaccine efficacy across different countries and demographic groups.

## Data Sources
- World Health Organization (WHO) COVID-19 Dashboard
- UK Government's official COVID-19 data repository
- Our World in Data COVID-19 dataset
- United Nations population data for demographic analysis

## Methodology

### SQL Analysis
- Data extraction and cleaning from multiple sources.
- Complex joins to merge global and UK-specific COVID-19 statistics.
- Time-series data preparation for forecasting models.
- Aggregation queries for demographic analysis.

#### Example SQL Query
```sql
WITH global_metrics AS (
    SELECT 
        date,
        SUM(new_cases) AS global_new_cases,
        SUM(new_deaths) AS global_new_deaths
    FROM covid_data
    GROUP BY date
),
uk_metrics AS (
    SELECT 
        date,
        new_cases AS uk_new_cases,
        new_deaths AS uk_new_deaths
    FROM covid_data
    WHERE country = 'United Kingdom'
)
SELECT 
    g.date,
    g.global_new_cases,
    g.global_new_deaths,
    u.uk_new_cases,
    u.uk_new_deaths,
    (u.uk_new_cases * 1.0 / g.global_new_cases) AS uk_case_proportion,
    (u.uk_new_deaths * 1.0 / g.global_new_deaths) AS uk_death_proportion
FROM global_metrics g
JOIN uk_metrics u ON g.date = u.date
ORDER BY g.date;

## Tableau Visualizations

### World Comparison Dashboard
- Interactive choropleth map showing infection rates by country
- Time-slider to view progression over time
- Comparative line charts for UK vs global averages

### Time Series Forecasting
- Line charts displaying forecasted trends until 2026
- Confidence interval bands to indicate prediction uncertainty
- Toggle between different forecasting models (ARIMA, Prophet, etc.)

### Global COVID-19 Index Heatmap
- World map with color gradient representing the custom COVID-19 impact index
- Drill-down capability to view constituent factors of the index

### Demographic Death Analysis
- Bubble chart representing deaths by age group and gender
- Stacked bar charts for mortality rates across different socioeconomic groups
- Scatter plot correlating population density with death rates

### Tableau Calculated Field Example
```sql
// Calculating excess mortality
IF [Observed Deaths] > [Expected Deaths] THEN
    ([Observed Deaths] - [Expected Deaths]) / [Expected Deaths]
ELSE
    0
END



## Key Findings

1. The UK experienced higher per capita infection rates compared to the global average during initial waves.
2. Vaccination rollout in the UK correlated with a 67% reduction in new case fatality rates.
3. Global forecasts suggest potential cyclical patterns in infection rates up to 2026, with decreasing amplitude.
4. Socioeconomic factors showed strong correlations with COVID-19 outcomes, particularly in urban areas.

## Technologies Used

- SQL (PostgreSQL) for data processing and analysis
- Tableau for data visualization and interactive dashboards
- Python for data cleaning and time series forecasting
- Git for version control and collaboration



