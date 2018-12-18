# TreatyDiffusion

This package allows to load the data and run the analysis from 
"The Structure of International Treaty Diffusion"

In order to install, run:
install_github("ZTerechshenko/TreatyDiffusion")

The package has lots of dependencies (dplyr, network, ergm, btergm, tergm, NetworkInference)
	
If you already have them and do not want them to be installed, please, run:
install_github("ZTerechshenko/TreatyDiffusion", dependencies = FALSE)

The package contains the following 
datasets:

distance00.rda -  contains distance between capitals for 2000-2012 years 
distance75.rda -  contains distance between capitals for 1975-1989 years
edgelist.rda - contains edgelist
IVs00.rda - contains independent variables for 2000-2012 years
IVs75.rda - contains independent variables for 1975-1989 years
tradelist00.rda - data on trade flows between states (as defined by the Correlates of War
				 project) for the period 2000-2012 years
tradelist75.rda - data on trade flows between states (as defined by the Correlates of War
				 project) for the period 1975-1989 years



functions:

netinf_dynamic.R - A function to create estimates for network inference for each year
				 (25 year window)
tergm_1975.R - A function to run TERGM for 1975-1989 years
tergm_2000.R - A Function to run TERGM for 2000-2012 years 