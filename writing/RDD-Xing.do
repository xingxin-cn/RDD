clear
use "D:\A superstar\course\causal inference\replication\hansen_dwi.dta", clear

# 3. create a dummy
gen d = 0
replace d = 1 if bac1 >= 0.08

* 4. recreate Figure 1
histogram bac1, frequency width(0.0001) xline(0.08, lc(red)) xtitle("BAC")

* 5. Table 2 Panel A but only white male, age and accident (acc) as dependent variables
reg d white male aged acc, robust

**reg recidivism bac1 white male aged , robust
**rd recidivism white male aged, c(0.08)
**rdrobust recidivism white male aged, c(0.08)

* 6. Figure 2 panel A-D
cmogram acc bac1, cut(0.08) scatter line(0.08) lfit
cmogram acc bac1, cut(0.08) scatter line(0.08) qfit

cmogram male bac1, cut(0.08) scatter line(0.08) lfit
cmogram male bac1, cut(0.08) scatter line(0.08) qfit

cmogram aged bac1, cut(0.08) scatter line(0.08) lfit
cmogram aged bac1, cut(0.08) scatter line(0.08) qfit

cmogram white bac1, cut(0.08) scatter line(0.08) lfit
cmogram white bac1, cut(0.08) scatter line(0.08) qfit

* 7. Table 3 
** panel A
gen bac1_c = bac1 - 0.08
gen bac1_c2 = bac1_c^2

* column 1
xi: reg recidivism bac1 acc male aged white if bac1 >= 0.03 & bac1 <= 0.13, robust
estimates store linearly, title(model 1)

* column 2
xi: reg recidivism i.d * bac1_c acc male aged white if bac1 >= 0.03 & bac1 <= 0.13, robust
estimates store lcoff, title(model 2)

* column 3
xi: reg recidivism d##(c.bac1_c c.bac1_c2) acc male aged white if bac1 >= 0.03 & bac1 <= 0.13, robust
estimates store lcoffquad, title(model 3)

estout linearly lcoff lcoffquad

** panel B

* column 1
xi: reg recidivism bac1 acc male aged white if bac1 >= 0.055 & bac1 <= 0.105, robust
estimates store linearly, title(model 1)

* column 2
xi: reg recidivism i.d * bac1_c acc male aged white if bac1 >= 0.055 & bac1 <= 0.105, robust
estimates store lcoff, title(model 2)

* column 3
xi: reg recidivism d##(c.bac1_c c.bac1_c2) acc male aged white if bac1 >= 0.055 & bac1 <= 0.105, robust
estimates store lcoffquad, title(model 3)

estout linearly lcoff lcoffquad


* 8. Figure 3
cmogram recidivism bac1 if bac1 < 0.15, cut(0.08) scatter line(0.08) lfit
cmogram recidivism bac1 if bac1 < 0.15, cut(0.08) scatter line(0.08) qfit

 