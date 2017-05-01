###### compute the G matrix with PLINK
source('Gwithplink_andplotFSHSrel.R')
genofile='MH2015G'   ### genotype file 
genoformat='binary' ### either binary or pedmap
outname='MHselC2015'
Gwithplink(genofile,genoformat,outname)


########### plot HS relationships 
grm=paste(outname,'.grm',sep='')
genolinkped=paste(outname,'.id',sep='')
pedigree='pedigree.txt'
outname='G2015_HS'
AGDMH_HS <- exFHsibrel_GRM(grm,pedigree,genolinkped,typefam = 'HS',exclfamsize=1,outname)


########### plot FS relationships 
grm=paste(outname,'.grm',sep='')
genolinkped=paste(outname,'.id',sep='')
pedigree='pedigree.txt'
outname='G2015_FS'
AGDMH_HS <- exFHsibrel_GRM(grm,pedigree,genolinkped,typefam='FS',exclfamsize=1,outname)

