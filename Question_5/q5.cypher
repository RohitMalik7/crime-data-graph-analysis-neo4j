//Query 1:

MATCH (n1:Neighbourhood)<-[:COMMITTED_IN]-(c1:Crime)
WITH n1, count(c1) AS crime_count
WHERE crime_count > 5
WITH n1
LIMIT 5

MATCH (n2:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)
WITH n1, n2
WHERE n1 <> n2

MATCH path = shortestPath((n1)-[:LOCATED_IN*1..2]-(n2))
RETURN n1.name AS From_Neighbourhood, 
       n2.name AS To_Neighbourhood,
       path,
       length(path) AS Path_Length
ORDER BY Path_Length
LIMIT 10


 //Visualization Query:

MATCH (n1:Neighbourhood)<-[:COMMITTED_IN]-(c1:Crime)
WITH n1, count(c1) AS crime_count
WHERE crime_count > 5
WITH n1
LIMIT 3

MATCH (n2:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)
WITH n1, n2
WHERE n1 <> n2

MATCH path = shortestPath((n1)-[:LOCATED_IN*1..2]-(n2))
RETURN path
LIMIT 10



//Query 2:

MATCH (c1:Crime)-[:COMMITTED_IN]->(n:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)
WHERE c1.crime_type <> c2.crime_type
  AND c1.crime_id < c2.crime_id

MATCH path = shortestPath((c1)-[:COMMITTED_IN|HAPPENED_AT*1..4]-(c2))
WHERE length(path) >= 2

RETURN c1.crime_type AS Crime_Type1, 
       c2.crime_type AS Crime_Type2,
       n.name AS Shared_Neighbourhood,
       length(path) AS Path_Length,
       path
LIMIT 10


 //Visualization Query:

 MATCH (c1:Crime)-[:COMMITTED_IN]->(n:Neighbourhood)<-[:COMMITTED_IN]-(c2:Crime)
WHERE c1.crime_type <> c2.crime_type
  AND c1.crime_id < c2.crime_id
  AND c1.crime_type IS NOT NULL
  AND c2.crime_type IS NOT NULL

MATCH path = shortestPath((c1)-[:COMMITTED_IN|HAPPENED_AT*1..4]-(c2))
WHERE length(path) >= 2

RETURN path
LIMIT 10