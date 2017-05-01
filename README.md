### Compute G with GMATRIX software  

using a series of script, you could compute the genomic relationship matrix with GMATRIX software from Su and Madsen  

#### Requiremnt  
      - Linux system  
      - plink excutable file in thw working directory (download from plink website)  
      - calc_grm.sh (the script is in this github directory)  
      - par.dat (parameter file for GMATRIX software - a pre-prepared one avialble in this github folder)  
      - gmatrix (GMATRIX software)  
 

#### Running script  
          ./makegmat.sh args1 args2 args3  

##### args1  
          genofile  ==> The plink file format genotype file (both PED+MAP or binary [BED+BIM+FAM] are supported)  

##### args2   
          genocode  ==> The genotype code of the link file (either 11/12/22 |or| AA/AB/BB |or| ACGT format)  
				To specify format use "12" | "AB" | "ACGT" 

##### args3
          out       ==> outputname 


The makegmat.sh script performs some genotype and sample quality control using plink and these are the default parameters    
              geno = 0.10  
              mind = 0.10  
              hwe  = 1e-25  
              maf  = 0.01  
Open the script and change default if needed  




#### Output
     out_asreml.grm     ==> G matrix according to VanRaden 2008
     out_asreml.giv     ==> inverse of the G matrix
     out.output         ==> log file of GMATRIX software
     grm.orig_codedIDs  ==> Original ID and recoded ID



 
