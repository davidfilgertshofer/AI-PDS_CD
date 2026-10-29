clear all
version 19 					
set more off, permanently
numlabel, add force
*Pfad
global path "W:\Promotion\Vignettenstudie\stata"
global prog "$path\prog"
global log "$path\log"
global data "$path\data"
global graphs "$path\graphs"

**use Dataset_AIPDS_CD

*****************************************************************************
**********EFA*******************
**global Model
****Faktoranalyse mit allen Items**** 
pwcorr tool1_r - tool20_r social1_r -social20_r pm1_r - pm20_r threat1_r - threat20_r, list
factortest tool1_r - tool20_r social1_r -social20_r pm1_r - pm20_r threat1_r - threat20_r //Bartlett sig; KMO: 0.967
pca tool1_r - tool20_r social1_r -social20_r pm1_r - pm20_r threat1_r - threat20_r
screeplot //Hinweis auf 4
minap tool1_r - tool20_r social1_r -social20_r pm1_r - pm20_r threat1_r - threat20_r //9 Faktoren

paran tool1_r - tool20_r social1_r -social20_r pm1_r - pm20_r threat1_r - threat20_r, quietly graph iterations(1000) centile(95) seed(45678) //methode mit 95 percentil
//5 Faktoren, wobei No. 5 auf Borderline.

paran tool1_r - tool20_r social1_r -social20_r pm1_r - pm20_r threat1_r - threat20_r,  quietly graph iterations(1000) seed(45678) //6 Faktoren wobei No. 5/6 auf Borderline 

*********RULE:
*1) Delete Items without acceptable loading (<.5) on any factor -> estimate again 
*2) If 1) does not apply, delete Items with high uniqueness (>.5) and relevant cross-loadings (difference <.3) -> estimate again
*3) If 1) and 2) does not apply -> RESULT

**Rechne explizite 5-F-L aufgrund von PA mit maximal 5 Faktoren
factor tool1_r - tool20_r social1_r -social20_r pm1_r - pm20_r threat1_r - threat20_r, ml factors(5)
rotate, promax kaiser
//lösche tool1 tool3 tool12 tool14 tool15 tool16 tool18 tool19 tool20 
//lösche social3 social8 social11 social17 social18 social20
//lösche pm5 pm9 pm10 pm12 pm13 pm15 pm18 pm19 
//lösche threat2 threat3 threat8 threat10 threat12 threat13 

factor tool2_r tool4_r tool5_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social4_r social5_r social6_r social7_r social9_r social10_r social12_r social13_r social14_r social15_r social16_r social19_r pm1_r pm2_r pm3_r pm4_r pm6_r pm7_r pm8_r pm11_r pm14_r pm16_r pm17_r pm20_r threat1_r threat4_r threat5_r threat6_r threat7_r threat9_r threat11_r threat14_r threat15_r threat16_r threat17_r threat18_r threat19_r threat20_r, ml factors(5)
rotate, promax kaiser
//threat15 

factor tool2_r tool4_r tool5_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social4_r social5_r social6_r social7_r social9_r social10_r social12_r social13_r social14_r social15_r social16_r social19_r pm1_r pm2_r pm3_r pm4_r pm6_r pm7_r pm8_r pm11_r pm14_r pm16_r pm17_r pm20_r threat1_r threat4_r threat5_r threat6_r threat7_r threat9_r threat11_r threat14_r threat16_r threat17_r threat18_r threat19_r threat20_r, ml factors(5)
rotate, promax kaiser
//pm6 

factor tool2_r tool4_r tool5_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social4_r social5_r social6_r social7_r social9_r social10_r social12_r social13_r social14_r social15_r social16_r social19_r pm1_r pm2_r pm3_r pm4_r pm7_r pm8_r pm11_r pm14_r pm16_r pm17_r pm20_r threat1_r threat4_r threat5_r threat6_r threat7_r threat9_r threat11_r threat14_r threat16_r threat17_r threat18_r threat19_r threat20_r, ml factors(5)
rotate, promax kaiser
//tool4 tool5 social4 social7 social13 social14 social16 pm11 pm20 threat11 threat16 threat17 threat19

