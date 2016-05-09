#!/usr/bin/env python
import sys, os
from math import sqrt 

###Scripts to compute distance between two residues in PDB files without external libraries (except native python).
### Given a PDB, Chain 1, Residue 1, Chain 2, and Residue 2, compute the distance between Cα's of Residue 1 and Residue 2. 
###Make sure the residue you import are matches record from PDB
coords = []
with open(sys.argv[1], 'r') as pdb:
	for line in pdb:
		if line[0:4]=="ATOM" and line[13:15]=="CA":
			coords.append(line.strip("\n"))

x1=x2=y1=y2=z1=z2=0.0
res1=res2=0
for coord in coords:
	if coord[21:22]==sys.argv[2] and int(coord[22:26])==int(sys.argv[3]):
		x1=float(coord[30:38])
		y1=float(coord[38:46])
		z1=float(coord[46:54])
		res1=int(coord[22:26])
		print(coord)
	if coord[21:22]==sys.argv[4] and int(coord[22:26])==int(sys.argv[5]):
		x2=float(coord[30:38])
		y2=float(coord[38:46])
		z2=float(coord[46:54])
		res2=int(coord[22:26])
		print(coord)
print(res1, res2, sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1)))

