# Lesson 5 – Weather App: API Fetching
For our last lesson, we will be building a Flutter application to fetch and parse weather data from MetaWeather.

## Part 1 - Visit the MetaWeather Docs
The API documentation for MetaWeather is located [here](https://www.metaweather.com/api/).  By making two calls to this API, we can acquire current weather data for the a given location.  The process for this is as follows:

### Perform a Location Search
In order to request the current weather information for a particular location, we first must obtain the corresponding WOEID (Where On Earth ID).

The respective URL endpoint for this query is: `https://www.metaweather.com/api/location/search/?query=(query)`.  You'll need to reference this later on.

*Example Usage:* [](https://www.metaweather.com/api/location/search/?query=los%20angeles)

MetaWeather's response fields (for a string query) include:

| Field        | Type  |
|:------------:|:-----:|
| title        | string|
| location_type| string|
| latt_long    | floats|
| woeid        | int   |

From our query results, we'll be saving the WOEID for later use.

### Perform a Weather Query Using WOEID
As some further background on the MetaWeather API, after obtaining the WOEID then we must perform a query on the current weather at that location.

The respective URL endpoint for this query is `https://www.metaweather.com/api/location/(woeid)/`

*Example Usage:* [](https://www.metaweather.com/api/location/2487956/)

## Part 2 - Part Name
TODO

## Bonus Challenges
TODO