factor tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r pm1_r pm2_r pm3_r pm4_r pm7_r pm8_r pm14_r pm16_r pm17_r threat1_r threat4_r threat5_r threat6_r threat7_r threat9_r threat14_r threat18_r threat20_r, ml factors(5)
rotate, promax kaiser
//threat6 threat7 

factor tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r pm1_r pm2_r pm3_r pm4_r pm7_r pm8_r pm14_r pm16_r pm17_r threat1_r threat4_r threat5_r threat9_r threat14_r threat18_r threat20_r, ml factors(5)
rotate, promax kaiser

//LÖSUNG bei 5 Faktoren-EFA
*Func: tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r
*Social: social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r 
*PM: pm1_r pm2_r pm3_r pm4_r pm7_r pm8_r pm14_r pm16_r pm17_r 
*Threat 1: threat1_r threat4_r threat5_r threat9_r threat20_r
*Threat 2: threat14_r threat18_r // zwei Items unausreichend. 

**Lösung bei expliziter 4 Faktoren-Lösung:
*F1: Soziale Wahrnehmung: social1 social2 social5 social6 social9 social10 social12 social15 social19 
*F2: Funktionale Wahrnehmung: tool2 tool6 tool7 tool8 tool9 tool10 tool11 tool13 tool17
*F3: Performative Wahrnehmung pm1 pm3 pm7 pm8 pm14 pm16 
*F4: Bedrohliche Wahrnehmung: threat1 threat4 threat5 threat9 threat20





***4 Factors
factor tool1_r - tool20_r social1_r -social20_r pm1_r - pm20_r threat1_r - threat20_r, ml factors(4)
rotate, promax kaiser
//tool1 tool3 tool12 tool14 tool16 tool18 tool20 
//social3 social8 social11 social17 social18 social20 
//pm5 pm6 pm9 pm12 pm13 pm15 pm18 pm19 
//threat8 threat10 

factor tool2_r tool4_r tool5_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool15_r tool17_r tool19_r social1_r social2_r social4_r social5_r social6_r social7_r social9_r social10_r social12_r social13_r social14_r social15_r social16_r social19_r pm1_r pm2_r pm3_r pm4_r pm7_r pm8_r pm10_r pm11_r pm14_r pm16_r pm17_r pm20_r threat1_r threat2_r threat3_r threat4_r threat5_r threat6_r threat7_r threat9_r threat11_r threat12_r threat13_r threat14_r threat15_r threat16_r threat17_r threat18_r threat19_r threat20_r, ml factors(4)
rotate, promax kaiser
//tool15 tool19 
//pm2 pm10 pm20
//threat11 

factor tool2_r tool4_r tool5_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social4_r social5_r social6_r social7_r social9_r social10_r social12_r social13_r social14_r social15_r social16_r social19_r pm1_r pm3_r pm4_r pm7_r pm8_r pm11_r pm14_r pm16_r pm17_r threat1_r threat2_r threat3_r threat4_r threat5_r threat6_r threat7_r threat9_r threat12_r threat13_r threat14_r threat15_r threat16_r threat17_r threat18_r threat19_r threat20_r, ml factors(4)
rotate, promax kaiser
//pm4 

factor tool2_r tool4_r tool5_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social4_r social5_r social6_r social7_r social9_r social10_r social12_r social13_r social14_r social15_r social16_r social19_r pm1_r pm3_r pm7_r pm8_r pm11_r pm14_r pm16_r pm17_r threat1_r threat2_r threat3_r threat4_r threat5_r threat6_r threat7_r threat9_r threat12_r threat13_r threat14_r threat15_r threat16_r threat17_r threat18_r threat19_r threat20_r, ml factors(4)
rotate, promax kaiser
//pm17 

