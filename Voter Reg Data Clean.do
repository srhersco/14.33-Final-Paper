import delimited "/Users/srhersco/Desktop/14.33 Paper/Voter Registation Data.csv", delimiter(comma) stringcols(1) clear 
drop if v1 == "Category: All categories"
drop if v1 == "DMA"
rename (v1 v2) (DMA InterestVoterRegistration)

save VoterRegData

