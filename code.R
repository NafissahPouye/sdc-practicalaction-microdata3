#Load required libraries
library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
#RE4R Project Assessment Phase Survey (Households) 
#https://data.humdata.org/dataset/re4r-project-assessment-phase-survey-gihembe-households
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-practicalAction-households3")
data <-  read_excel("data.xlsx")
#Select key variables                   
selectedKeyVars <- c('Respondent_gender',	'Head_of_household_type',
                     'Respondent_is_HoH',	'Household_type',
                     'Respondent_occupation',	'Head_of_household_occupation',
                     'Other_head_of_household_occupation')

#select 
#weightVars <- c('weights')

#Convert variables to factors
cols =  c('Respondent_gender','Head_of_household_type',
          'Respondent_is_HoH','Household_type',
          'Respondent_occupation','Head_of_household_occupation',
          'Other_head_of_household_occupation')

data[,cols] <- lapply(data[,cols], factor)

#Convert sub file to a dataframe
subVars <- c(selectedKeyVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars
                       )

#print the risk
print(objSDC, "risk")

#Generate an internal (extensive) report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 