factor tool2_r tool4_r tool5_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social4_r social5_r social6_r social7_r social9_r social10_r social12_r social13_r social14_r social15_r social16_r social19_r pm1_r pm3_r pm7_r pm8_r pm11_r pm14_r pm16_r threat1_r threat2_r threat3_r threat4_r threat5_r threat6_r threat7_r threat9_r threat12_r threat13_r threat14_r threat15_r threat16_r threat17_r threat18_r threat19_r threat20_r, ml factors(4)
rotate, promax kaiser
//tool4 tool5 
//social4 social7 social13 social14 social16 
//pm11 
//threat2 threat3 threat7 threat12 threat13 threat14 threat15 threat16 threat17 threat18 threat19 

factor tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r pm1_r pm3_r pm7_r pm8_r pm14_r pm16_r threat1_r threat4_r threat5_r threat6_r threat9_r threat20_r, ml factors(4)
rotate, promax kaiser
//threat6 

factor tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r pm1_r pm3_r pm7_r pm8_r pm14_r pm16_r threat1_r threat4_r threat5_r  threat9_r threat20_r, ml factors(4)
rotate, promax kaiser 





**LÖSUNG:
**Func: tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r
**Soc: social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r
**PM: pm1_r pm3_r pm7_r pm8_r pm14_r pm16_r
**Thr: threat1_r threat4_r threat5_r  threat9_r threat20_r



*****LOCAL MODELLING
****FUNCTIONAL
pwcorr tool1_r - tool20_r, list
factortest tool1_r - tool20_r //Bartlett sig; KMO: 0.937
pca tool1_r - tool20_r
screeplot //max. 2
minap tool1_r - tool20_r // max. 2
paran tool1_r - tool20_r, iterations(1000) quietly seed(45678) graph centile(95) //3
paran tool1_r - tool20_r, iterations(1000)  seed(45678) graph //3 
//3 Faktoren, wobei no. 3 an Grenze (simulating error?)

**retain 3 factors

factor tool1_r - tool20_r, factors(3) ml 
rotate, promax kaiser
//tool1 tool3 tool7 tool13 tool14 tool15 tool17 tool18 

factor tool2_r tool4_r tool5_r tool6_r tool8_r tool9_r tool10_r tool11_r tool12_r tool16_r tool19_r tool20_r, factors(3) ml 
rotate, promax kaiser
//tool12 

factor tool2_r tool4_r tool5_r tool6_r tool8_r tool9_r tool10_r tool11_r tool16_r tool19_r tool20_r, factors(3) ml 
rotate, promax kaiser
//tool10 tool16 tool5 tool20 

factor tool2_r tool4_r tool6_r tool8_r tool9_r tool11_r tool19_r, factors(3) ml 
rotate, promax kaiser
//tool4 tool19 

factor tool2_r tool6_r tool8_r tool9_r tool11_r, factors(3) ml 
rotate, promax kaiser
// tool8 tool9 

factor tool2_r tool6_r tool11_r, factors(3) ml 
rotate, promax kaiser
//no solution. 
************************************************************************
**2 Factors
factor tool1_r - tool20_r, factors(2) ml 
rotate, promax kaiser
//tool1 tool3 tool5 tool14 tool15 tool16 tool18 

factor tool2_r tool4_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool12_r tool13_r tool17_r tool19_r tool20_r, factors(2) ml 
rotate, promax kaiser
//tool4 tool12 tool19 tool20 

factor tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r, factors(2) ml 
rotate, promax kaiser
//tool6 tool13 

factor tool2_r tool7_r tool8_r tool9_r tool10_r tool11_r tool17_r, factors(2) ml 
rotate, promax kaiser
//tool7 

factor tool2_r tool8_r tool9_r tool10_r tool11_r tool17_r, factors(2) ml 
rotate, promax kaiser
//tool2 

factor tool8_r tool9_r tool10_r tool11_r tool17_r, factors(2) ml 
rotate, promax kaiser
//Lösung: F1: tool8_r tool11_r tool17_r; F2: tool9_r tool10_r //allerdings: extrem hohes Loading von tool9 - Heywood.

