#!/usr/bin/bash

for img in `grep 20.7233 ../Scores_Apo.txt | awk '{print $4}' | sort | uniq -c | awk '{print $2}'`; 
do 
    awk -v img=$img '{if($4==img) print $0}' ../Scores_Apo.txt >> NScores_Apo.txt; 
done;

for img in `grep 20.7233 ../Scores_Van.txt | awk '{print $4}' | sort | uniq -c | awk '{print $2}'`; 
do 
    awk -v img=$img '{if($4==img) print $0}' ../Scores_Van.txt >> NScores_Van.txt; 
done;

awk 'FNR==NR{a[$0]++;next}(!($0 in a))' NScores_Apo.txt ../Scores_Apo.txt > Scores_Apo.txt;
awk 'FNR==NR{a[$0]++;next}(!($0 in a))' NScores_Van.txt ../Scores_Van.txt > Scores_Van.txt;

for i in `seq 0 39`; do awk -v img="$i" '{if($4==img) print $0}' Scores_Apo.txt >> Scores_Apo_$i.txt; done;
for i in `seq 0 39`; do awk -v img="$i" '{if($4==img) print $0}' Scores_Van.txt >> Scores_Van_$i.txt; done;

for i in `seq 0 39`; 
do 
    echo $i `awk '{avg+=$5; avs+=$5*$5; b++}END{print avg/b, sqrt(avs/b-(avg/b)*(avg/b)), b}' Scores_Apo_$i.txt` >> SStatistics_Apo.txt; done

for i in `seq 0 39`; 
do 
    echo $i `awk '{avg+=$5; avs+=$5*$5; b++}END{print avg/b, sqrt(avs/b-(avg/b)*(avg/b)), b}' Scores_Van_$i.txt` >> SStatistics_Van.txt; done

awk 'NF>=3' SStatistics_Apo.txt > Statistics_Apo.txt
awk 'NF>=3' SStatistics_Van.txt > Statistics_Van.txt

mv Scores* Scores

for i in `seq 0 39`; 
do 
    avg=`awk -v img=$i '{if($1==img) print $2}' Statistics_Apo.txt`; stv=`awk -v img=$i '{if($1==img) print $3}' Statistics_Apo.txt`; awk -v avg=$avg -v stv=$stv '{print $1, $2, $3, $4, $5, ($5-avg)/stv, avg,stv}' ./Scores/Scores_Apo_$i.txt >> Zcores_Apo_$i.txt; 
done;

for i in `seq 0 39`; 
do 
    avg=`awk -v img=$i '{if($1==img) print $2}' Statistics_Van.txt`; stv=`awk -v img=$i '{if($1==img) print $3}' Statistics_Van.txt`; awk -v avg=$avg -v stv=$stv '{print $1, $2, $3, $4, $5, ($5-avg)/stv, avg,stv}' ./Scores/Scores_Van_$i.txt >> Zcores_Van_$i.txt; 
done;

mv Zcores* Zcores

cat Zcores/Zcores_Apo_* > Apo_Z.txt
cat Zcores/Zcores_Van_* > Van_Z.txt
sort -n -k2 -k3 -k4  Van_Z.txt | awk '{h[$1" "$2" "$3]+=$6}END{for (i in h){print i, h[i]}}' | sort -n -k1 -k2 -k3 > Van_Preferences.txt
sort -n -k2 -k3 -k4  Apo_Z.txt | awk '{h[$1" "$2" "$3]+=$6}END{for (i in h){print i, h[i]}}' | sort -n -k1 -k2 -k3 > Apo_Preferences.txt