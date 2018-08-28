# Modelling social and solitary foraging of *C. elegans*

## Project description
This repository provides both code and data for the minimal and strain-specific model used in *Benefits of collective feeding in patchy food environments tested with C. elegans*. 
The minimal model is developed to compare social with solitary foraging in environments with different degrees of food clustering, as both strategies only differ in the ability of worms to form groups on food in environments with different degrees of food clustering.  
The strain-specific model compares the foraging strategies of social *npr-1* and solitary N2 worms as it includes more behavioural parameters such as speed on and off food or different food-leaving probabilities.  

## Reproduction of minimal model
To reproduce the minimal model, first download the functions from CollectiveFeeding/MinimalModel/functions. The script main.m provides the basis for running the code. In the first section, the desired parameters can be entered. To control the degree of food clustering enter the desired value for gamma (food is distributed uniformly random for gamma = 0 and the degree of clustering increases as gamma increases). Furthermore, the wanted number of time steps, number of distributed food units, side length of the lattice, number of simulated worms and repetitions of the simualations can be entered here. 

![Parameter initialisation for minimal model in script main.m](https://github.com/lsmuhle/CollectiveFeeding/blob/master/images/parameterInitialisation.jpg)

Afterwards, run the simulation and save the desired outputs.

If you want to create a movie, set the number of simulations to one and uncomment the last part of main.m with the heading **%% Create Movie** (if you do not want to create a movie, leave it commented). 

## Reproduction of strain-specific model 
Similar to the minimal model, first download the functions from CollectiveFeeding/StrainSpecificModel/functions and enter the desired parameters.
Dependent on the number of food patches you need, call the function onePatch, twoPatches or fourPatches for the variable initialFUs. As we use initial lattice sites for worms that do not contain food, the values for the variables rowMiddlePoint and columnMiddlePoint of the function circularWorms.m need to be modified depending on the number of food patches. The values we use for our runs can be found in the comment above those variables in circularWorms.m. If you wish to use other starting positions, make sure that all worms are still within lattice borders because periodic boundary conditions are not explicitly used in this function as our values for rowMiddlePoint and columnMiddlePoint ensure that all worms are located on the lattice. 

Apart from this, the same parameters as in the minimal model can be set here. 

![Parameter initialisation for strain-specific model in main.m](https://github.com/lsmuhle/CollectiveFeeding/blob/master/images/generalParameterInitialisationStrainSpecific.jpg)

The food-leaving probabilites of *npr-1* and N2 worms and the speeds on and off food can be set in the parts of the script depicted below. 

![Parameter initialisation for strain-specific model in main.m for npr-1 worms](https://github.com/lsmuhle/CollectiveFeeding/blob/master/images/parameterInitialisationNpr1.jpg)

![Parameter initialisation for strain-specific model in main.m for N2 worms](https://github.com/lsmuhle/CollectiveFeeding/blob/master/images/parameterInitialisationN2.jpg)

Afterwards, again, run the simulation and save the desired outputs.

## Analysis of simulations