/*F1: 
Ich nutze die KI vor allem als Hilfsmittel, um Aufgaben schneller zu erledigen.
Die KI ist ein technologisches Werkzeug, das mir bei der Arbeit hilft.
Ich kann die Erledigung von Aufgaben durch meine Nutzung der KI beschleunigen.

F2: NOT ACCEPTABLE (Low Items)
Ich sehe die KI als wertvolle und effiziente Technologie.
Die KI ist ein wertvolles und effektives Werkzeug für Aufgaben.

*/
*******************************************************************************
**1 Factor 
factor tool1_r - tool20_r, factors(1) ml 
//tool1 tool3 tool5 tool14 tool15 tool16 tool18 tool19 tool20 

factor tool2_r tool4_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool12_r tool13_r tool17_r, factors(1) ml
//tool2 tool4 tool12 tool13 

factor tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool17_r, factors(1) ml
//solution: tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool17_r //keine Items die in globaler Lösung rausfliegen + parsimonious 

**************************************************************************************
**SOCIAL
pwcorr social1_r - social20_r, list
factortest social1_r - social20_r //Bartlett sig; KMO: 0.962
pca social1_r - social20_r
screeplot //max. 1
minap social1_r - social20_r // max. 1
paran social1_r - social20_r, iterations(1000) quietly seed(45678) graph centile(95) //bis zu 2 aber hart an borderline
paran social1_r - social20_r, iterations(1000)  seed(45678) graph //2 wobei no. 2 auf der borderline 
*** 1 Factor retained 

factor social1_r - social20_r, factors(1) ml  
//social8 social11 social17 

factor social1_r social2_r social3_r social4_r social5_r social6_r social7_r social9_r social10_r social12_r social13_r social14_r social15_r social16_r social18_r social19_r social20_r, factors(1) ml
//social1 social3 social4 social7 social13 social14 social16 social18 social20 

factor social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r, factors(1) ml
//social1 social12 

factor social2_r social5_r social6_r social9_r social10_r social15_r social19_r, factors(1) ml
//Lösung: social2_r social5_r social6_r social9_r social10_r social15_r social19_r //keine Items die in globaler Lösung rausfliegen + parsimonious


*********************************************************************************
**Performative 
factortest pm1_r - pm20_r //Bartlett sig; KMO: 0.967
pca pm1_r - pm20_r
screeplot //1 Faktor
minap pm1_r - pm20_r //max 2
paran pm1_r - pm20_r, iterations(1000) quietly seed(45678) graph centile(95) //2 wobei Faktor 2 auf der Borderline
paran pm1_r - pm20_r, iterations(1000) quietly seed(45678) graph  //2, wobei no. 2 auf der Borderline.

**Anyway: 2 Faktoren müssen geprüft werden 
factor pm1_r - pm20_r, factors(2) ml
rotate, promax kaiser 
//pm1 pm3 pm7 pm8 pm12 pm13 pm18 pm19

factor pm2_r pm4_r pm5_r pm6_r pm9_r pm10_r pm11_r pm14_r pm15_r pm16_r pm17_r pm20_r, factors(2) ml
rotate, promax kaiser 
//pm17 pm20 

factor pm2_r pm4_r pm5_r pm6_r pm9_r pm10_r pm11_r pm14_r pm15_r pm16_r, factors(2) ml
rotate, promax kaiser 
//pm15 

factor pm2_r pm4_r pm5_r pm6_r pm9_r pm10_r pm11_r pm14_r pm16_r, factors(2) ml
rotate, promax kaiser 
//Lösung: F1: pm2 pm4 pm5 pm6 pm9 pm10; F2: pm11 pm14 pm16 

/**F1: Performance support
Mit der KI kann ich Ziele, Kriterien und Zwischenstände klarer verfolgen.
Die KI unterstützt mich, meine Ziele klarer zu definieren.
Ich sehe die KI als nützlich an, um den Aufwand oder die Anforderungen einer Aufgabebesser einzuschätzen.
Die KI ist für mich nützlich, um verschiedene Handlungsalternativen zur Zielerreichungabzuwägen.
Die KI hilft mir, meine Vorgehensweise anzupassen.
Die KI ist für mich eine Hilfe bei der Optimierung meiner Arbeitsschritte.

**F2: Performance Monitoring
Die KI vermittelt mir das Gefühl, dass meine Leistung objektiv überprüft wird.
Die KI vermittelt mir, welche Qualitätsstandards ich bei meiner Arbeit einhalten sollte.
Ich nehme das Feedback der KI als Maßstab dafür wahr, wie gut meine Arbeit ist.
*/
***********************************************************************************************
**Threat
factortest threat1_r - threat20_r // Bartlett sig, KMO: 0.945
pca threat1_r - threat20_r
screeplot //max. 2
minap threat1_r - threat20_r // max. 2
paran threat1_r - threat20_r, iterations(1000) quietly seed(45678) graph centile(95) //3 wobei Faktor 3 auf der Borderline
paran threat1_r - threat20_r, iterations(1000) quietly seed(45678) graph //3 wobei F3 auf der Borderline 

