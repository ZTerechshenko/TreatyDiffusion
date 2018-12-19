# TreatyDiffusion

This package allows to load the data and run the analysis from 
"The Structure of International Treaty Diffusion" <br />

In order to install, run: <br />

`library(devtools)` <br />
`install_github("ZTerechshenko/TreatyDiffusion")` <br />

The package has lots of dependencies (dplyr, network, ergm, btergm, tergm, NetworkInference) <br />
	
If you already have them and do not want them to be installed, please, run: <br />

`library(devtools)` <br />
`install_github("ZTerechshenko/TreatyDiffusion", dependencies = FALSE)` <br />

The package contains the following <br />
datasets:<br />


distance00.rda -  contains distance between capitals for 2000-2012 years <br />
distance75.rda -  contains distance between capitals for 1975-1989 years <br />
edgelist.rda - contains edgelist <br />
IVs00.rda - contains independent variables for 2000-2012 years <br />
IVs75.rda - contains independent variables for 1975-1989 years <br />
tradelist00.rda - data on trade flows between states (as defined by the Correlates of War
				 project) for the period 2000-2012 years <br />
tradelist75.rda - data on trade flows between states (as defined by the Correlates of War
				 project) for the period 1975-1989 years <br />



functions: <br />

netinf_dynamic.R - A function to create estimates for network inference for each year
				 (25 year window) <br />
tergm_1975.R - A function to run TERGM for 1975-1989 years <br />
tergm_2000.R - A Function to run TERGM for 2000-2012 years <br />