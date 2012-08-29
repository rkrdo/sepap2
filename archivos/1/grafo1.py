import json
import networkx as nx
import pyodbc
from networkx.readwrite import json_graph

G = nx.DiGraph()

db = pyodbc.connect('DRIVER={Vertica};SERVER=localhost;DATABASE=quetzal;UID=quetzal;PWD=hplabs')
#db = MySQLdb.connect("localhost", "root", "Plan30", "sna")
cur = db.cursor()

#cur.execute("select n.id, n.gender, n.country, n.zip, coalesce(sum(spent),0) as spent from nodes n left outer join orders o on n.id = o.node_id group by n.id;")
#rows = cur.fetchall()
#for row in rows:
#	G.add_node(int(row[0]), gender=row[1], country=row[2], zip=row[3], spent=row[4])
	
cur.execute('select * from edges where source in (select id from "nodes") and target in (select id from "nodes") and target <> source order by source, target limit 10;')
rows = cur.fetchall()
for row in rows:
	G.add_edge(int(row[2]), int(row[3]))
	

out_degree = G.out_degree()
nx.set_node_attributes(G,'out_degree',out_degree)

degree = nx.degree(G)
nx.set_node_attributes(G,'degree',degree)

centrality = nx.closeness_centrality(G)
nx.set_node_attributes(G,'centrality',centrality)

d = json_graph.node_link_data(G)
json.dump(d, open('grafo.json', 'w'))
print "wrote json into grafo.json"
db.close()