**Retain 2 Factors 
factor threat1_r - threat20_r, factors(2) ml
rotate, promax kaiser
//threat2 threat3 threat8 threat12 threat13 

factor threat1_r threat4_r threat5_r threat6_r threat7_r threat9_r threat10_r threat11_r threat14_r threat15_r threat16_r threat17_r threat18_r threat19_r threat20_r, factors(2) ml
rotate, promax kaiser
//threat6 threat10 threat11 threat15 threat16 threat17 threat19 

factor threat1_r threat4_r threat5_r threat7_r threat9_r threat14_r threat18_r threat20_r, factors(2) ml
rotate, promax kaiser
//threat5 threat7 

factor threat1_r threat4_r threat9_r threat14_r threat18_r threat20_r, factors(2) ml
rotate, promax kaiser
// threat9 threat14 

factor threat1_r threat4_r threat18_r threat20_r, factors(2) ml
rotate, promax kaiser
//no solution 

*****************************************************************
*3 Factors 
factor threat1_r - threat20_r, factors(3) ml
rotate, promax kaiser
//threat2 threat3 threat5 threat6 threat8 threat9 threat12 threat13 

factor threat1_r threat4_r threat7_r threat10_r threat11_r threat14_r threat15_r threat16_r threat17_r threat18_r threat19_r threat20_r, factors(3) ml
rotate, promax kaiser
//threat19 threat20 threat10 threat11 threat15 

factor threat1_r threat4_r threat7_r threat14_r threat16_r threat17_r threat18_r, factors(3) ml
rotate, promax kaiser
//threat1 Heywood 

factor threat4_r threat7_r threat14_r threat16_r threat17_r threat18_r, factors(3) ml
rotate, promax kaiser
//threat17 threat7  

factor threat4_r threat14_r threat16_r threat18_r, factors(3) ml
rotate, promax kaiser
//bricht zusammen - keine Lösung.

**************************************************************
*1 Factor 
factor threat1_r - threat20_r, factors(1) ml
//threat10 threat11 

factor threat1_r threat2_r threat3_r threat4_r threat5_r threat6_r threat7_r threat8_r threat9_r threat12_r threat13_r threat14_r threat15_r threat16_r threat17_r threat18_r threat19_r threat20_r, factors(1) ml
//threat2 threat3 threat7 threat8 threat12 threat13 threat14 threat15 threat16 threat17 threat18 threat19 

factor threat1_r threat4_r threat5_r threat6_r threat9_r threat20_r, factors(1) ml
//threat6 

factor threat1_r threat4_r threat5_r threat9_r threat20_r, factors(1) ml
//threat5 

factor threat1_r threat4_r threat9_r threat20_r, factors(1) ml
//threat9 

factor threat1_r threat4_r threat20_r, factors(1) ml
//Lösung: threat1 threat4 threat20:
/*Items: 
Ich empfinde die KI als Risiko für meine berufliche Zukunft.
Die Nutzung der KI macht mir Sorgen, dass ich weniger gebraucht werde.
Ich denke, dass meine Position mit der Einführung von KI weniger wichtig wird.

*/

*******************AUSWERTUNG**************************
***Bilde Indizes auf Basis der Faktorenlösungen

***4-Faktoren-Modell
**LÖSUNG:
**Func: tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r
**Soc: social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r
**PM: pm1_r pm3_r pm7_r pm8_r pm14_r pm16_r
**Thr: threat1_r threat4_r threat5_r  threat9_r threat20_r

