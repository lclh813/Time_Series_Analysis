# Time Series Analysis
## Part 1. Objective
## Part 2. Data
## Part 3. Outline
### 3.1. Plot the time series data amd choose proper transfornations.
- The most commonly used transformations are ***variance-stabilizing transformations*** and ***differencing.*** 
- Because ***variance-stabilizing transformations*** require ***non-negative*** values and ***differencing*** may create some ***negative*** values, ***variance-stabilizing transformations*** should always be applied ***before*** taking ***differencing.***
- A series with ***nonconstant variance*** often needs a ***variance-stabilizing transformation*** and ```Box-Cox’s Transformation``` can be applied.
- ***Box-Cox’s Transformation*** 

<a href="https://www.codecogs.com/eqnedit.php?latex=\begin{center}&space;t_{\lambda&space;}\left&space;(&space;y&space;\right&space;)=&space;\left\{\begin{matrix}&space;&(&space;y^{^{\lambda&space;}}&space;\right-1&space;)/\lambda,&space;&&space;if&space;\lambda&space;\neq&space;0\\&space;&&space;log\left&space;(&space;y&space;\right&space;),&&space;if&space;\lambda&space;=0&space;\end{matrix}\right.&space;\end{center}" target="_blank"><img src="https://latex.codecogs.com/png.latex?\begin{center}&space;t_{\lambda&space;}\left&space;(&space;y&space;\right&space;)=&space;\left\{\begin{matrix}&space;&(&space;y^{^{\lambda&space;}}&space;\right-1&space;)/\lambda,&space;&&space;if&space;\lambda&space;\neq&space;0\\&space;&&space;log\left&space;(&space;y&space;\right&space;),&&space;if&space;\lambda&space;=0&space;\end{matrix}\right.&space;\end{center}" title="\begin{center} t_{\lambda }\left ( y \right )= \left\{\begin{matrix} &( y^{^{\lambda }} \right-1 )/\lambda, & if \lambda \neq 0\\ & log\left ( y \right ),& if \lambda =0 \end{matrix}\right. \end{center}" /></a>





### 3.2. 

### Reference
Professor Shao-Wei, Cheng
Institute of Statistics, National Tsing Hua University
http://www.stat.nthu.edu.tw/~swcheng/Teaching/stat5410/index.php
- 08. Mean Structure and Transformation




## Part 4. Steps

Step 1. Plot the time series data and choose proper transformations.  
Step 2. Compute and examine the sample ACF and the sample of PACF of the original series.
