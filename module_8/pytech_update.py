import mysql.connector

# Connect to the database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="",
    database="pysports"
)

# Create a cursor
cursor = db.cursor()

# Write the query
query = "SELECT team_id, team_name, mascot FROM team"

# Execute the query
cursor.execute(query)

# Iterate over the cursor
for team in cursor:
    print(team)

# Close the cursor
cursor.close()

# Close the database
db.close()