import delimited "/Users/srhersco/Downloads/geoMap.csv", delimiter(comma) stringcols(1) clear

drop if v1 == "Category: All categories"
drop if v1 == "DMA"


rename (v1 v2) (DMA InterestBLM)

generate BLM = real(InterestBLM)

*adding in instrument

generate PKillingOccured = 0

replace PKillingOccured = 1 if DMA == "Los Angeles CA"
replace PKillingOccured = 1 if DMA == "Atlanta GA"
replace PKillingOccured = 1 if DMA == "New York NY"
replace PKillingOccured = 1 if DMA == "Little Rock-Pine Bluff AR"
replace PKillingOccured = 1 if DMA == "Tallahassee FL-Thomasville GA"
replace PKillingOccured = 1 if DMA == "Minneapolis-St. Paul MN"
replace PKillingOccured = 1 if DMA == "Phoenix AZ"
replace PKillingOccured = 1 if DMA == "Nashville TN"
replace PKillingOccured = 1 if DMA == "Montgomery (Selma) AL"
replace PKillingOccured = 1 if DMA == "Seattle-Tacoma WA"
replace PKillingOccured = 1 if DMA == "Baltimore MD"
replace PKillingOccured = 1 if DMA == "Washington DC (Hagerstown MD)"
replace PKillingOccured = 1 if DMA == "Orlando-Daytona Beach-Melbourne FL"
replace PKillingOccured = 1 if DMA == "Denver CO"
replace PKillingOccured = 1 if DMA == "Davenport IA-Rock Island-Moline IL"
replace PKillingOccured = 1 if DMA == "Milwaukee WI"
replace PKillingOccured = 1 if DMA == "San Francisco-Oakland-San Jose CA"
replace PKillingOccured = 1 if DMA == "Birmingham AL"
replace PKillingOccured = 1 if DMA == "Cleveland-Akron (Canton) OH"
replace PKillingOccured = 1 if DMA == "Columbia SC"
replace PKillingOccured = 1 if DMA == "Knoxville TN"
replace PKillingOccured = 1 if DMA == "Shreveport LA"
replace PKillingOccured = 1 if DMA == "Lafayette LA"
replace PKillingOccured = 1 if DMA == "Louisville KY"
replace PKillingOccured = 1 if DMA == "Kansas City MO"
replace PKillingOccured = 1 if DMA == "Cincinnati OH"
replace PKillingOccured = 1 if DMA == "Indianapolis IN"

*testing instrument

reg BLM PKillingOccured
test PKillingOccured

*merging cleaned files

merge 1:1 DMA using "/Users/srhersco/Desktop/14.33 Paper/VoterRegData.dta"

drop _merge

merge 1:1 DMA using "/Users/srhersco/Desktop/14.33 Paper/VoteReg2016.dta"

drop _merge

merge 1:1 DMA using "/Users/srhersco/Desktop/14.33 Paper/Campaign Donations Clean.dta"

drop _merge

generate VoteReg = real(InterestVoterRegistration)

*reg voter registration

ivregress 2sls VoteReg (BLM = PKillingOccured), vce(robust)
ivregress 2sls VoteReg votereg2016 (BLM = PKillingOccured), vce(robust)


ivregress 2sls biden_total_contributions (BLM = PKillingOccured), vce(robust)
ivregress 2sls trump_total_contributions (BLM = PKillingOccured), vce(robust)

*merging in 2016 campaign controls

merge 1:1 DMA using "/Users/srhersco/Desktop/14.33 Paper/Final2016ContributionsData.dta"

drop _merge

drop if DMA == ""

generate Dem_ind_contributions_2016 = bernie_ind_contributions_2016 + clinton_ind_contributions_2016

generate Dem_total_contributions_2016 = bernie_total_contributions_2016 + clinton_total_contributions_2016

*Biden Total Contributions

ivregress 2sls biden_total_contributions (BLM = PKillingOccured), vce(robust)

ivregress 2sls biden_total_contributions Dem_total_contributions_2016  (BLM = PKillingOccured), vce(robust)

*Trump total contributions

ivregress 2sls trump_total_contributions (BLM = PKillingOccured), vce(robust)

ivregress 2sls trump_total_contributions trump_total_contributions_2016 (BLM = PKillingOccured), vce(robust)

*Biden Ind. Contributions

ivregress 2sls biden_ind_contributions (BLM = PKillingOccured), vce(robust)

ivregress 2sls biden_ind_contributions Dem_ind_contributions_2016 (BLM = PKillingOccured), vce(robust)

*Trump Ind. Contributions

ivregress 2sls trump_ind_contributions (BLM = PKillingOccured), vce(robust)

ivregress 2sls trump_ind_contributions trump_ind_contributions_2016 (BLM = PKillingOccured), vce(robust)

*Creating Table Vote Reg 
eststo: ivregress 2sls VoteReg (BLM = PKillingOccured), vce(robust)
eststo: ivregress 2sls VoteReg votereg2016 (BLM = PKillingOccured), vce(robust)
esttab using impact_iv_reg.tex.tex, label title("Impacts of BLM on Voter Registration:  IV regression") mtitles("Regrssion 1" "Regrssion 2")  addnote( " ") nodepvars se ar2  replace star(+ 0.10 * 0.05) nonumbers eqlabels("" "First stage")


*Creating Table Biden 
eststo: ivregress 2sls biden_total_contributions (BLM = PKillingOccured), vce(robust)
eststo: ivregress 2sls biden_total_contributions Dem_total_contributions_2016 (BLM = PKillingOccured), vce(robust)
esttab using impact_iv_reg.tex, label title("Impacts of BLM on Contributions to the Biden Campaign:  IV regression") mtitles("Regrssion 1" "Regrssion 2")  addnote( " ") nodepvars se ar2  replace star(+ 0.10 * 0.05) nonumbers eqlabels("" "First stage")

*Creating Table Trump
eststo: ivregress 2sls biden_total_contributions (BLM = PKillingOccured), vce(robust)
eststo: ivregress 2sls biden_total_contributions Dem_total_contributions_2016 (BLM = PKillingOccured), vce(robust)
esttab using impact_iv_reg.tex, label title("Impacts of BLM on Contributions to the Biden Campaign:  IV regression") mtitles("Regrssion 1" "Regrssion 2")  addnote( " ") nodepvars se ar2  replace star(+ 0.10 * 0.05) nonumbers eqlabels("" "First stage")


