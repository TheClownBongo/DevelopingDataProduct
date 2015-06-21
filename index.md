---
title       : Data Product Regression
subtitle    : 
author      : The Clown Bongo
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

## The 
---

## Regression Model Derived

The file DevDataProdRegData should be in your working directory. The file has information about the log return of the S&P 500 and GE for the period 2004 to 2014.  
With the provided data, we will find whether the correlation coefficient indicates there seems to be a linear relationship between the log return of GE and S&P 500. We will derive a linear regression model of GE against the S&P 500, plot the data against the regression line, and a scatter plot of the residuals versus the predicted values.

```
## 
## Call:
## lm(formula = data_stock$lnadjcloseGE ~ data_stock$lnadjcloseSP500)
## 
## Coefficients:
##                (Intercept)  data_stock$lnadjcloseSP500  
##                 -0.0001934                   1.1370860
```

---

## Scatter Plot Data with Regression Line

![plot of chunk ScatterPlot](assets/fig/ScatterPlot.png) 

---

## Scatter Plot of the residuals against fitted values

![plot of chunk ScatterResidualvsFitted](assets/fig/ScatterResidualvsFitted.png) 

---

## Should we revisit the model?

Yes as from the Shapiro tests, we find the data is not normally distributed since the p-Values are 0 to machine precision.

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  data_stock$lnadjcloseGE
## W = 0.85127, p-value < 2.2e-16
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  data_stock$lnadjcloseSP500
## W = 0.86958, p-value < 2.2e-16
```
