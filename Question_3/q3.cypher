// STEP 1: Create constraints for uniqueness (to improve performance and ensure data integrity)
CREATE CONSTRAINT crime_id_constraint IF NOT EXISTS FOR (c:Crime) REQUIRE c.crime_id IS UNIQUE;
CREATE CONSTRAINT neighbourhood_name_constraint IF NOT EXISTS FOR (n:Neighbourhood) REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT zone_name_constraint IF NOT EXISTS FOR (z:Zone) REQUIRE z.name IS UNIQUE;
CREATE CONSTRAINT property_type_constraint IF NOT EXISTS FOR (p:PropertyType) REQUIRE p.type IS UNIQUE;
CREATE CONSTRAINT beat_id_constraint IF NOT EXISTS FOR (b:Beat) REQUIRE b.beat_id IS UNIQUE;
CREATE CONSTRAINT month_year_constraint IF NOT EXISTS FOR (m:Month) REQUIRE (m.month_name, m.year) IS UNIQUE;

// STEP 2: Load the Crime nodes
LOAD CSV WITH HEADERS FROM 'file:///crime_nodes.csv' AS row
CREATE (c:Crime {
    crime_id: toInteger(row.crime_id),
    crime_type: row.crime_type,
    date: date(row.date),
    month: toInteger(row.month),
    year: toInteger(row.year)
})
SET c:Crime 
RETURN count(c);

// STEP 3: Load the Neighbourhood nodes 
LOAD CSV WITH HEADERS FROM 'file:///neighbourhood_nodes.csv' AS row
CREATE (n:Neighbourhood {
    name: row.name
})
SET n:Neighbourhood 
RETURN count(n);

// STEP 4: Load the Zone nodes
LOAD CSV WITH HEADERS FROM 'file:///zone_nodes.csv' AS row
CREATE (z:Zone {
    name: row.name
})
SET z:Zone 
RETURN count(z);

// STEP 5: Load the PropertyType nodes
LOAD CSV WITH HEADERS FROM 'file:///property_type_nodes.csv' AS row
CREATE (p:PropertyType {
    type: row.type
})
SET p:PropertyType 
RETURN count(p);

// STEP 6: Load the Beat nodes
LOAD CSV WITH HEADERS FROM 'file:///beat_nodes.csv' AS row
CREATE (b:Beat {
    beat_id: row.beat_id
})
SET b:Beat 
RETURN count(b);

// STEP 7: Load the Month nodes
LOAD CSV WITH HEADERS FROM 'file:///month_nodes.csv' AS row
CREATE (m:Month {
    month_name: row.month_name,
    year: toInteger(row.year)
})
SET m:Month 
RETURN count(m);

// STEP 8: Create COMMITTED_IN relationship (Crime → Neighbourhood)
LOAD CSV WITH HEADERS FROM 'file:///committed_in_relationships.csv' AS row
MATCH (c:Crime {crime_id: toInteger(row.crime_id)})
MATCH (n:Neighbourhood {name: row.neighbourhood_name})
CREATE (c)-[:COMMITTED_IN]->(n)
RETURN count(*);

// STEP 9: Create LOCATED_IN relationship (Neighbourhood → Zone)
LOAD CSV WITH HEADERS FROM 'file:///located_in_relationships.csv' AS row
MATCH (n:Neighbourhood {name: row.neighbourhood_name})
MATCH (z:Zone {name: row.zone_name})
CREATE (n)-[:LOCATED_IN]->(z)
RETURN count(*);

// STEP 10: Create HAPPENED_AT relationship (Crime → PropertyType)
LOAD CSV WITH HEADERS FROM 'file:///happened_at_relationships.csv' AS row
MATCH (c:Crime {crime_id: toInteger(row.crime_id)})
MATCH (p:PropertyType {type: row.property_type_type})
CREATE (c)-[:HAPPENED_AT]->(p)
RETURN count(*);

// STEP 11: Create OCCURRED_ON relationship (Crime → Month)
LOAD CSV WITH HEADERS FROM 'file:///occurred_on_relationships.csv' AS row
MATCH (c:Crime {crime_id: toInteger(row.crime_id)})
MATCH (m:Month {month_name: row.month_name, year: toInteger(row.year)})
CREATE (c)-[:OCCURRED_ON]->(m)
RETURN count(*);

// STEP 12: Create ASSIGNED_TO relationship (Crime → Beat)
LOAD CSV WITH HEADERS FROM 'file:///assigned_to_relationships.csv' AS row
MATCH (c:Crime {crime_id: toInteger(row.crime_id)})
MATCH (b:Beat {beat_id: row.beat_id})
CREATE (c)-[:ASSIGNED_TO]->(b)
RETURN count(*);

// STEP 13: Set different colors for each node label
// Note: In the Neo4j Browser, colors are set through the style guide
// Run this to verify data was loaded correctly
MATCH (n) 
RETURN labels(n) as NodeType, count(*) as Count
ORDER BY Count DESC;

// For visualization purposes, run this query to see sample connections
MATCH (c:Crime)-[:COMMITTED_IN]->(n:Neighbourhood)-[:LOCATED_IN]->(z:Zone)
RETURN c, n, z
LIMIT 10;

// or

MATCH (c:Crime)
MATCH (c)-[:COMMITTED_IN]->(n:Neighbourhood)
MATCH (c)-[:HAPPENED_AT]->(p:PropertyType)
MATCH (c)-[:OCCURRED_ON]->(m:Month)
MATCH (c)-[:ASSIGNED_TO]->(b:Beat)
RETURN c, n, p, m, b
LIMIT 5;