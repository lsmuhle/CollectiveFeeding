# Modelling social and solitary foraging of *C. elegans*

## Project description
This repository provides both code and data for the minimal and strain-specific model used in *Benefits of collective feeding in patchy food environments tested with C. elegans*. 
The minimal model is developed to compare social with solitary foraging in environments with different degrees of food clustering, as both strategies only differ in the ability of worms to form groups on food in environments with different degrees of food clustering.  
The strain-specific model includes more behavioural parameters such as speed on and off food or food-leaving probabilities and compares the foraging strategies of social *npr-1* and solitary N2 worms.  

## Reproduction of minimal model
To reproduce the minimal model, first download the functions from CollectiveFeeding/MinimalModel/functions. The script main.m provides the basis for running the code. In the first section the desired parameters can be entered. To control the degree of food clustering enter the desired number for \gamma (food is distributed uniformly random for \gamma = 0 and the degree of clustering increases as \gamma increases. 
