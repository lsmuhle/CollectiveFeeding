# Modelling social and solitary foraging of *C. elegans*

## Project description
This repository provides both code and data for the minimal and strain-specific model used in *Benefits of collective feeding in patchy food environments tested with C. elegans*.
The minimal model is developed to compare social with solitary foraging in environments with different degrees of food clustering, as both strategies only differ in the ability of worms to form groups on food in environments with different degrees of food clustering.  
The strain-specific model compares the foraging strategies of social *npr-1* and solitary N2 worms as it includes more behavioural parameters such as speed on and off food or different food-leaving probabilities.  

## Reproduction of minimal model
To reproduce the minimal model, see CollectiveFeeding/MinimalModel/functions. The script main.m provides the basis for running the code. In the first section, the desired parameters can be entered. To control the degree of food clustering enter the desired value for gamma (food is distributed uniformly random for gamma = 0 and the degree of clustering increases as gamma increases). Furthermore, the number of time steps, number of distributed food units, side length of the lattice, number of simulated worms and repetitions of the simulations can be entered here.

![Parameter initialisation for minimal model in script main.m](https://github.com/lsmuhle/CollectiveFeeding/blob/master/images/parameterInitialisation.jpg)

Afterwards, run the simulation and save the desired outputs.

If you want to create a movie, set the number of simulations to one and uncomment the last part of main.m with the heading **%% Create Movie** (if you do not want to create a movie, leave it commented).

## Reproduction of minimal model with restricted food perception
The procedure is the same as for the minimal model, only with the functions from the folder CollectiveFeeding/MinimalModelRestrictedPerception/functions.

## Reproduction of strain-specific model
Similar to the minimal model, see CollectiveFeeding/StrainSpecificModel/functions and enter the desired parameters.
Depending on the number of food patches you need, call the function onePatch, twoPatches or fourPatches for the variable initialFUs. Initial lattice sites for worms are set in the function circularWorms.m. If you wish to use other starting positions, make sure that all worms are still within lattice borders because periodic boundary conditions are not explicitly enforced when setting initial conditions.

Apart from this, the same parameters as in the minimal model can be set here.

![Parameter initialisation for strain-specific model in main.m](https://github.com/lsmuhle/CollectiveFeeding/blob/master/images/generalParameterInitialisationStrainSpecific.jpg)

The food-leaving probabilites of *npr-1* and N2 worms (leavingRateNpr1 and leavingRateN2) and the speeds on and off food (speedOnFoodNpr1, speedOffFoodNpr1, speedOnFoodN2 and speedOffFoodN2) can be set in the first part of the scripts.

Afterwards run the simulation and save the desired outputs.

## Analysis of simulations
In both the folder MinimalModel and the folder StrainSpecificModel a subfolder 'analysis' can be found. This subfolders contain a script analysis[...].m, which is required for the analysis of data obtained from the simulations. This script computes the mean time steps social and solitary or *npr-1* and N2 worms, respectively, need to deplete 90% of the food and creates a plot of the mean time steps of social and solitary worms need dependent on the degree of food clustering (determined by gamma), respectively a plot of the mean time steps of *npr-1* and N2 steps over one, two and four food patches. Furthermore, the script creates histograms of ingested food units per worm and calculates individual feeding efficiencies and creates histograms dependent on food distribution and worm type for this.

The subfolders 'analysis' also includes the data we obtained from our simulations and used for the analysis and movies of the simulation of social and solitary foraging in different food environments (varying values for gamma) and of foraging of *npr-1* and N2 worms in environments with different number of food patches.
