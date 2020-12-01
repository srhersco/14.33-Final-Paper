# 14.33-Final-Paper
In the original data folder, I have the campaign contributions data in zip files due to their large size (in four seperate data sets due to the 250,000 download limit on the FEC website), BLM and Voter registration data from Google Trends in csv files, and the data on police killings in an excel files. 

In the data preprocessing folder, I have scripts that clean my data. First, Police killings.do cleans MPVDatasetDownload.xlsx to only inclde the relevant killings. Voter Reg Data Clean.do imports Voter Registation Data.csv and creates a .dta file. Campaign Data.do combines the four data sets that I download from the FEC website. The python scrips match zip codes from the campaign contribution data to DMAs, and then aggregate donations to each campaign.The cleaned data sets are then stored in the folder clean data. 

Finally, Final code.do is where I conduct all of my analysis and run the regressions. 
