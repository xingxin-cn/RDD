## Github repo and summary
### 1.Create a new github repository
[Xing’s GitHub resositories](https://github.com/xingxin-cn/RDD/)

### 2.Briefly summarize the paper.
The research focus on the effect of harsher punishments and sanctions on driving under the influence
punishments are determined by strict rules on blood content and prevent offenses. The data comes from
administrative records on 512964 DUI BAC tests in the state of Washington from 1995 to 2011 and data from 1999-2007 to analyze the causal effect of having a BAC above either the 0.08 or 0.15 threshold on recidivism within four years of the original BAC test. In terms of “identification strategy”, the author assumes that it is locally random for a driver to have a BAC either just below or just above the BAC thresholds. Finally, the author concludes that regression discontinuity derived estimates suggest that having a BAC above the DUI threshold reduces recidivism by up to 2 percentage points (17 percent); having a BAC over the aggravated DUI threshold reduces recidivism by an additional percentage point (9 percent). Besides,the additional sanctions experienced by drunk drivers at BAC thresholds are effective in reducing repeat drunk driving.
## Reproducing somewhat Hansen’s results
### 3.Create a dummy

```
gen d = 0
replace d = 1 if bac1 >= 0.08
```

### 4. Recreate Figure 1
```
histogram bac1, frequency width(0.0001) xline(0.08, lc(red)) xtitle("BAC")
```
![Figure 1](https://static01.imgkr.com/temp/2cb0c43cc38c4fe0bb3870a9532cae0c.jpg)

I didn't find evidence for sorting on the running variable since the distribution of BAC shows little evidence of endogenous sorting
to one side of either of the thresholds studied.

### 5. Table 2 Panel A
```
reg d white male aged acc, robust
```
![](https://imgkr2.cn-bj.ufileos.com/8fe13fdb-94e7-4aff-b15a-c5a21977273f.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=nIxBU8uQa2jE%252FUknh7PDlHcFrOA%253D&Expires=1615083873)

Panel A focuses on the estimated effect of BAC above the DUI threshold. They are balanced and we fail to reject the null that the predetermined
characteristics are unrelated to the BAC cutoffs for DUI.

### 6. Figure 2 panel A-D
```
cmogram acc bac1, cut(0.08) scatter line(0.08) lfit
cmogram acc bac1, cut(0.08) scatter line(0.08) qfit

cmogram male bac1, cut(0.08) scatter line(0.08) lfit
cmogram male bac1, cut(0.08) scatter line(0.08) qfit

cmogram aged bac1, cut(0.08) scatter line(0.08) lfit
cmogram aged bac1, cut(0.08) scatter line(0.08) qfit

cmogram white bac1, cut(0.08) scatter line(0.08) lfit
cmogram white bac1, cut(0.08) scatter line(0.08) qfit
```
![](https://static01.imgkr.com/temp/5908c31926cc4bf5a7eb3f6a7a36dba5.jpg)
![](https://imgkr2.cn-bj.ufileos.com/02ae5446-b900-4b38-8e5b-2d1a53dc8464.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=FKkfqDreH7dGqxLOLg3SzxucOIk%253D&Expires=1615084944)
![](https://imgkr2.cn-bj.ufileos.com/494c8d37-953d-4a84-8006-e9fca6f291f1.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=b6Dp3KiV8UQ08hGqZM%252FvTNgTgqk%253D&Expires=1615085017)
![](https://static01.imgkr.com/temp/45f457267ab64b6dbe107ee4e1209083.jpg)

Demographic factors such as age, race (defined by white versus
non-white), and gender are stable across the DUI punishment thresholds. The stability of predetermined characteristics gives additional credibility that the regression discontinuity design can
deliver unbiased estimates in this scenario as it suggests neither the impaired driver
nor the police officer is able to manipulate testing on either side of the 0.08
thresholds.

### 7. Table 3 
```
gen bac1_c = bac1 - 0.08
gen bac1_c2 = bac1_c^2

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
```
![](https://static01.imgkr.com/temp/be1044c5e41e4e3987dfa521d92b6045.jpg)


![](https://imgkr2.cn-bj.ufileos.com/0e682431-c260-4fcc-a5c3-f2ae738344da.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=O%252B38%252FHxCKqgxMZezxLT0R9iTL%252BU%253D&Expires=1615091438)


![](https://static01.imgkr.com/temp/a75e2e6fde3e4175b753a4addd5de76c.jpg)


![](https://static01.imgkr.com/temp/113c9bd2e42d457b81bdbf24ec9291e6.jpg)

### 8. Recreate the top panel of Figure 3 
```
cmogram recidivism bac1 if bac1 < 0.15, cut(0.08) scatter line(0.08) lfit
cmogram recidivism bac1 if bac1 < 0.15, cut(0.08) scatter line(0.08) qfit
```
![](https://imgkr2.cn-bj.ufileos.com/6d81b94c-6aea-495c-9ea1-f1d44ac36b46.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=pGemUH67FaoV%252BTBl0d8b0qShueo%253D&Expires=1615091598)
![](https://imgkr2.cn-bj.ufileos.com/e8f2a136-9692-4e76-a719-e5436335bb13.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=NViT018iAZiEXgi%252BsvNERO9El8A%253D&Expires=1615091598)

### 9. Discuss what you learned from this exercise

Back to the research itself, I believed the author's conclusion makes sense but I couldn't get the same result due to the data difference or just my code. For example, I found little evidence correspond with the conclusion for question 7.

Thanks to the assignment, I was trying many new stuff for the first time, such as inserting a picture with Markdown, replicating the result from famous economists. Practice makes perfect. I have to say it really depresses me when I was unable to run the code successfully. However, the happiness after doing this work makes me more confident and I better understand how RDD work thorough actual economic problem. I realized that why our professor want us to connect knowledge of theory with estimation, to be a more empirical one.
