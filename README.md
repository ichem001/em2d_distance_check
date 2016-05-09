#Summary
This repository takes a sets of two scores from em2d (see Integrative Modeling Platform) and compute affinity of structural models to both models. 

##Cluster_EM2D.sub
SGE submit script to compute em2d scores with proper formatting

##Analysis_em2d_zscores.sh
Read raw scores files (here two but easy to adapt) and compute an image composite Z-score for each structural models used. 

##Compute_Distances_PDB.py
Compute teh distance between two residues (Cα distance). 
To run: python Compute_Distances_PDB.py pdbfile chain1 residue1 chain2 residue2

##To do the full analysis:
Run em2d_single_score from the em2d module in IMP using the Cluster_EM2D.sub script.

Create a directory to do the analysis. 
Create two subdirectories, e.g. Scores and Zcores.

Run the analysis scripts: Analysis_em2d_zscores.sh (Make sure the Raw scores files are located in .. and matches the name inside the script. 
Select models you deemed to match one data sets more than the others (for example 3 standard deviation preference to one data set and 3 standard deviation unfavorable to the others as given by the z-scores). 

For each models that satisfy one of the data sets: compute a distance statistics (average and standard deviation rather than a single distance):
To do so using the followiwng command that uses Compute_Distances_PDB.py:

```bash
for file in `ls ?_*_*.pdb`; do python Compute_Distances_PDB.py $file Chain1 Residue1 Chain2 Residue2; done | awk '{print $4}' | awk 'BEGIN{FS=")"}{print $1}' | awk '{sum+=$1;sum2+=$1*$1;b++}END{print sum/b, sqrt(sum2/b-(sum/b)*(sum/b)), b}'
```
