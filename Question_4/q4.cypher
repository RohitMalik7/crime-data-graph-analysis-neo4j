//Query 1: 
MATCH (c:Crime)-[:COMMITTED_IN]->(n:Neighbourhood)
MATCH (c)-[:OCCURRED_ON]->(m:Month)
WHERE c.crime_type = 'house_number' 
AND n.name = 'Grove Park'
AND m.year = 2010 
AND m.month_name IN ['April', 'May']
RETURN n.name AS Neighbourhood, 
       c.crime_type AS Crime_Type, 
       count(c) AS Crime_Count,
       collect(m.month_name) AS Months;

Visualization for Query 1:
MATCH (c:Crime)-[:COMMITTED_IN]->(n:Neighbourhood)
MATCH (c)-[:OCCURRED_ON]->(m:Month)
WHERE c.crime_type = 'house_number' 
AND n.name = 'Grove Park'
AND m.year = 2010 
AND m.month_name IN ['April', 'May']
RETURN c, n, m;


// Query 2: Neighbourhoods sharing the same crime types
MATCH (n1:Neighbourhood)<-[:COMMITTED_IN]-(c1:Crime)
MATCH (n2:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)
WHERE n1.name < n2.name // Avoid duplicate pairs
AND c1.crime_type = c2.crime_type
WITH n1.name AS Neighbourhood1, 
     n2.name AS Neighbourhood2, 
     collect(DISTINCT c1.crime_type) AS Common_Crimes
RETURN Neighbourhood1, Neighbourhood2, Common_Crimes, 
       size(Common_Crimes) AS Number_Of_Common_Crimes
ORDER BY Number_Of_Common_Crimes DESC
LIMIT 10

Visualization for Query 2:
MATCH (n1:Neighbourhood)<-[:COMMITTED_IN]-(c1:Crime)
MATCH (n2:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)
WHERE n1.name < n2.name 
AND c1.crime_type = c2.crime_type
WITH n1, n2, collect(DISTINCT c1.crime_type) AS common_crimes
ORDER BY size(common_crimes) DESC
LIMIT 5
MATCH (n1)<-[:COMMITTED_IN]-(c1:Crime)
MATCH (n2)<-[:COMMITTED_IN]-(c2:Crime)
WHERE c1.crime_type = c2.crime_type
AND c1.crime_type IN common_crimes
RETURN n1, n2, c1, c2
LIMIT 30



// Query 3: Top 5 neighbourhoods for 'shop' in April-May 2010

MATCH (c:Crime)-[:COMMITTED_IN]->(n:Neighbourhood)
MATCH (c)-[:OCCURRED_ON]->(m:Month)
WHERE c.crime_type = 'shop'
AND m.year = 2010
AND m.month_name IN ['April', 'May']
WITH n.name AS Neighbourhood, count(c) AS Crime_Count
ORDER BY Crime_Count DESC
LIMIT 5
RETURN Neighbourhood, Crime_Count


// Visualization for Query 3

MATCH (c:Crime)-[:COMMITTED_IN]->(n:Neighbourhood)
MATCH (c)-[:OCCURRED_ON]->(m:Month)
WHERE c.crime_type = 'shop'
AND m.year = 2010
AND m.month_name IN ['April', 'May']
WITH n, count(c) AS crime_count
ORDER BY crime_count DESC
LIMIT 5
MATCH (n)<-[:COMMITTED_IN]-(c:Crime)-[:OCCURRED_ON]->(m)
WHERE c.crime_type = 'shop'
AND m.year = 2010
AND m.month_name IN ['April', 'May']
RETURN n, c, m
LIMIT 50



//Query 4

MATCH (p:PropertyType)<-[:HAPPENED_AT]-(c:Crime)
WITH p.type AS Property_Address, collect(DISTINCT c.crime_type) AS Crime_Types
RETURN Property_Address, Crime_Types, size(Crime_Types) AS Crime_Type_Count
ORDER BY Crime_Type_Count DESC
LIMIT 10


// Visualization for Query 4

MATCH (p:PropertyType)<-[:HAPPENED_AT]-(c:Crime)
WHERE p.type IN [
  '3393 PEACHTREE RD NE',
  '3500 MT GILEAD RD',
  '1024 LITTLE HAMPTON CT SE'
]
RETURN p, c
LIMIT 50


//Query 5:

MATCH (b:Beat)<-[:ASSIGNED_TO]-(c:Crime)-[:OCCURRED_ON]->(m:Month)
WHERE m.year = 2010
WITH b.beat_id AS Beat, m.month_name AS Month, count(c) AS Crime_Count
WITH Beat, collect({month: Month, count: Crime_Count}) AS Monthly_Counts
WITH Beat, Monthly_Counts, 
     reduce(highest = {month: null, count: 0}, x IN Monthly_Counts | 
            CASE WHEN x.count > highest.count THEN x ELSE highest END) AS Highest_Month
RETURN Beat, Highest_Month.month AS Month_With_Highest_Crime, Highest_Month.count AS Crime_Count
ORDER BY Crime_Count DESC


//Visualization for Query 5:

MATCH (b:Beat)<-[:ASSIGNED_TO]-(c:Crime)-[:OCCURRED_ON]->(m:Month)
WHERE m.year = 2010
WITH b, m, count(c) AS crime_count
ORDER BY crime_count DESC
LIMIT 5
MATCH (b)<-[:ASSIGNED_TO]-(c:Crime)-[:OCCURRED_ON]->(m)
WHERE m.year = 2010
RETURN b, c, m
LIMIT 50


//Query 6:

MATCH (z1:Zone)<-[:LOCATED_IN]-(n1:Neighbourhood)<-[:COMMITTED_IN]-(c1:Crime)-[:OCCURRED_ON]->(m1:Month)
MATCH (z2:Zone)<-[:LOCATED_IN]-(n2:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)-[:OCCURRED_ON]->(m2:Month)
WHERE z1 <> z2 AND m1 = m2
AND m1.year = 2010
WITH z1, z2, m1.month_name AS Month, count(DISTINCT c1) + count(DISTINCT c2) AS Total_Crimes
WITH z1.name AS Zone1, z2.name AS Zone2, Month, Total_Crimes
ORDER BY Total_Crimes DESC
LIMIT 15
RETURN Zone1, Zone2, Month, Total_Crimes


//Visualization for Query 6:

MATCH (z1:Zone)<-[:LOCATED_IN]-(n1:Neighbourhood)<-[:COMMITTED_IN]-(c1:Crime)-[:OCCURRED_ON]->(m1:Month)
MATCH (z2:Zone)<-[:LOCATED_IN]-(n2:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)-[:OCCURRED_ON]->(m2:Month)
WHERE z1 <> z2 AND m1 = m2
AND m1.year = 2010
WITH z1, z2, m1, count(DISTINCT c1) + count(DISTINCT c2) AS total_crimes
ORDER BY total_crimes DESC
LIMIT 3
MATCH path1 = (z1)<-[:LOCATED_IN]-(n1:Neighbourhood)<-[:COMMITTED_IN]-(c1:Crime)-[:OCCURRED_ON]->(m1)
MATCH path2 = (z2)<-[:LOCATED_IN]-(n2:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)-[:OCCURRED_ON]->(m1)
WHERE z1 <> z2
RETURN path1, path2
LIMIT 20