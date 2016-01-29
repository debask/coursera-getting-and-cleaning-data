# Coursera: Getting and Cleaning Data - Course Project

## Introduction

This repository contains my work for the Coursera - Getting and Cleaning data course project.

## The script

The R script, `run_analysis.R`, does the following:
    
1. Download the dataset when necessary
2. Load the training and test datasets
3. Load the activity and feature info
4. Merges the training and test datasets
5. Adds variable names and activity labels to dataset
6. Selects only the necessary variables
7. Creates a tidy dataset that only contains the mean value of each variable per subject and activity

The tidy dataset will be saved to the file `tidy.txt`

## The code book

The `Codebook.md` file explains the dataset and transformations performed