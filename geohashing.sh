#!/bin/bash

# Function to execute redis-cli commands through Docker
redis_cli() {
    docker exec -it redis-server redis-cli "$@"
}

# Step 1: Ping Redis server
echo "Pinging Redis server:"
redis_cli PING "hi"

# Step 2: Display the total number of keys in the database
echo "Total keys in DB:"
redis_cli DBSIZE

# Step 3: Add Geospatial data
echo "Adding Geospatial data..."
redis_cli GEOADD places 13.361389 38.115556 "Palermo"
redis_cli GEOADD places 15.087269 37.502669 "Catania"
redis_cli GEOADD places 13.583333 37.316667 "Agrigento"
echo "Geospatial data added."

# Step 4: Query geospatial data
echo "Locations within 100 km of Palermo:"
redis_cli GEORADIUS places 13.361389 38.115556 100 km

# Step 5: Calculate and display the distance between Palermo and Catania
distance=$(redis_cli GEODIST places Palermo Catania km)
echo "Distance between Palermo and Catania: ${distance} km"
Ø