alpha tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r
alpha social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r
alpha pm1_r pm3_r pm7_r pm8_r pm14_r pm16_r
alpha threat1_r threat4_r threat5_r  threat9_r threat20_r

omegacoef tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r
omegacoef social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r
omegacoef pm1_r pm3_r pm7_r pm8_r pm14_r pm16_r
omegacoef threat1_r threat4_r threat5_r  threat9_r threat20_r

egen functional_ix = rowmean(tool2_r tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool13_r tool17_r)
egen social_ix = rowmean(social1_r social2_r social5_r social6_r social9_r social10_r social12_r social15_r social19_r)
egen performative_ix = rowmean(pm1_r pm3_r pm7_r pm8_r pm14_r pm16_r)
egen threat_ix = rowmean(threat1_r threat4_r threat5_r  threat9_r threat20_r)
 

**Hierarchische Lösung: 
egen func_hi = rowmean(tool6_r tool7_r tool8_r tool9_r tool10_r tool11_r tool17_r)
egen soc_hi = rowmean(social2_r social5_r social6_r social9_r social10_r social15_r social19_r)
egen thr_hi = rowmean(threat1_r threat4_r threat20_r) 
egen pm_hi_1 = rowmean(pm2 pm4 pm5 pm6 pm9 pm10) 
egen pm_hi_2= rowmean(pm11 pm14 pm16)
egen pm_hi = rowmean(pm_hi_1 pm_hi_2) 

egen z_func_hi = std(func_hi)
egen z_soc_hi = std(soc_hi)
egen z_thr_hi = std(thr_hi)
egen z_pm_hi = std(pm_hi) 




*************************************************
************LATENTE PROFILANALYSE****************
**in R durchgeführt.

** 9 Profile




*******************************************************************************
***Datadescriber

count // N=1,028

tab female age_cat, m
pwcorr acceptance_index fairness_index usefulness_index trust functional_ix social_ix performative_ix threat_ix age female mig workuse privateuse competence, sig

***
tab vignette age_cat
tab vignette female

****Reliabilität DV
alpha acceptance1 acceptance2 acceptance3
omegacoef acceptance1 acceptance2 acceptance3

alpha fairness1 fairness2 fairness3
omegacoef fairness1 fairness2 fairness3

alpha usefulness1 usefulness2 usefulness3
omegacoef usefulness1 usefulness2 usefulness3

alpha compmeti benmeti intmeti 
omegacoef compmeti benmeti intmeti

**Lagemaße DVs
sum acceptance_index fairness_index usefulness_index trust, d
***************
**Verteilung Indizes 
sum functional_ix, d 
sum social_ix, d 
sum performative_ix, d 
sum threat_ix, d 

*********************************
**MANCOVA

pwcorr acceptance_index fairness_index usefulness_index trust, sig 
//signifikant korreliert (sehr gut)

robvar acceptance_index, by(vignette)
robvar fairness_index, by(vignette)
robvar usefulness_index, by(vignette)
robvar trust, by(vignette)

//insignifikant = sehr gut. Ausnahme usefullness.

tabstat usefulness_index, by(vignette) s(sd var) //Gruppen unterscheiden sich kaum. nicht beachtenswert.



manova acceptance_index fairness_index usefulness_index trust = ///
       vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix 

*eta: (F x df1) / (Fxdf1) +df2
**vignette:
display (2.07 * 12) / ((2.07 * 12) + 2691)

**functional:
display (13.74 * 4) / ((13.74 * 4) + 1017)
**social
display (14.07 * 4) / ((14.07 * 4) + 1017)
**performative 
display (1.38 * 4) / ((1.38 * 4) + 1017)
*threatening
display (5.52 * 4) / ((5.52 * 4) + 1017)


**Adjustierte Mean unterschiede
preserve
rename acceptance_index av1
rename fairness_index av2
rename usefulness_index av3
rename trust av4 

reshape long av, i(case) j(av_id)

label define av_labels 1 "Acceptance" 2 "Fairness" 3 "Usefulness" 4 "Trust"
label values av_id av_labels

