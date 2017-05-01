#!/bin/bash

### preparing input files GS3 for ADG data ####

genofile=$1
genocode=$2
out=$3

geno=0.10
mind=0.10
hwe=1e-25
maf=0.01

if [ ! -f gmatrix ]; then
  echo '.. gmatrix software not found ..'
exit
fi

if [ ! -f par.dat ]; then
  echo '.. parameter file of gmatrix software not found ..'
exit 
fi

if [ ! -f calc_grm.sh ]; then
  echo '.. script to invoke gmatrix software not found ..'
exit
fi

if [ -z ${genocode} ]; then
  echo '.. Genotype code not specified ..'
  echo '.. formats allowed are 12/AB/ACGT ..'
exit
fi

if [ -z ${out} ]; then
  echo '.. output file name not specified ..'
exit
fi



echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
if [ -f ${genofile}.ped ] & [ -f ${genofile}.map ]; then
 echo ".. Genotype files are in PED+MAP format .."
 echo '.. initial quality control of genotype data ..'
 ./plink --allow-no-sex --silent --chr-set 30 --nonfounders --file ${genofile} --geno ${geno} --mind ${mind} --maf ${maf} --hwe ${hwe} --make-bed --out tmpfile

 echo '.. converting to 12-format ..'
if [ ${genocode} = "AB" ]; then
 echo "-- from AB format --"
 cat tmpfile.bim | awk '{print $2,"A","B",1,2}' > allele.txt
 ./plink --allow-no-sex --silent --chr-set 30 --nonfounders --bfile tmpfile --update-alleles allele.txt --recode --out ${out}
rm allele.txt
elif [ ${genocode} = "12" ]; then
 echo "-- from 12 format --"
 ./plink --allow-no-sex --silent --chr-set 30 --nonfounders --bfile tmpfile --recode --out ${out}

elif [ ${genocode} = "ACGT" ]; then
 echo "-- from ACGT format --"
 ./plink --allow-no-sex --silent --chr-set 30 --nonfounders --bfile tmpfile --recode 12 --out ${out}
fi
 echo ".. convertion done .."

elif [ -f ${genofile}.bed ] & [ -f ${genofile}.bim ] & [ -f ${genofile}.fam ]; then
  echo ".. Genotype files are in binary (bed+bim+fam) format .."
  echo '.. initial quality control of genotype data ..'
 ./plink --allow-no-sex --silent --chr-set 30 --nonfounders --bfile ${genofile} --geno ${geno} --mind ${mind} --maf ${maf} --hwe ${hwe} --make-bed --out tmpfile

echo '.. converting to 12-format ..'
if [ ${genocode} = "AB" ]; then
 echo "-- from AB format --"
 cat tmpfile.bim | awk '{print $2,"A","B",1,2}' > allele.txt
 ./plink --allow-no-sex --silent --chr-set 30 --nonfounders --bfile tmpfile --update-alleles allele.txt --recode --out ${out}
rm allele.txt
elif [ ${genocode} = "12" ]; then
 echo "-- from 12 format --"
 ./plink --allow-no-sex --silent --chr-set 30 --nonfounders --bfile tmpfile --recode --out ${out}

elif [ ${genocode} = "ACGT" ]; then
   echo "-- from ACGT format --"
 ./plink --allow-no-sex --silent --chr-set 30 --nonfounders --bfile tmpfile --recode 12 --out ${out}
fi
 echo ".. convertion done .."
fi
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
rm tmpfile*

echo ""
echo '---------------------------------------------------------------------------------------'
./calc_grm.sh ${out} ${out}
echo '---------------------------------------------------------------------------------------'

rm ${out}.ped ${out}.map ${out}.nosex
