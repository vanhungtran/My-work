!DOPATH 21
!L  
ASREML index
 animal	!P
 identif !A 
 bande !A
 sex !A
 lignee !A
 gener !A
 loge !A	
 eleve !A
 pds_dc	!M9999
 pds_fc !M9999
 age !M9999
 BW !M9999
 BWpre !M9999
 age_dc	!M9999
 week !A
 FCR !M<=1 !M9999
 ADG !M9999
 AMBW !M9999
 BF !M9999
 FI !M9999
 RFI !M9999
 temps !A
 period !A 
 period1 !A
 period2 !A
 sel1 !A 
 k !A
/modgen/vhtran/singlstep/geneal.gen !ALPHA 
/modgen/vhtran/singlestep/Hinv_new2.giv
#Hinv.giv
#/travail/vhtran/data/phenoall1.dat !WORKSPACE 2048 !MVINCLUDE !OWN /modgen/vhtran/RFI/sadm/sadmultiuni_exe !MAXIT 30  #!CONTINUE 
#/travail/vhtran/data/phenoall1.dat !FILTER selp [!SELECT 1] !WORKSPACE 2048 !MVINCLUDE !OWN /modgen/vhtran/HUNG/VAN/PROG/myowngdg_exe !MAXIT 30  #!CONTINUE 
phenoall1.dat !FILTER k [!SELECT 1]  !WORKSPACE 2048 !MVINCLUDE !OWN /modgen/vhtran/HUNG/VAN/PROG/myowngdg_exe !MAXIT 30  #!CONTINUE 














# RR model


!PATH 2


ADG ~ mu bande.sex age_dc loge eleve temps*gener !r leg(temps,2).animal leg(temps,2).ide(animal) 
0 0 2
leg(temps,2).animal 2 
3 0 US 1 0.1 1 0.1 0.1 1 !GPUPUUP
animal
leg(temps,2).ide(animal) 2 
3 0 US 1 0.1 1 0.1 0.1 1 !GPUPUUP
ide(animal) 0 ID 


!PATH 21

ADG ~ mu bande.sex age_dc loge eleve temps*gener mv !r leg(temps,2).giv(animal,1) leg(temps,2).ide(animal) units.week
1 1 3
0 0 ID 0.001 !GF !S2==1
leg(temps,2).giv(animal,1) 2 
3 0 US 1 0.1 1 0.1 0.1 1 !GPUPUUP
giv(animal,1)
leg(temps,2).ide(animal) 2 
3 0 US 1 0.1 1 0.1 0.1 1 !GPUPUUP
ide(animal) 0 ID 
units.week 2
10 0 DIAGH 1 1 1 1 1 1 1 1 1 1 !G10P
units 0 ID






!PATH 111

ADG ~ mu bande.sex loge age_dc eleve week*gener mv !r temps.giv(animal,1) temps.ide(animal)
#RFI ~ mu mv !r temps.animal temps.ide(animal)
1 1 2
0 0 ID 0.01 !GF !S2==1
temps.giv(animal,1) 2
10 temps OWN4 1.5 -0.001 -0.025 0.491 !T4C
giv(animal,1)
temps.ide(animal) 2
10 temps OWN4 1 -0.001 4.13 -0.01 !T4C !F2
ide(animal) 0 ID

ADG ~ mu eleve age_dc bande.sex loge week*gener mv !r period1.giv(animal,1) period1.ide(animal) week.identif
1 1 3
0 0 ID 0.0001 !GF !S2==1
period1.giv(animal,1) 2
4 0 US 1 0.1 1 0.1 0.1 1 0.1 0.1 0.1 1 !GPUPUUPUUUP
giv(animal,1)
period1.ide(animal) 2
4 0 US 1 0.1 1 0.1 0.1 1 0.1 0.1 0.1 1 !GPUPUUPUUUP
ide(animal) 0 ID
week.identif 2
10 0 DIAGH 1 1 1 1 1 1 1 1 1 1 !G10P
identif 0 ID






