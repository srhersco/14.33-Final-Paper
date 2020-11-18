import excel "/Users/srhersco/Downloads/MPVDatasetDownload.xlsx", sheet("2013-2020 Police Killings") firstrow clear

drop Victimsage Victimsgender Agencyresponsiblefordeath Causeofdeath Abriefdescriptionofthecircu Officialdispositionofdeathj CriminalCharges Linktonewsarticleorphotoof Symptomsofmentalillness UnarmedDidNotHaveanActualW AllegedWeaponSourceWaPoand FleeingSourceWaPo BodyCameraSourceWaPo WaPoIDIfincludedinWaPodat OffDutyKilling GeographyviaTruliamethodolog MPVID FatalEncountersID AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW

drop URLofimageofvictim

drop if Victimsrace != "Black"

drop if DateofIncidentmonthdayyear < date("20200301", "YMD")
drop if DateofIncidentmonthdayyear > date("20200624", "YMD")

drop if AllegedThreatLevelSourceWa == "attack"