anova av i.vignette#i.av_id c.functional_ix c.social_ix c.performative_ix c.threat_ix

margins vignette#av_id
marginsplot, xdimension(vignette) noci recast(line) ylabel(1(2)10) title("Adjusted Means Vignettes") xtitle("Vignette") ytitle("Linear prediction")  legend(title("")) 

	
restore 
	





**pairwise comparison:

**Acceptance
anova acceptance_index vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix 
pwcompare vignette, mcompare(bonferroni) effects

**Fairness
anova fairness_index vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix 
pwcompare vignette, mcompare(bonferroni) effects

anova usefulness_index vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix 
pwcompare vignette, mcompare(bonferroni) effects

**TRUST
anova trust vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix 
pwcompare vignette, mcompare(bonferroni) effects




******************************************************************************
***Regression + Moderationseffekte 
**1st Stage: reiner Vignetteneffekt
**2nd Stage: + AI-PDS
**3rd Stage: + Sociodemographics
******************************************************************************
*********Fairness 
reg fairness_index i.vignette, vce(robust) //1st
est sto regf1
reg fairness_index i.vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix, vce(robust) //2nd
est sto regf2
reg fairness_index i.vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix c.age female i.edu mig i.worksit c.workuse c.privateuse c.competence, vce(robust) //3rd
est sto regf3 

esttab regf1 regf2 regf3 using "results_fairness1.rtf", replace ///
 b(3) se(3) ///
    star(** 0.05 *** 0.01) ///
    stats(N r2 r2_a, fmt(0 3) labels("N" "R²" "adj. R²")) ///
    label ///
    title("Regression Results Evaluated Fairness") ///
    mtitles("Vignettes" "+AI-PDS" "+Controls") ///
    compress

*/
*********USEFULNESS
reg usefulness_index i.vignette, vce(robust) //1st
est sto regu1
reg usefulness_index i.vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix, vce(robust) //2nd
est sto regu2
reg usefulness_index i.vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix c.age female i.edu mig i.worksit c.workuse c.privateuse c.competence, vce(robust) //3rd
est sto regu3


esttab regu1 regu2 regu3 using "results_usefulness1.rtf", replace ///
 b(3) se(3) ///
    star(** 0.05 *** 0.01) ///
    stats(N r2 r2_a, fmt(0 3) labels("N" "R²" "adj. R²")) ///
    label ///
    title("Regression Results Evaluated Usefulness") ///
    mtitles("Vignettes" "+AI-PDS" "+Controls") ///
    compress


*********Acceptance
reg acceptance_index i.vignette, vce(robust) //1st
est sto rega1
reg acceptance_index i.vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix, vce(robust) //2nd
est sto rega2
reg acceptance_index i.vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix c.age female i.edu mig i.worksit c.workuse c.privateuse c.competence, vce(robust) //3rd
est sto rega3

esttab rega1 rega2 rega3 using "results_acceptance1.rtf", replace ///
 b(3) se(3) ///
    star(** 0.05 *** 0.01) ///
    stats(N r2 r2_a, fmt(0 3) labels("N" "R²" "adj. R²")) ///
    label ///
    title("Regression Results Evaluated Acceptance") ///
    mtitles("Experiment only" "+AI-PDS" "+Controls") ///
    compress


*********Trustworthiness
reg trust i.vignette, vce(robust) //1st
est sto regt1
reg trust i.vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix, vce(robust) //2nd
est sto regt2
reg trust i.vignette c.functional_ix c.social_ix c.performative_ix c.threat_ix c.age female i.edu mig i.worksit c.workuse c.privateuse c.competence, vce(robust) //3rd
est sto regt3

esttab regt1 regt2 regt3 using "results_trust1.rtf", replace ///
 b(3) se(3) ///
    star(** 0.05 *** 0.01) ///
    stats(N r2 r2_a, fmt(0 3) labels("N" "R²" "adj. R²")) ///
    label ///
    title("Regression Results Evaluated Trustworthiness") ///
    mtitles("Experiment only" "+AI-PDS" "+Controls") ///
    compress



























