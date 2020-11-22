
use "/Users/srhersco/Desktop/14.33 Paper/CampaignContributions1.dta"
 
append using "/Users/srhersco/Desktop/14.33 Paper/CampaignContributions2.dta", force

append using "/Users/srhersco/Desktop/14.33 Paper/CampaignContributions3.dta", force

append using "/Users/srhersco/Desktop/14.33 Paper/CampaignContributions4.dta", force

keep committee_name contributor_city contributor_state contributor_state contributor_zip contribution_receipt_date contribution_receipt_amount load_date

use "/Users/srhersco/Desktop/14.33 Paper/2016Contributions .dta", clear

keep committee_name contributor_city contributor_state contributor_state contributor_zip contribution_receipt_date contribution_receipt_amount load_date

save 2016ContributionsClean
