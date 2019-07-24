# Survival data analysis

- Import packages
``` r
library("survminer")
library("survival")

```
``` r
# model
fit <- survfit(Surv(time, status) ~ sex, data = lung)

# plot
ggsurvplot(fit, size = 2, # change line size
           palette = c("#00008F", "#800000"), # color palette
           conf.int = TRUE, # confidence interval
           pval = TRUE, # p-value
           risk.table = TRUE, # risk table
           risk.table.col = "strata", # table color by groups
           ggtheme = theme_bw() #  ggplot2 theme
)

```
![alt text](https://github.com/vanhungtran/survival/blob/master/Rplot01.png)
