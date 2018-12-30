# Time Series Analysis
## Part 1. Objective
## Part 2. Data
## Part 3. Outline
### 3.1. Plot the time series data amd choose proper transfornations.
- The most commonly used transformations are ***variance-stabilizing transformations*** and ***differencing.*** 
- Because ***variance-stabilizing transformations*** require ***non-negative*** values and ***differencing*** may create some ***negative*** values, ***variance-stabilizing transformations*** should always be applied ***before*** taking ***differencing.***
- A series with ***nonconstant variance*** often needs a ***variance-stabilizing transformation*** and ```Box-Cox’s Transformation``` can be applied.
- ***Box-Cox’s Transformation***  

$$
t_{\lambda }\left ( y \right )= 
\left\{\begin{matrix}
 &( y^{^{\lambda }} \right-1 )/\lambda,  & if \lambda \neq 0\\
 & log\left ( y \right ),& if \lambda =0
\end{matrix}\right.
$$



### 3.2. 

### Reference
Professor Shao-Wei, Cheng
Institute of Statistics, National Tsing Hua University
http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php
- 08. Mean Structure and Transformation




## Part 4. Steps

Step 1. Plot the time series data and choose proper transformations.  
Step 2. Compute and examine the sample ACF and the sample of PACF of the original series.
