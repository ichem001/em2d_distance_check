#Summary
This repository takes a sets of two scores from em2d (see Integrative Modeling Platform) and compute affinity of structural models to both models. 

##Cluster-EM2D_A.sub
SGE submit script to compute em2d scores with proper formatting

##Analysis_em2d_zscores.sh
Read raw scores files (here two but easy to adapt) and compute an image composite Z-score for each structural models used. 

##Compute_Distances_PDB.py
Compute teh distance between two residues (C_{\alpha} distance). 
To run: python Compute_Distances_PDB.py pdbfile chain1 residue1 chain2 residue2