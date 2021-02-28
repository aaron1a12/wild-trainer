local skinCam = 0
local bIsSkinEditorOpen = false

-------------------------------------

customPeds = {
	{"joel", "Joel (The Last of Us)"},
	{"elliepatrol", "Ellie (The Last of Us 2)"},
	{"obama", "President Barack Obama"},
	{"altair", "Altair Ibn-La Ahad"},
	{"DavyJones", "Davy Jones"},
	{"hitman", "Agent 47"},
	{"lana", "Lana (The Sims 4)"}
}

gtaMainPlayersPeds = {
	{"player_zero", "Michael"}, 
	{"player_one", "Franklin"}, 
	{"player_two", "Trevor"}, 
	{"mp_f_freemode_01", "Freemode Female"}, 
	{"mp_m_freemode_01", "Freemode Male"}	
}
gtaAmbientMalePeds = {
	{"a_m_m_afriamer_01", "African American Male"},
	--{"a_m_m_acult_01", "Altruist Cult Mid-Age Male"},
	--{"a_m_o_acult_01", "Altruist Cult Old Male"},
	--{"a_m_o_acult_02", "Altruist Cult Old Male 2"},
	--{"a_m_y_acult_01", "Altruist Cult Young Male"},
	--{"a_m_y_acult_02", "Altruist Cult Young Male 2"},
	{"a_m_m_beach_01", "Beach Male"},
	{"a_m_m_beach_02", "Beach Male 2"},
	{"a_m_y_musclbeac_01", "Beach Muscle Male"},
	{"a_m_y_musclbeac_02", "Beach Muscle Male 2"},
	--{"a_m_m_mlcrisis_01", "Midlife Crisis Casino Bikers"},
	--{"a_m_y_gencaspat_01", "Casual Casino Guests"},
	--{"a_m_y_smartcaspat_01", "Formel Casino Guests"},
	{"a_m_o_beach_01", "Beach Old Male"},
	{"a_m_m_trampbeac_01", "Beach Tramp Male"},
	{"a_m_y_beach_01", "Beach Young Male"},
	{"a_m_y_beach_02", "Beach Young Male 2"},
	{"a_m_y_beach_03", "Beach Young Male 3"},
	{"a_m_m_bevhills_01", "Beverly Hills Male"},
	{"a_m_m_bevhills_02", "Beverly Hills Male 2"},
	{"a_m_y_bevhills_01", "Beverly Hills Young Male"},
	{"a_m_y_bevhills_02", "Beverly Hills Young Male 2"},
	{"a_m_y_stbla_01", "Black Street Male"},
	{"a_m_y_stbla_02", "Black Street Male 2"},
	{"a_m_y_breakdance_01", "Breakdancer Male"},
	{"a_m_y_busicas_01", "Business Casual"},
	{"a_m_m_business_01", "Business Male"},
	{"a_m_y_business_01", "Business Young Male"},
	{"a_m_y_business_02", "Business Young Male 2"},
	{"a_m_y_business_03", "Business Young Male 3"},
	{"a_m_y_cyclist_01", "Cyclist Male"},
	{"a_m_y_dhill_01", "Downhill Cyclist"},
	{"a_m_y_downtown_01", "Downtown Male"},
	{"a_m_m_eastsa_01", "East SA Male"},
	{"a_m_m_eastsa_02", "East SA Male 2"},
	{"a_m_y_eastsa_01", "East SA Young Male"},
	{"a_m_y_eastsa_02", "East SA Young Male 2"},
	{"a_m_y_epsilon_01", "Epsilon Male"},
	{"a_m_y_epsilon_02", "Epsilon Male 2"},
	{"a_m_m_farmer_01", "Farmer"},
	{"a_m_m_fatlatin_01", "Fat Latino Male"},
	{"a_m_y_gay_01", "Gay Male"},
	{"a_m_y_gay_02", "Gay Male 2"},
	{"a_m_m_genfat_01", "General Fat Male"},
	{"a_m_m_genfat_02", "General Fat Male 2"},
	{"a_m_o_genstreet_01", "General Street Old Male"},
	{"a_m_y_genstreet_01", "General Street Young Male"},
	{"a_m_y_genstreet_02", "General Street Young Male 2"},
	{"a_m_m_golfer_01", "Golfer Male"},
	{"a_m_y_golfer_01", "Golfer Young Male"},
	{"a_m_m_hasjew_01", "Hasidic Jew Male"},
	{"a_m_y_hasjew_01", "Hasidic Jew Young Male"},
	{"a_m_y_hiker_01", "Hiker Male"},
	{"a_m_m_hillbilly_01", "Hillbilly Male"},
	{"a_m_m_hillbilly_02", "Hillbilly Male 2"},
	{"a_m_y_hippy_01", "Hippie Male"},
	{"a_m_y_hipster_01", "Hipster Male"},
	{"a_m_y_hipster_02", "Hipster Male 2"},
	{"a_m_y_hipster_03", "Hipster Male 3"},
	{"a_m_m_indian_01", "Indian Male"},
	{"a_m_y_indian_01", "Indian Young Male"},
	{"a_m_y_jetski_01", "Jetskier"},
	{"a_m_y_runner_01", "Jogger Male"},
	{"a_m_y_runner_02", "Jogger Male 2"},
	{"a_m_y_juggalo_01", "Juggalo Male"},
	{"a_m_m_ktown_01", "Korean Male"},
	{"a_m_o_ktown_01", "Korean Old Male"},
	{"a_m_y_ktown_01", "Korean Young Male"},
	{"a_m_y_ktown_02", "Korean Young Male 2"},
	{"a_m_m_stlat_02", "Latino Street Male 2"},
	{"a_m_y_stlat_01", "Latino Street Young Male"},
	{"a_m_y_latino_01", "Latino Young Male"},
	{"a_m_m_malibu_01", "Malibu Male"},
	{"a_m_y_methhead_01", "Meth Addict"},
	{"a_m_m_mexlabor_01", "Mexican Labourer"},
	{"a_m_m_mexcntry_01", "Mexican Rural"},
	{"a_m_y_mexthug_01", "Mexican Thug"},
	{"a_m_y_motox_01", "Motocross Biker"},
	{"a_m_y_motox_02", "Motocross Biker 2"},
	{"a_m_m_og_boss_01", "OG Boss"},
	{"a_m_m_paparazzi_01", "Paparazzi Male"},
	{"a_m_m_polynesian_01", "Polynesian"},
	{"a_m_y_polynesian_01", "Polynesian Young"},
	{"a_m_m_prolhost_01", "Prologue Host Male"},
	{"a_m_y_roadcyc_01", "Road Cyclist"},
	{"a_m_m_rurmeth_01", "Rural Meth Addict Male"},
	{"a_m_m_salton_01", "Salton Male"},
	{"a_m_m_salton_02", "Salton Male 2"},
	{"a_m_m_salton_03", "Salton Male 3"},
	{"a_m_m_salton_04", "Salton Male 4"},
	{"a_m_o_salton_01", "Salton Old Male"},
	{"a_m_y_salton_01", "Salton Young Male"},
	{"a_m_m_skater_01", "Skater Male"},
	{"a_m_y_skater_01", "Skater Young Male"},
	{"a_m_y_skater_02", "Skater Young Male 2"},
	{"a_m_m_skidrow_01", "Skid Row Male"},
	{"a_m_m_socenlat_01", "South Central Latino Male"},
	{"a_m_m_soucent_01", "South Central Male"},
	{"a_m_m_soucent_02", "South Central Male 2"},
	{"a_m_m_soucent_03", "South Central Male 3"},
	{"a_m_m_soucent_04", "South Central Male 4"},
	{"a_m_o_soucent_01", "South Central Old Male"},
	{"a_m_o_soucent_02", "South Central Old Male 2"},
	{"a_m_o_soucent_03", "South Central Old Male 3"},
	{"a_m_y_soucent_01", "South Central Young Male"},
	{"a_m_y_soucent_02", "South Central Young Male 2"},
	{"a_m_y_soucent_03", "South Central Young Male 3"},
	{"a_m_y_soucent_04", "South Central Young Male 4"},
	{"a_m_y_sunbathe_01", "Sunbather Male"},
	{"a_m_y_surfer_01", "Surfer"},
	{"a_m_m_tennis_01", "Tennis Player Male"},
	{"a_m_m_tourist_01", "Tourist Male"},
	{"a_m_m_tramp_01", "Tramp Male"},
	{"a_m_o_tramp_01", "Tramp Old Male"},
	{"a_m_m_tranvest_01", "Transvestite Male"},
	{"a_m_m_tranvest_02", "Transvestite Male 2"},
	{"a_m_y_beachvesp_01", "Vespucci Beach Male"},
	{"a_m_y_beachvesp_02", "Vespucci Beach Male 2"},
	{"a_m_y_vindouche_01", "Vinewood Douche"},
	{"a_m_y_vinewood_01", "Vinewood Male"},
	{"a_m_y_vinewood_02", "Vinewood Male 2"},
	{"a_m_y_vinewood_03", "Vinewood Male 3"},
	{"a_m_y_vinewood_04", "Vinewood Male 4"},
	{"a_m_y_stwhi_01", "White Street Male"},
	{"a_m_y_stwhi_02", "White Street Male 2"},
	{"a_m_y_yoga_01", "Yoga Male"},
	{"a_m_y_clubcust_01", "Club Customer Male 1"},
	{"a_m_y_clubcust_02", "Club Customer Male 2"},
	{"a_m_y_clubcust_03", "Club Customer Male 3"}
}
gtaAmbientFemalePeds = {
	{"a_f_m_beach_01", "Beach Female"},
	{"a_f_m_trampbeac_01", "Beach Tramp Female"},
	{"a_f_y_beach_01", "Beach Young Female"},
	{"a_f_m_bevhills_01", "Beverly Hills Female"},
	{"a_f_m_bevhills_02", "Beverly Hills Female 2"},
	{"a_f_y_bevhills_01", "Beverly Hills Young Female"},
	{"a_f_y_bevhills_02", "Beverly Hills Young Female 2"},
	{"a_f_y_bevhills_03", "Beverly Hills Young Female 3"},
	{"a_f_y_bevhills_04", "Beverly Hills Young Female 4"},
	{"a_f_m_bodybuild_01", "Bodybuilder Female"},
	{"a_f_m_business_02", "Business Female 2"},
	{"a_f_y_business_01", "Business Young Female"},
	{"a_f_y_business_02", "Business Young Female 2"},
	{"a_f_y_business_03", "Business Young Female 3"},
	{"a_f_y_business_04", "Business Young Female 4"},
	{"a_f_m_downtown_01", "Downtown Female"},
	{"a_f_y_scdressy_01", "Dressy Female"},
	{"a_f_m_eastsa_01", "East SA Female"},
	{"a_f_m_eastsa_02", "East SA Female 2"},
	{"a_f_y_eastsa_01", "East SA Young Female"},
	{"a_f_y_eastsa_02", "East SA Young Female 2"},
	{"a_f_y_eastsa_03", "East SA Young Female 3"},
	{"a_f_y_epsilon_01", "Epsilon Female"},
	{"a_f_m_fatbla_01", "Fat Black Female"},
	{"a_f_m_fatcult_01", "Fat Cult Female"},
	{"a_f_m_fatwhite_01", "Fat White Female"},
	{"a_f_y_femaleagent", "Female Agent"},
	{"a_f_y_fitness_01", "Fitness Female"},
	{"a_f_y_fitness_02", "Fitness Female 2"},
	{"a_f_y_genhot_01", "General Hot Young Female"},
	{"a_f_o_genstreet_01", "General Street Old Female"},
	--{"a_f_y_gencaspat_01", "Casual Casino Guest"},
	--{"a_f_y_smartcaspat_01", "Formel Casino Guest"},
	{"a_f_y_golfer_01", "Golfer Young Female"},
	{"a_f_y_hiker_01", "Hiker Female"},
	{"a_f_y_hippie_01", "Hippie Female"},
	{"a_f_y_hipster_01", "Hipster Female"},
	{"a_f_y_hipster_02", "Hipster Female 2"},
	{"a_f_y_hipster_03", "Hipster Female 3"},
	{"a_f_y_hipster_04", "Hipster Female 4"},
	{"a_f_o_indian_01", "Indian Old Female"},
	{"a_f_y_indian_01", "Indian Young Female"},
	{"a_f_y_runner_01", "Jogger Female"},
	{"a_f_y_juggalo_01", "Juggalo Female"},
	{"a_f_m_ktown_01", "Korean Female"},
	{"a_f_m_ktown_02", "Korean Female 2"},
	{"a_f_o_ktown_01", "Korean Old Female"},
	{"a_f_m_prolhost_01", "Prologue Host Female"},
	{"a_f_y_rurmeth_01", "Rural Meth Addict Female"},
	{"a_f_m_salton_01", "Salton Female"},
	{"a_f_o_salton_01", "Salton Old Female"},
	{"a_f_y_skater_01", "Skater Female"},
	{"a_f_m_skidrow_01", "Skid Row Female"},
	{"a_f_m_soucent_01", "South Central Female"},
	{"a_f_m_soucent_02", "South Central Female 2"},
	{"a_f_m_soucentmc_01", "South Central MC Female"},
	{"a_f_o_soucent_01", "South Central Old Female"},
	{"a_f_o_soucent_02", "South Central Old Female 2"},
	{"a_f_y_soucent_01", "South Central Young Female"},
	{"a_f_y_soucent_02", "South Central Young Female 2"},
	{"a_f_y_soucent_03", "South Central Young Female 3"},
	{"a_f_y_tennis_01", "Tennis Player Female"},
	{"a_f_y_topless_01", "Topless"},
	{"a_f_m_tourist_01", "Tourist Female"},
	{"a_f_y_tourist_01", "Tourist Young Female"},
	{"a_f_y_tourist_02", "Tourist Young Female 2"},
	{"a_f_m_tramp_01", "Tramp Female"},
	{"a_f_y_vinewood_01", "Vinewood Female"},
	{"a_f_y_vinewood_02", "Vinewood Female 2"},
	{"a_f_y_vinewood_03", "Vinewood Female 3"},
	{"a_f_y_vinewood_04", "Vinewood Female 4"},
	{"a_f_y_yoga_01", "Yoga Female"},
	{"a_f_y_clubcust_01", "Club Customer Female 1"},
	{"a_f_y_clubcust_02", "Club Customer Female 2"},
	{"a_f_y_clubcust_03", "Club Customer Female 3"}
}
gtaGangMalePeds = {
	{"g_f_importexport_01", "Gang Female (Import-Export)"},
	{"g_m_importexport_01", "Gang Male (Import-Export)"},
	{"g_m_m_armboss_01", "Armenian Boss"},
	{"g_m_m_armgoon_01", "Armenian Goon"},
	{"g_m_y_armgoon_02", "Armenian Goon 2"},
	{"g_m_m_armlieut_01", "Armenian Lieutenant"},
	{"g_m_y_azteca_01", "Azteca"},
	{"g_m_y_ballaeast_01", "Ballas East Male"},
	{"g_m_y_ballaorig_01", "Ballas Original Male"},
	{"g_m_y_ballasout_01", "Ballas South Male"},
	--{"g_m_m_casrn_01", "Casino Guests?"}, crashes
	{"g_m_m_chemwork_01", "Chemical Plant Worker"},
	{"g_m_m_chiboss_01", "Chinese Boss"},
	{"g_m_m_chigoon_01", "Chinese Goon"},
	{"g_m_m_chigoon_02", "Chinese Goon 2"},
	{"g_m_m_chicold_01", "Chinese Goon Older"},
	{"g_m_y_famca_01", "Families CA Male"},
	{"g_m_y_famdnf_01", "Families DNF Male"},
	{"g_m_y_famfor_01", "Families FOR Male"},
	{"g_m_m_korboss_01", "Korean Boss"},
	{"g_m_y_korlieut_01", "Korean Lieutenant"},
	{"g_m_y_korean_01", "Korean Young Male"},
	{"g_m_y_korean_02", "Korean Young Male 2"},
	{"g_m_m_mexboss_01", "Mexican Boss"},
	{"g_m_m_mexboss_02", "Mexican Boss 2"},
	{"g_m_y_mexgang_01", "Mexican Gang Member"},
	{"g_m_y_mexgoon_01", "Mexican Goon"},
	{"g_m_y_mexgoon_02", "Mexican Goon 2"},
	{"g_m_y_mexgoon_03", "Mexican Goon 3"},
	{"g_m_y_pologoon_01", "Polynesian Goon"},
	{"g_m_y_pologoon_02", "Polynesian Goon 2"},
	{"g_m_y_salvaboss_01", "Salvadoran Boss"},
	{"g_m_y_salvagoon_01", "Salvadoran Goon"},
	{"g_m_y_salvagoon_02", "Salvadoran Goon 2"},
	{"g_m_y_salvagoon_03", "Salvadoran Goon 3"},
	{"g_m_y_strpunk_01", "Street Punk"},
	{"g_m_y_strpunk_02", "Street Punk 2"},
	{"g_m_y_lost_01", "The Lost MC Male"},
	{"g_m_y_lost_02", "The Lost MC Male 2"},
	{"g_m_y_lost_03", "The Lost MC Male 3"}
}
gtaGangFemalePeds = {
	{"g_f_y_ballas_01", "Ballas Female"},
	{"g_f_y_families_01", "Families Female"},
	{"g_f_importexport_01", "Import Export Female"},
	{"g_f_y_lost_01", "The Lost MC Female"},
	{"g_f_y_vagos_01", "Vagos Female"}
}
gtaCutscenePeds = {
	{"csb_abigail", "Abigail Mathers"},
	{"csb_agent", "Agent"},
	{"csb_agatha", "Agatha Baker"},
	{"csb_avery", "Avery Duggan"},
	{"csb_mp_agent14", "Agent 14"},
	{"cs_amandatownley", "Amanda De Santa"},
	{"cs_andreas", "Andreas Sanchez"},
	{"csb_anita", "Anita Mendoza"},
	{"csb_anton", "Anton Beaudelaire"},
	{"cs_ashley", "Ashley Butler"},
	{"csb_avon", "Avon Hertz"},
	{"csb_ballasog", "Ballas OG"},
	{"cs_bankman", "Bank Manager"},
	{"cs_barry", "Barry"},
	{"cs_beverly", "Beverly Felton"},
	--{"csb_brucie2", "Brucie Kibbutz"},
	{"cs_orleans", "Bigfoot"},
	{"csb_bogdan", "Bogdan"},
	{"cs_brad", "Brad"},
	{"cs_bradcadaver", "Brad's Cadaver"},
	{"csb_bride", "Bride"},
	{"csb_burgerdrug", "Burger Drug Worker"},
	{"csb_car3guy1", "Car 3 Guy 1"},
	{"csb_car3guy2", "Car 3 Guy 2"},
	{"cs_carbuyer", "Car Buyer"},
	{"cs_casey", "Casey"},
	{"csb_chef", "Chef"},
	{"csb_chef2", "Chef"},
	{"csb_chin_goon", "Chinese Goon"},
	{"cs_clay", "Clay Simons (The Lost)"},
	{"csb_cletus", "Cletus"},
	{"csb_cop", "Cop"},
	{"cs_chrisformage", "Cris Formage"},
	{"csb_customer", "Customer"},
	{"cs_dale", "Dale"},
	{"cs_davenorton", "Dave Norton"},
	{"cs_debra", "Debra"},
	{"cs_denise", "Denise"},
	{"csb_denise_friend", "Denise's Friend"},
	{"cs_devin", "Devin"},
	{"csb_popov", "Dima Popov"},
	{"cs_dom", "Dom Beasley"},
	{"cs_drfriedlander", "Dr. Friedlander"},
	{"cs_tomepsilon", "Epsilon Tom"},
	{"cs_fabien", "Fabien"},
	{"csb_ramp_gang", "Families Gang Member?"},
	{"cs_mrk", "Ferdinand Kerimov (Mr. K)"},
	{"cs_fbisuit_01", "FIB Suit"},
	{"cs_floyd", "Floyd Hebert"},
	{"csb_fos_rep", "FOS Rep?"},
	{"csb_g", "Gerald"},
	{"csb_groom", "Groom"},
	{"csb_grove_str_dlr", "Grove Street Dealer"},
	{"cs_guadalope", "Guadalope"},
	{"cs_gurk", "GURK?"},
	{"csb_hao", "Hao"},
	{"csb_ramp_hic", "Hick"},
	{"csb_ramp_hipster", "Hipster"},
	{"csb_hugh", "Hugh Welsh"},
	{"cs_hunter", "Hunter"},
	{"csb_imran", "Imran Shinowa"},
	{"csb_jackhowitzer", "Jack Howitzer"},
	{"cs_janet", "Janet"},
	{"csb_janitor", "Janitor"},
	{"cs_jewelass", "Jeweller Assistant"},
	{"cs_jimmyboston", "Jimmy Boston"},
	{"cs_jimmydisanto", "Jimmy De Santa"},
	{"cs_johnnyklebitz", "Johnny Klebitz"},
	{"cs_josef", "Josef"},
	{"cs_josh", "Josh"},
	{"cs_karen_daniels", "Karen Daniels"},
	{"cs_lamardavis", "Lamar Davis"},
	{"cs_lazlow", "Lazlow"},
	{"cs_lestercrest", "Lester Crest"},
	{"cs_lifeinvad_01", "Life Invader"},
	{"cs_magenta", "Magenta"},
	{"cs_manuel", "Manuel"},
	{"csb_ramp_marine", "Marine"},
	{"cs_marnie", "Marnie Allen"},
	{"cs_martinmadrazo", "Martin Madrazo"},
	{"cs_maryann", "Mary-Ann Quinn"},
	{"csb_maude", "Maude"},
	{"csb_rashcosvki", "Maxim Rashkovsky"},
	{"csb_mweather", "Merryweather Merc"},
	{"csb_ramp_mex", "Mexican"},
	{"cs_michelle", "Michelle"},
	{"cs_milton", "Milton McIlroy"},
	{"cs_joeminuteman", "Minuteman Joe"},
	{"cs_molly", "Molly"},
	{"csb_money", "Money Man"},
	{"cs_movpremf_01", "Movie Premiere Female"},
	{"cs_movpremmale", "Movie Premiere Male"},
	{"cs_mrsphillips", "Mrs. Phillips"},
	{"csb_mrs_r", "Mrs. Rackman"},
	{"cs_mrs_thornhill", "Mrs. Thornhill"},
	{"cs_natalia", "Natalia"},
	{"cs_nervousron", "Nervous Ron"},
	{"cs_nigel", "Nigel"},
	{"cs_old_man1a", "Old Man 1"},
	{"cs_old_man2", "Old Man 2"},
	{"cs_omega", "Omega"},
	{"csb_ortega", "Ortega"},
	{"csb_oscar", "Oscar"},
	{"csb_paige", "Paige Harris"},
	{"cs_patricia", "Patricia"},
	{"cs_dreyfuss", "Peter Dreyfuss"},
	{"csb_porndudes", "Porn Dude"},
	{"cs_priest", "Priest"},
	{"csb_prologuedriver", "Prologue Driver"},
	{"csb_prolsec", "Prologue Security"},
	{"cs_prolsec_02", "Prologue Security 2"},
	{"csb_reporter", "Reporter"},
	{"csb_roccopelosi", "Rocco Pelosi"},
	{"cs_russiandrunk", "Russian Drunk"},
	{"csb_screen_writer", "Screenwriter"},
	{"cs_siemonyetarian", "Simeon Yetarian"},
	{"cs_solomon", "Solomon Richards"},
	{"cs_stevehains", "Steve Haines"},
	{"cs_stretch", "Stretch"},
	{"csb_stripper_01", "Stripper"},
	{"csb_stripper_02", "Stripper 2"},
	{"cs_tanisha", "Tanisha"},
	{"cs_taocheng", "Tao Cheng"},
	--{"cs_taocheng2", "Tao Cheng (Casino)"},
	{"cs_taostranslator", "Tao's Translator"},
	--{"cs_taostranslator2", "Tao's Translator (Casino)"},
	{"cs_tenniscoach", "Tennis Coach"},
	{"cs_terry", "Terry"},
	{"cs_tom", "Tom"},
	--{"csb_tomcasino", "Tom Connors"},
	{"csb_tonya", "Tonya"},
	{"csb_thornton", "Thornton Duggan"},
	{"cs_tracydisanto", "Tracey De Santa"},
	{"csb_trafficwarden", "Traffic Warden"},
	{"csb_undercover", "Undercover Cop"},
	{"cs_paper", "United Paper Man"},
	{"csb_vagspeak", "Vagos Speak"},
	--{"csb_vincent", "Vincent (Casino)"},
	{"cs_wade", "Wade"},
	{"cs_chengsr", "Wei Cheng"},
	{"cs_zimbor", "Zimbor"},
	{"csb_djblamadon", "DJ Black Madonna"},
	{"csb_dix", "Dixon"},
	{"csb_englishdave", "English Dave"},
	{"cs_lazlow_2", "Lazlow 2"},
	{"csb_sol", "Soloman"},
	{"csb_talcc", "Tale of Us 1"},
	{"csb_talmm", "Tale of Us 2"},
	{"csb_tonyprince", "Tony Prince"},
	{"csb_alan", "Alan Jerome"},
	{"csb_bryony", "Bryony"}
}
gtaStoryPeds = {
	{"player_zero", "Michael"},
	{"player_one", "Franklin"},
	{"player_two", "Trevor"},
	{"ig_abigail", "Abigail Mathers"},
	{"ig_agent", "Agent"},
	--{"ig_agatha", "Agatha Baker"},
	--{"ig_avery", "Avery Duggan"},
	{"ig_mp_agent14", "Agent 14"},
	{"ig_amandatownley", "Amanda De Santa"},
	{"ig_andreas", "Andreas Sanchez"},
	{"ig_ashley", "Ashley Butler"},
	{"ig_avon", "Avon Hertz"},
	{"ig_ballasog", "Ballas OG"},
	{"ig_benny", "Benny"},
	{"ig_bankman", "Bank Manager"},
	{"ig_barry", "Barry"},
	{"ig_bestmen", "Best Man"},
	{"ig_beverly", "Beverly Felton"},
	--{"ig_brucie2", "Brucie Kibbutz"},
	{"ig_orleans", "Bigfoot"},
	{"ig_brad", "Brad"},
	{"ig_bride", "Bride"},
	{"ig_car3guy1", "Car 3 Guy 1"},
	{"ig_car3guy2", "Car 3 Guy 2"},
	{"ig_casey", "Casey"},
	{"ig_chef", "Chef"},
	{"ig_chef2", "Chef"},
	{"ig_claypain", "Clay Jackson (The Pain Giver)"},
	{"ig_clay", "Clay Simons (The Lost)"},
	{"ig_cletus", "Cletus"},
	{"ig_chrisformage", "Cris Formage"},
	{"ig_dale", "Dale"},
	{"ig_davenorton", "Dave Norton"},
	{"ig_denise", "Denise"},
	{"ig_devin", "Devin"},
	{"ig_popov", "Dima Popov"},
	{"ig_dom", "Dom Beasley"},
	{"ig_drfriedlander", "Dr. Friedlander"},
	{"ig_tomepsilon", "Epsilon Tom"},
	{"ig_fabien", "Fabien"},
	{"ig_ramp_gang", "Families Gang Member?"},
	{"ig_mrk", "Ferdinand Kerimov (Mr. K)"},
	{"ig_fbisuit_01", "FIB Suit"},
	{"ig_floyd", "Floyd Hebert"},
	{"ig_g", "Gerald"},
	{"ig_groom", "Groom"},
	{"ig_hao", "Hao"},
	{"ig_ramp_hic", "Hick"},
	{"ig_ramp_hipster", "Hipster"},
	{"ig_hunter", "Hunter"},
	{"ig_janet", "Janet"},
	{"ig_jay_norris", "Jay Norris"},
	{"ig_jewelass", "Jeweller Assistant"},
	{"ig_jimmyboston", "Jimmy Boston"},
	{"ig_jimmydisanto", "Jimmy De Santa"},
	{"ig_johnnyklebitz", "Johnny Klebitz"},
	{"ig_josef", "Josef"},
	{"ig_josh", "Josh"},
	{"ig_karen_daniels", "Karen Daniels"},
	{"ig_kerrymcintosh", "Kerry McIntosh"},
	{"ig_lamardavis", "Lamar Davis"},
	{"ig_lazlow", "Lazlow"},
	{"ig_lestercrest", "Lester Crest"},
	{"ig_lestercrest_2", "Lester Crest (Doomsday Heist)"},
	{"ig_lifeinvad_01", "Life Invader"},
	{"ig_lifeinvad_02", "Life Invader 2"},
	{"ig_magenta", "Magenta"},
	{"ig_manuel", "Manuel"},
	{"ig_marnie", "Marnie Allen"},
	{"ig_maryann", "Mary-Ann Quinn"},
	{"ig_maude", "Maude"},
	{"ig_rashcosvki", "Maxim Rashkovsky"},
	{"ig_ramp_mex", "Mexican"},
	{"ig_michelle", "Michelle"},
	{"ig_milton", "Milton McIlroy"},
	{"ig_joeminuteman", "Minuteman Joe"},
	{"ig_malc", "Malc"},
	{"ig_molly", "Molly"},
	{"ig_money", "Money Man"},
	{"ig_mrsphillips", "Mrs. Phillips"},
	{"ig_mrs_thornhill", "Mrs. Thornhill"},
	{"ig_natalia", "Natalia"},
	{"ig_nervousron", "Nervous Ron"},
	{"ig_nigel", "Nigel"},
	{"ig_old_man1a", "Old Man 1"},
	{"ig_old_man2", "Old Man 2"},
	{"ig_omega", "Omega"},
	{"ig_oneil", "O'Neil Brothers"},
	{"ig_ortega", "Ortega"},
	{"ig_paige", "Paige Harris"},
	{"ig_patricia", "Patricia"},
	{"ig_dreyfuss", "Peter Dreyfuss"},
	{"ig_priest", "Priest"},
	{"ig_prolsec_02", "Prologue Security 2"},
	{"ig_roccopelosi", "Rocco Pelosi"},
	{"ig_russiandrunk", "Russian Drunk"},
	{"ig_screen_writer", "Screenwriter"},
	{"ig_siemonyetarian", "Simeon Yetarian"},
	{"ig_solomon", "Solomon Richards"},
	{"ig_stevehains", "Steve Haines"},
	{"ig_stretch", "Stretch"},
	{"ig_talina", "Talina"},
	{"ig_tanisha", "Tanisha"},
	{"ig_taocheng", "Tao Cheng"},
	--{"ig_taocheng2", "Tao Cheng (Casino)"},
	{"ig_taostranslator", "Tao's Translator"},
	--{"ig_taostranslator2", "Tao's Translator (Casino)"},
	{"ig_tenniscoach", "Tennis Coach"},
	{"ig_terry", "Terry"},
	{"ig_tonya", "Tonya"},
	{"ig_tracydisanto", "Tracey De Santa"},
	{"ig_trafficwarden", "Traffic Warden"},
	{"ig_tylerdix", "Tyler Dixon"},
	{"ig_paper", "United Paper Man"},
	{"ig_vagspeak", "Vagos Funeral Speaker"},
	{"ig_wade", "Wade"},
	{"ig_chengsr", "Wei Cheng"},
	{"ig_zimbor", "Zimbor"},
	{"ig_djblamadon", "DJ Black Madonna"},
	{"ig_djblamryans", "DJ Ryan S"},
	{"ig_djblamrupert", "DJ Rupert"},
	{"ig_djdixmanager", "DJ Dixon Manager"},
	{"ig_djsolfotios", "DJ Fotios"},
	{"ig_djsoljakob", "DJ Jakob"},
	{"ig_djsolmike", "DJ Mike T"},
	{"ig_djsolrobt", "DJ Rob T"},
	{"ig_djtalaurelia", " DJ Aurelia"},
	{"ig_djtalignazio", "DJ Ignazio"},
	{"ig_dix", "Dixon"},
	{"ig_englishdave", "English Dave"},
	{"ig_djgeneric_01", "Generic DJ"},
	{"ig_jimmyboston_02", "Jimmy Boston 2"},
	{"ig_kerrymcintosh_02", "Kerry McIntosh 2"},
	{"ig_lacey_jones_02", "Lacy Jones 2"},
	{"ig_lazlow_2", "Lazlow 2"},
	{"ig_sol", "Soloman"},
	{"ig_djsolmanager", "Soloman Manager"},
	{"ig_talcc", "Tale of Us 1"},
	{"ig_talmm", "Tale of Us 2"},
	{"ig_tylerdix_02", "Tyler Dixon 2"},
	{"ig_tonyprince", "Tony Prince"},
	{"ig_sacha", "Sacha Yetarian"}
	--{"ig_thornton", "Thornton Duggan"},
	--{"ig_tomcasino", "Tom Connors"},
	--{"ig_vincent", "Vincent (Casino)"}
}
gtaMultiplayerPeds = {
	{"mp_s_m_armoured_01", "Armoured Van Security Male"},
	{"mp_m_avongoon", "Avon Goon"},
	{"mp_f_cocaine_01", "Biker Cocaine Female"},
	{"mp_m_cocaine_01", "Biker Cocaine Male"},
	{"mp_f_counterfeit_01", "Biker Counterfeit Female"},
	{"mp_m_counterfeit_01", "Biker Counterfeit Male"},
	{"mp_f_forgery_01", "Biker Forgery Female"},
	{"mp_m_forgery_01", "Biker Forgery Male"},
	{"mp_f_meth_01", "Biker Meth Female"}, 
	{"mp_m_meth_01", "Biker Meth Male"},
	{"mp_f_weed_01", "Biker Weed Female"},
	{"mp_m_weed_01", "Biker Weed Male"},
	{"mp_f_boatstaff_01", "Boat-Staff Female"},
	{"mp_m_boatstaff_01", "Boat-Staff Male"},
	{"mp_m_bogdangoon", "Bogdan Goon"},
	{"mp_f_chbar_01", "Clubhouse Bar Female"},
	{"mp_m_claude_01", "Claude Speed"},
	{"mp_f_deadhooker", "Dead Hooker"},
	{"mp_m_exarmy_01", "Ex-Army Male"},
	{"mp_f_execpa_01", "Executive PA Female"},
	{"mp_f_execpa_02", "Executive PA Female 2"},
	{"mp_m_execpa_01", "Executive PA Male"},
	{"mp_m_famdd_01", "Families DD Male"},
	{"mp_m_fibsec_01", "FIB Security"},
	{"mp_f_freemode_01", "Freemode Female"},
	{"mp_m_freemode_01", "Freemode Male"},
	{"mp_f_helistaff_01", "Heli-Staff Female"},
	{"mp_m_marston_01", "John Marston"},
	{"mp_f_misty_01", "Misty"},
	{"mp_m_niko_01", "Niko Bellic"},
	{"mp_f_cardesign_01", "Office Garage Mechanic (Female)"},
	{"mp_g_m_pros_01", "Pros"},
	{"mp_m_securoguard_01", "Securoserve Guard (Male)"},
	{"mp_m_shopkeep_01", "Shopkeeper (Male)"},
	{"mp_f_stripperlite", "Stripper Lite (Female)"},
	{"mp_m_g_vagfun_01", "Vagos Funeral"},
	{"mp_m_waremech_01", "Warehouse Mechanic (Male)"},
	{"mp_m_weapexp_01", "Weapon Exp (Male)"},
	{"mp_m_weapwork_01", "Weapon Work (Male)"},
	{"mp_f_bennymech_01", "Benny Mechanic (Female)"}
}
gtaScenarioMalePeds = {
	{"s_m_y_airworker", "Air Worker Male"},
	{"s_m_m_movalien_01", "Alien"},
	{"s_m_y_ammucity_01", "Ammu-Nation City Clerk"},
	{"s_m_m_ammucountry", "Ammu-Nation Rural Clerk"},
	{"s_m_m_armoured_01", "Armoured Van Security"},
	{"s_m_m_armoured_02", "Armoured Van Security 2"},
	{"s_m_y_armymech_01", "Army Mechanic"},
	{"s_m_y_autopsy_01", "Autopsy Tech"},
	{"s_m_m_autoshop_01", "Autoshop Worker"},
	{"s_m_m_autoshop_02", "Autoshop Worker 2"},
	{"s_m_y_barman_01", "Barman"},
	{"s_m_m_cntrybar_01", "Bartender (Rural)"},
	{"s_m_y_baywatch_01", "Baywatch Male"},
	{"s_m_y_blackops_01", "Black Ops Soldier"},
	{"s_m_y_blackops_02", "Black Ops Soldier 2"},
	{"s_m_y_blackops_03", "Black Ops Soldier 3"},
	{"s_m_m_bouncer_01", "Bouncer"},
	{"s_m_y_busboy_01", "Busboy"},
	{"s_m_o_busker_01", "Busker"},
	--{"s_m_y_casino_01", "Casino Staff"},
	{"s_m_y_chef_01", "Chef"},
	{"s_m_m_chemsec_01", "Chemical Plant Security"},
	{"s_m_y_clown_01", "Clown"},
	{"s_m_y_construct_01", "construction Worker"},
	{"s_m_y_construct_02", "construction Worker 2"},
	{"s_m_y_cop_01", "Cop Male"},
	{"s_m_m_ccrew_01", "Crew Member"},
	{"s_m_y_dealer_01", "Dealer"},
	{"s_m_y_devinsec_01", "Devin's Security"},
	{"s_m_m_dockwork_01", "Dock Worker"},
	{"s_m_y_dockwork_01", "Dock Worker"},
	{"s_m_m_doctor_01", "Doctor"},
	{"s_m_y_doorman_01", "Doorman"},
	{"s_m_y_dwservice_01", "DW Airport Worker"},
	{"s_m_y_dwservice_02", "DW Airport Worker 2"},
	{"s_m_y_factory_01", "Factory Worker Male"},
	{"s_m_m_fiboffice_01", "FIB Office Worker"},
	{"s_m_m_fiboffice_02", "FIB Office Worker 2"},
	{"s_m_m_fibsec_01", "FIB Security"},
	{"s_m_y_fireman_01", "Fireman Male"},
	{"s_m_m_gaffer_01", "Gaffer"},
	{"s_m_y_garbage", "Garbage Worker"},
	{"s_m_m_gardener_01", "Gardener"},
	{"s_m_y_grip_01", "Grip"},
	{"s_m_m_hairdress_01", "Hairdresser Male"},
	{"s_m_m_highsec_01", "High Security"},
	{"s_m_m_highsec_02", "High Security 2"},
	{"s_m_y_hwaycop_01", "Highway Cop"},
	{"s_m_m_ciasec_01", "IAA Security"},
	{"s_m_m_janitor", "Janitor"},
	{"s_m_m_lathandy_01", "Latino Handyman Male"},
	{"s_m_m_lifeinvad_01", "Life Invader Male"},
	{"s_m_m_linecook", "Line Cook"},
	{"s_m_m_lsmetro_01", "LS Metro Worker Male"},
	{"s_m_m_mariachi_01", "Mariachi"},
	{"s_m_m_marine_01", "Marine"},
	{"s_m_m_marine_02", "Marine 2"},
	{"s_m_y_marine_01", "Marine Young"},
	{"s_m_y_marine_02", "Marine Young 2"},
	{"s_m_y_marine_03", "Marine Young 3"},
	{"s_m_y_xmech_01", "Mechanic"},
	{"s_m_y_xmech_02", "MC Clubhouse Mechanic"},
	{"s_m_m_migrant_01", "Migrant Male"},
	{"s_m_y_mime", "Mime Artist"},
	{"s_m_m_movspace_01", "Movie Astronaut"},
	{"s_m_m_movprem_01", "Movie Premiere Male"},
	{"s_m_m_paramedic_01", "Paramedic"},
	{"s_m_y_pestcont_01", "Pest Control"},
	{"s_m_m_pilot_01", "Pilot"},
	{"s_m_y_pilot_01", "Pilot"},
	{"s_m_m_pilot_02", "Pilot 2"},
	{"s_m_m_postal_01", "Postal Worker Male"},
	{"s_m_m_postal_02", "Postal Worker Male 2"},
	{"s_m_m_prisguard_01", "Prison Guard"},
	{"s_m_y_prisoner_01", "Prisoner"},
	{"s_m_y_prismuscl_01", "Prisoner (Muscular)"},
	{"s_m_y_ranger_01", "Ranger Male"},
	{"s_m_y_robber_01", "Robber"},
	{"s_m_y_shop_mask", "Mask Salesman"},
	{"s_m_m_scientist_01", "Scientist"},
	{"s_m_m_security_01", "Security Guard"},
	{"s_m_y_sheriff_01", "Sheriff Male"},
	{"s_m_m_snowcop_01", "Snow Cop Male"},
	{"s_m_m_strperf_01", "Street Performer"},
	{"s_m_m_strpreach_01", "Street Preacher"},
	{"s_m_m_strvend_01", "Street Vendor"},
	{"s_m_y_strvend_01", "Street Vendor Young"},
	{"s_m_y_swat_01", "SWAT"},
	{"s_m_m_gentransport", "Transport Worker Male"},
	{"s_m_m_trucker_01", "Trucker Male"},
	{"s_m_m_ups_01", "UPS Driver"},
	{"s_m_m_ups_02", "UPS Driver 2"},
	{"s_m_y_uscg_01", "US Coastguard"},
	{"s_m_y_valet_01", "Valet"},
	{"s_m_y_waiter_01", "Waiter"},
	--{"s_m_y_westsec_01", "Duggan Secruity"},
	{"s_m_y_winclean_01", "Window Cleaner"},
	{"s_m_y_clubbar_01", "Club Bartender Male"},
	{"s_m_y_waretech_01", "Warehouse Technician"}
}
gtaScenarioFemaleMalePeds = {
	{"s_f_y_airhostess_01", "Air Hostess"},
	{"s_f_m_fembarber", "Barber Female"},
	{"s_f_y_bartender_01", "Bartender"},
	{"s_f_y_baywatch_01", "Baywatch Female"},
	--{"s_f_y_casino_01", "Casino Staff"},
	{"s_f_y_cop_01", "Cop Female"},
	{"s_f_y_factory_01", "Factory Worker Female"},
	{"s_f_y_hooker_01", "Hooker"},
	{"s_f_y_hooker_02", "Hooker 2"},
	{"s_f_y_hooker_03", "Hooker 3"},
	{"s_f_y_scrubs_01", "Hospital Scrubs Female"},
	{"s_f_m_maid_01", "Maid"},
	{"s_f_y_migrant_01", "Migrant Female"},
	{"s_f_y_movprem_01", "Movie Premiere Female"},
	{"s_f_y_ranger_01", "Ranger Female"},
	{"s_f_m_shop_high", "Sales Assistant (High-End)"},
	{"s_f_y_shop_low", "Sales Assistant (Low-End)"},
	{"s_f_y_shop_mid", "Sales Assistant (Mid-Price)"},
	{"s_f_y_sheriff_01", "Sheriff Female"},
	{"s_f_y_stripper_01", "Stripper"},
	{"s_f_y_stripper_02", "Stripper 2"},
	{"s_f_y_stripperlite", "Stripper Lite"},
	{"s_f_m_sweatshop_01", "Sweatshop Worker"},
	{"s_f_y_sweatshop_01", "Sweatshop Worker Young"},
	{"s_f_y_clubbar_01", "Club Bartender Female"}
}
gtaStoryScenarioMalePeds = {
	{"u_m_y_abner", "Abner"},
	{"u_m_m_aldinapoli", "Al Di Napoli Male"},
	{"u_m_y_antonb", "Anton Beaudelaire"},
	{"u_m_y_juggernaut_01", "Avon Juggernaut"},
	{"u_m_y_babyd", "Baby D"},
	{"u_m_m_bankman", "Bank Manager Male"},
	{"u_m_m_bikehire_01", "Bike Hire Guy"},
	--{"u_m_m_blane", "Blane"},
	--{"u_m_m_curtis", "Curtis"},
	--{"u_m_m_vince", "Vince"},
	--{"u_m_o_dean", "Dean"},
	--{"u_m_y_caleb", "Caleb"},
	--{"u_m_y_croupthief_01", "Casino Thief"},
	--{"u_m_y_gabriel", "Gabriel"},
	--{"u_m_y_ushi", "Ushi"},
	{"u_m_y_burgerdrug_01", "Burger Drug Worker"},
	{"u_m_y_chip", "Chip"},
	{"u_m_y_cyclist_01", "Cyclist Male"},
	{"u_m_y_corpse_01", "Dead Courier"},
	{"u_m_m_doa_01", "DOA Man"},
	{"u_m_m_edtoh", "Ed Toh"},
	{"u_m_y_militarybum", "Ex-Mil Bum"},
	{"u_m_m_fibarchitect", "FIB Architect"},
	{"u_m_y_fibmugger_01", "FIB Mugger"},
	{"u_m_o_finguru_01", "Financial Guru"},
	{"u_m_m_glenstank_01", "Glen-Stank Male"},
	{"u_m_m_griff_01", "Griff"},
	{"u_m_y_guido_01", "Guido"},
	{"u_m_y_gunvend_01", "Gun Vendor"},
	{"u_m_y_smugmech_01", "Hangar Mechanic"},
	{"u_m_y_hippie_01", "Hippie Male"},
	{"u_m_m_streetart_01", "Street Art Male"},
	{"u_m_y_imporage", "Impotent Rage"},
	{"u_m_o_taphillbilly", "Jesco White (Tapdancing Hillbilly)"},
	{"u_m_m_jesus_01", "Jesus"},
	{"u_m_m_jewelthief", "Jewel Thief"},
	{"u_m_m_jewelsec_01", "Jeweller Security"},
	{"u_m_y_justin", "Justin"},
	{"u_m_y_baygor", "Kifflom Guy"},
	{"u_m_m_willyfist", "Love Fist Willy"},
	{"u_m_y_mani", "Mani"},
	{"u_m_m_markfost", "Mark Fostenburg"},
	{"u_m_m_filmdirector", "Movie Director"},
	{"u_m_o_filmnoir", "Movie Corpse (Suited)"},
	{"u_m_y_paparazzi", "Paparazzi Young Male"},
	{"u_m_m_partytarget", "Party Target"},
	{"u_m_y_party_01", "Partygoer"},
	{"u_m_y_pogo_01", "Pogo the Monkey"},
	{"u_m_y_prisoner_01", "Prisoner"},
	{"u_m_y_proldriver_01", "Prologue Driver"},
	{"u_m_m_promourn_01", "Prologue Mourner Male"},
	{"u_m_m_prolsec_01", "Prologue Security"},
	{"u_m_y_rsranger_01", "Republican Space Ranger"},
	{"u_m_m_rivalpap", "Rival Paparazzo"},
	{"u_m_y_sbike", "Sports Biker"},
	{"u_m_m_spyactor", "Spy Actor"},
	{"u_m_y_staggrm_01", "Stag Party Groom"},
	{"u_m_y_tattoo_01", "Tattoo Artist"},
	{"u_m_o_tramp_01", "Tramp Old Male"},
	{"u_m_y_zombie_01", "Zombie"},
	{"u_m_y_danceburl_01", "Male Club Dancer (Burlesque)"},
	{"u_m_y_dancelthr_01", "Male Club Dancer (Leather)"},
	{"u_m_y_dancerave_01", "Male Club Dancer (Rave)"}
}
gtaStoryScenarioFemalePeds = {
	{"u_f_y_bikerchic", "Biker Chic Female"},
	{"u_f_m_corpse_01", "Corpse Female"},
	--{"u_f_m_casinocash_01", "Casino Cashier"},
	--{"u_f_m_casinoshop_01", "Casino shop owner"},
	--{"u_f_m_debbie_01", "Debbie (Agatha´s Secretary)"},
	--{"u_f_o_carol", "Carol"},
	--{"u_f_o_eileen", "Eileen"},
	--{"u_f_y_beth", "Beth"},
	--{"u_f_y_lauren", "Lauren"},
	--{"u_f_y_taylor", "Taylor"},
	{"u_f_y_corpse_01", "Corpse Young Female"},
	{"u_f_y_corpse_02", "Corpse Young Female 2"},
	{"u_f_y_hotposh_01", "Hot Posh Female"},
	{"u_f_y_comjane", "Jane"},
	{"u_f_y_jewelass_01", "Jeweller Assistant"},
	{"u_f_m_miranda", "Miranda"},
	{"u_f_y_mistress", "Mistress"},
	{"u_f_o_moviestar", "Movie Star Female"},
	{"u_f_y_poppymich", "Poppy Mitchell"},
	{"u_f_y_princess", "Princess"},
	{"u_f_o_prolhost_01", "Prologue Host Old Female"},
	{"u_f_m_promourn_01", "Prologue Mourner Female"},
	{"u_f_y_spyactress", "Spy Actress"},
	{"u_f_m_miranda_02", "Miranda 2"},
	{"u_f_y_poppymich_02", "Poppy Mitchell 2"},
	{"u_f_y_danceburl_01", "Female Club Dancer (Burlesque)"},
	{"u_f_y_dancelthr_01", "Female Club Dancer (Leather)"},
	{"u_f_y_dancerave_01", "Female Club Dancer (Rave)"}
}
gtaOtherPeds = {
	{"hc_driver", "Jewel Heist Driver"},
	{"hc_gunman", "Jewel Heist Gunman"},
	{"hc_hacker", "Jewel Heist Hacker"}
}
gtaAnimalPeds = {
	{"a_c_shepherd", "Australian Shepherd"},
	{"a_c_boar", "Boar"},
	{"a_c_cat_01", "Cat"},
	{"a_c_chimp", "Chimp"},
	{"a_c_chop", "Chop"},
	{"a_c_cormorant", "Cormorant"},
	{"a_c_cow", "Cow"},
	{"a_c_coyote", "Coyote"},
	{"a_c_crow", "Crow"},
	{"a_c_deer", "Deer"},
	{"a_c_dolphin", "Dolphin"},
	{"a_c_fish", "Fish"},
	{"a_c_sharkhammer", "Hammerhead Shark"},
	{"a_c_chickenhawk", "Hawk"},
	{"a_c_hen", "Hen"},
	{"a_c_humpback", "Humpback"},
	{"a_c_husky", "Husky"},
	{"a_c_killerwhale", "Killer Whale"},
	{"a_c_mtlion", "Mountain Lion"},
	{"a_c_pig", "Pig"},
	{"a_c_pigeon", "Pigeon"},
	{"a_c_poodle", "Poodle"},
	{"a_c_pug", "Pug"},
	{"a_c_rabbit_01", "Rabbit"},
	{"a_c_rat", "Rat"},
	{"a_c_retriever", "Retriever"},
	{"a_c_rhesus", "Rhesus"},
	{"a_c_rottweiler", "Rottweiler"},
	{"a_c_seagull", "Seagull"},
	{"a_c_stingray", "Stingray"},
	{"a_c_sharktiger", "Tiger Shark"},
	{"a_c_westy", "Westie"}
}

_skinMenuPool = NativeUI.CreatePool()
skinMenu = NativeUI.CreateMenu("CLOTHES STORE", "~b~Change your look here!")

modelNamePreview = UIMenuColouredItem.New("", "Current model", {0, 0, 0}, {0, 128, 128})
modelNamePreview:SetLeftBadge(BadgeStyle.Clothes)
skinMenu:AddItem(modelNamePreview)

changeModelMenu = _skinMenuPool:AddSubMenu(skinMenu, "[ Change Model ]")

_skinMenuPool:Add(skinMenu)

--//////////////////////////////////////////////////////////////////////////////
subMenu_MainPlayersPeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Main Players")
function AddMainPlayersMenu(menu)
	for _,pedModel in ipairs(gtaMainPlayersPeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_MainPlayersPeds:AddItem(newItem)
	end
	
	subMenu_MainPlayersPeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaMainPlayersPeds[index][1]
		WildPlayer.Skin.Name = gtaMainPlayersPeds[index][2]
		LoadPlayerSkin()
	end
end
AddMainPlayersMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_MalePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Ambient Male Peds")
function AddMalePedsMenu(menu)
	for _,pedModel in ipairs(gtaAmbientMalePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_MalePeds:AddItem(newItem)
	end
	
	subMenu_MalePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaAmbientMalePeds[index][1]
		WildPlayer.Skin.Name = gtaAmbientMalePeds[index][2]
		LoadPlayerSkin()
	end
end
AddMalePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_FemalePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Ambient Female Peds")
function AddFemalePedsMenu(menu)
	for _,pedModel in ipairs(gtaAmbientFemalePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_FemalePeds:AddItem(newItem)
	end
	
	subMenu_FemalePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaAmbientFemalePeds[index][1]
		WildPlayer.Skin.Name = gtaAmbientFemalePeds[index][2]
		LoadPlayerSkin()
	end
end
AddFemalePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_GangMalePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Gang Male Peds")
function AddGangMalePedsMenu(menu)
	for _,pedModel in ipairs(gtaGangMalePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_GangMalePeds:AddItem(newItem)
	end
	
	subMenu_GangMalePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaGangMalePeds[index][1]
		WildPlayer.Skin.Name = gtaGangMalePeds[index][2]
		LoadPlayerSkin()
	end
end
AddGangMalePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_GangFemalePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Gang Female Peds")
function AddGangFemalePedsMenu(menu)
	for _,pedModel in ipairs(gtaGangFemalePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_GangFemalePeds:AddItem(newItem)
	end
	
	subMenu_GangFemalePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaGangFemalePeds[index][1]
		WildPlayer.Skin.Name = gtaGangFemalePeds[index][2]
		LoadPlayerSkin()
	end
end
AddGangFemalePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_CutscenePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Cutscene Peds")
function AddCutscenePedsMenu(menu)
	for _,pedModel in ipairs(gtaCutscenePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_CutscenePeds:AddItem(newItem)
	end
	
	subMenu_CutscenePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaCutscenePeds[index][1]
		WildPlayer.Skin.Name = gtaCutscenePeds[index][2]
		LoadPlayerSkin()
	end
end
AddCutscenePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_StoryPeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Story Peds")
function AddStoryPedsMenu(menu)
	for _,pedModel in ipairs(gtaStoryPeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_StoryPeds:AddItem(newItem)
	end
	
	subMenu_StoryPeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaStoryPeds[index][1]
		WildPlayer.Skin.Name = gtaStoryPeds[index][2]
		LoadPlayerSkin()
	end
end
AddStoryPedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_MultiplayerPeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Multiplayer Peds")
function AddMultiplayerPedsMenu(menu)
	for _,pedModel in ipairs(gtaMultiplayerPeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_MultiplayerPeds:AddItem(newItem)
	end
	
	subMenu_MultiplayerPeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaMultiplayerPeds[index][1]
		WildPlayer.Skin.Name = gtaMultiplayerPeds[index][2]
		LoadPlayerSkin()
	end
end
AddMultiplayerPedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_ScenarioMalePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Scenario Male Peds")
function AddScenarioMalePedsMenu(menu)
	for _,pedModel in ipairs(gtaScenarioMalePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_ScenarioMalePeds:AddItem(newItem)
	end
	
	subMenu_ScenarioMalePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaScenarioMalePeds[index][1]
		WildPlayer.Skin.Name = gtaScenarioMalePeds[index][2]
		LoadPlayerSkin()
	end
end
AddScenarioMalePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_ScenarioFemalePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Scenario Female Peds")
function AddScenarioFemalePedsMenu(menu)
	for _,pedModel in ipairs(gtaScenarioFemaleMalePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_ScenarioFemalePeds:AddItem(newItem)
	end
	
	subMenu_ScenarioFemalePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaScenarioFemaleMalePeds[index][1]
		WildPlayer.Skin.Name = gtaScenarioFemaleMalePeds[index][2]
		LoadPlayerSkin()
	end
end
AddScenarioFemalePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_StoryScenarioMalePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Story Scenario Male Peds")
function AddStoryScenarioMalePedsMenu(menu)
	for _,pedModel in ipairs(gtaStoryScenarioMalePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_StoryScenarioMalePeds:AddItem(newItem)
	end
	
	subMenu_StoryScenarioMalePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaStoryScenarioMalePeds[index][1]
		WildPlayer.Skin.Name = gtaStoryScenarioMalePeds[index][2]
		LoadPlayerSkin()
	end
end
AddStoryScenarioMalePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_StoryScenarioFemalePeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Story Scenario Female Peds")
function AddStoryScenarioFemalePedsMenu(menu)
	for _,pedModel in ipairs(gtaStoryScenarioFemalePeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_StoryScenarioFemalePeds:AddItem(newItem)
	end
	
	subMenu_StoryScenarioFemalePeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaStoryScenarioFemalePeds[index][1]
		WildPlayer.Skin.Name = gtaStoryScenarioFemalePeds[index][2]
		LoadPlayerSkin()
	end
end
AddStoryScenarioFemalePedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_OtherPeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Other Peds")
function AddOtherPedsMenu(menu)
	for _,pedModel in ipairs(gtaOtherPeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_OtherPeds:AddItem(newItem)
	end
	
	subMenu_OtherPeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaOtherPeds[index][1]
		WildPlayer.Skin.Name = gtaOtherPeds[index][2]
		LoadPlayerSkin()
	end
end
AddOtherPedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_AnimalPeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Animal Peds")
function AddAnimalPedsMenu(menu)
	for _,pedModel in ipairs(gtaAnimalPeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_AnimalPeds:AddItem(newItem)
	end
	
	subMenu_AnimalPeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = gtaAnimalPeds[index][1]
		WildPlayer.Skin.Name = gtaAnimalPeds[index][2]
		LoadPlayerSkin()
	end
end
AddAnimalPedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_CustomPeds = _skinMenuPool:AddSubMenu(changeModelMenu, "» Custom Peds")
function AddCustomPedsMenu(menu)
	for _,pedModel in ipairs(customPeds) do
		local newItem = NativeUI.CreateItem(pedModel[2], pedModel[1])
		subMenu_CustomPeds:AddItem(newItem)
	end
	
	subMenu_CustomPeds.OnItemSelect = function(sender, item, index)
		WildPlayer.Skin.Model = customPeds[index][1]
		WildPlayer.Skin.Name = customPeds[index][2]
		LoadPlayerSkin()
	end
end
AddCustomPedsMenu(changeModelMenu)
--//////////////////////////////////////////////////////////////////////////////


--local amount = {}
--for i = 1, 4 do amount[i] = i end
--local uiHeadSlider = UIMenuSliderItem.New("Head", amount, 1, false)
--skinMenu:AddItem(uiHeadSlider)

changeHeadMenu = _skinMenuPool:AddSubMenu(skinMenu, "Head/Face")
changeBeardMaskMenu = _skinMenuPool:AddSubMenu(skinMenu, "Beard/Mask", nil, false, false)
changeHairMaskMenu = _skinMenuPool:AddSubMenu(skinMenu, "Hair/Mask")
changeUpperBodyMenu = _skinMenuPool:AddSubMenu(skinMenu, "Upper Body")
changeLowerBodyMenu = _skinMenuPool:AddSubMenu(skinMenu, "Lower Body")


local uiRandomProps = NativeUI.CreateItem("Randomize Props", "Will not save to database!")
skinMenu:AddItem(uiRandomProps)

local uiRandom = NativeUI.CreateItem("Randomize Skin", "Will not save to database!")
skinMenu:AddItem(uiRandom)


function handleSkinListChange(menu)
    menu.OnListChange = function(sender, item, index)
		--ShowNotification(item)	
        if item == uiWeaponList then
            weaponSelection = item:IndexToItem(index)
			--ShowNotification("New weapon will be: " .. weaponSelection)
        end		
		
        if item == uiModelList then
            modelSelection = item:IndexToItem(index)
			--ShowNotification("New model will be: " .. modelSelection)	
		end		
    end
end

function handleSkinClicks(menu)
    menu.OnItemSelect = function(sender, item, index)
	local playerPed = GetPlayerPed(-1)
		--ShowNotification("Clicked:" .. tostring(item))
		
		if item == uiRandom then
			SetPedRandomComponentVariation(playerPed, false)
		end	
		
		if item == uiRandomProps then
			SetPedRandomProps(playerPed)
			
			if math.random(100) < 20 then
				ClearAllPedProps(playerPed)
			end
		end			
	end
end


handleSkinListChange(skinMenu)
handleSkinClicks(skinMenu)
_skinMenuPool:RefreshIndex()

local headTextureMenu = nil

function RefreshSkinComponentsMenu()

	-- Head Component Variation

	changeHeadMenu:Clear()
	
	local headVariations = tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 0))
	
	changeHeadMenu.OnItemSelect = function(sender, item, index)
		for i = 1, headVariations do
			changeHeadMenu.Items[i]:SetRightBadge(BadgeStyle.None)
		end
		
		item:SetRightBadge(BadgeStyle.Tick)
		
		if bIsSkinEditorOpen then
			local newHeadVar = tonumber(index)-1
			if WildPlayer.Skin.HeadVar ~= newHeadVar then
				WildPlayer.Skin.HeadVar = newHeadVar
				WildPlayer.Skin.HeadTexture = 0
			else
				-- Just try a new texture instead
				WildPlayer.Skin.HeadTexture = WildPlayer.Skin.HeadTexture+1

				--if not IsPedComponentVariationValid(GetPlayerPed(-1), 0, WildPlayer.Skin.HeadVar, WildPlayer.Skin.HeadTexture) then

				if WildPlayer.Skin.HeadTexture > GetNumberOfPedTextureVariations(GetPlayerPed(-1), 0, WildPlayer.Skin.HeadVar)-1 then
					WildPlayer.Skin.HeadTexture = 0
				end
			end
		end
		
		LoadPlayerSkinComponents()
	end	
	
	
	if headVariations == 0 then
		changeHeadMenu.ParentItem:RightLabel("( 0 )", {R = 0, G = 128, B = 255, A = 128},  {R = 0, G = 60, B = 128, A = 128})
	else
		changeHeadMenu.ParentItem:RightLabel("( "..tonumber(headVariations).." )", {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})	
		
		local itemIndexToSelect = 1
		
		for i = 1, headVariations do
			local newItem = NativeUI.CreateItem("Variation "..i, "...")
			changeHeadMenu:AddItem( newItem )

			if WildPlayer.Skin.HeadVar+1 == i then
				itemIndexToSelect = i
			end
			
		end

		changeHeadMenu:CurrentSelection(itemIndexToSelect-1)
		changeHeadMenu:SelectItem()	
	end
	

	-- Beard/Mask Component Variation

	changeBeardMaskMenu:Clear()
	
	local beardMaskVariations = tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 1))	
	
	changeBeardMaskMenu.OnItemSelect = function(sender, item, index)
		for i = 1, beardMaskVariations do
			changeBeardMaskMenu.Items[i]:SetRightBadge(BadgeStyle.None)
		end
		
		item:SetRightBadge(BadgeStyle.Tick)
		
		if bIsSkinEditorOpen then
			local newBeardMaskVar = tonumber(index)-1
			if WildPlayer.Skin.BeardMaskVar ~= newBeardMaskVar then
				WildPlayer.Skin.BeardMaskVar = newBeardMaskVar
				WildPlayer.Skin.BeardMaskTexture = 0
			else
				-- Just try a new texture instead
				WildPlayer.Skin.BeardMaskTexture = WildPlayer.Skin.BeardMaskTexture+1

				--if not IsPedComponentVariationValid(GetPlayerPed(-1), 0, WildPlayer.Skin.HeadVar, WildPlayer.Skin.HeadTexture) then

				if WildPlayer.Skin.BeardMaskTexture > GetNumberOfPedTextureVariations(GetPlayerPed(-1), 1, WildPlayer.Skin.BeardMaskVar)-1 then
					WildPlayer.Skin.BeardMaskTexture = 0
				end
			end
		end
		
		LoadPlayerSkinComponents()
	end	
	
	if beardMaskVariations == 0 then
		changeBeardMaskMenu.ParentItem:RightLabel("( 0 )", {R = 0, G = 128, B = 255, A = 128},  {R = 0, G = 60, B = 128, A = 128})
	else
		changeBeardMaskMenu.ParentItem:RightLabel("( "..tonumber(beardMaskVariations).." )", {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})
		
		local itemIndexToSelect = 1
		
		for i = 1, beardMaskVariations do
			local newItem = NativeUI.CreateItem("Variation "..i, "...")
			changeBeardMaskMenu:AddItem( newItem )

			if WildPlayer.Skin.BeardMaskVar+1 == i then
				itemIndexToSelect = i
			end
			
		end

		changeBeardMaskMenu:CurrentSelection(itemIndexToSelect-1)
		changeBeardMaskMenu:SelectItem()				
	end		
	
	
	-- Hair/Hat Component Variation

	changeHairMaskMenu:Clear()
	
	local hairHatVariations = tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 2))
	
	changeHairMaskMenu.OnItemSelect = function(sender, item, index)
		for i = 1, hairHatVariations do
			changeHairMaskMenu.Items[i]:SetRightBadge(BadgeStyle.None)
		end
		
		item:SetRightBadge(BadgeStyle.Tick)
		
		if bIsSkinEditorOpen then
			local newHairHatVar = tonumber(index)-1
			if WildPlayer.Skin.HairHatVar ~= newHairHatVar then
				WildPlayer.Skin.HairHatVar = newHairHatVar
				WildPlayer.Skin.HairHatTexture = 0
			else
				-- Just try a new texture instead
				WildPlayer.Skin.HairHatTexture = WildPlayer.Skin.HairHatTexture+1

				--if not IsPedComponentVariationValid(GetPlayerPed(-1), 0, WildPlayer.Skin.HeadVar, WildPlayer.Skin.HeadTexture) then

				if WildPlayer.Skin.HairHatTexture > GetNumberOfPedTextureVariations(GetPlayerPed(-1), 2, WildPlayer.Skin.HairHatVar)-1 then
					WildPlayer.Skin.HairHatTexture = 0
				end
			end
		end
		
		LoadPlayerSkinComponents()
	end	
	
	
	if hairHatVariations == 0 then
		changeHairMaskMenu.ParentItem:RightLabel("( 0 )", {R = 0, G = 128, B = 255, A = 128},  {R = 0, G = 60, B = 128, A = 128})
	else
		changeHairMaskMenu.ParentItem:RightLabel("( "..tonumber(hairHatVariations).." )", {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})
		
		local itemIndexToSelect = 1
		
		for i = 1, hairHatVariations do
			local newItem = NativeUI.CreateItem("Variation "..i, "...")
			changeHairMaskMenu:AddItem( newItem )

			if WildPlayer.Skin.HairHatTexture+1 == i then
				itemIndexToSelect = i
			end
			
		end

		changeHairMaskMenu:CurrentSelection(itemIndexToSelect-1)
		changeHairMaskMenu:SelectItem()		
	end
	
	-- Upper Body Component Variation

	changeUpperBodyMenu:Clear()
	
	local upperBodyVariations = tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 3))
	
	changeUpperBodyMenu.OnItemSelect = function(sender, item, index)
		for i = 1, upperBodyVariations do
			changeUpperBodyMenu.Items[i]:SetRightBadge(BadgeStyle.None)
		end
		
		item:SetRightBadge(BadgeStyle.Tick)
		
		if bIsSkinEditorOpen then
			local newUpperBodyVar = tonumber(index)-1
			if WildPlayer.Skin.UpperBodyVar ~= newUpperBodyVar then
				WildPlayer.Skin.UpperBodyVar = newUpperBodyVar
				WildPlayer.Skin.UpperBodyTexture = 0
			else
				-- Just try a new texture instead
				WildPlayer.Skin.UpperBodyTexture = WildPlayer.Skin.UpperBodyTexture+1
			
				if WildPlayer.Skin.UpperBodyTexture > GetNumberOfPedTextureVariations(GetPlayerPed(-1), 3, WildPlayer.Skin.UpperBodyVar)-1 then
					WildPlayer.Skin.UpperBodyTexture = 0
				end
			end
		end
		
		LoadPlayerSkinComponents()
	end	
	
	if upperBodyVariations == 0 then
		changeUpperBodyMenu.ParentItem:RightLabel("( 0 )", {R = 0, G = 128, B = 255, A = 128},  {R = 0, G = 60, B = 128, A = 128})
	else
		changeUpperBodyMenu.ParentItem:RightLabel("( "..tonumber(upperBodyVariations).." )", {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})
		
		local itemIndexToSelect = 1
		
		for i = 1, upperBodyVariations do
			local newItem = NativeUI.CreateItem("Variation "..i, "...")
			changeUpperBodyMenu:AddItem( newItem )

			if WildPlayer.Skin.UpperBodyVar+1 == i then
				itemIndexToSelect = i
			end
			
		end

		changeUpperBodyMenu:CurrentSelection(itemIndexToSelect-1)
		changeUpperBodyMenu:SelectItem()	
	end
	
	
	-- Lower Body Component Variation

	changeLowerBodyMenu:Clear()
	
	local lowerBodyVariations = tonumber(GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 4))
	
	changeLowerBodyMenu.OnItemSelect = function(sender, item, index)
		for i = 1, lowerBodyVariations do
			changeLowerBodyMenu.Items[i]:SetRightBadge(BadgeStyle.None)
		end
		
		item:SetRightBadge(BadgeStyle.Tick)
		
		if bIsSkinEditorOpen then
			local newLowerBodyVar = tonumber(index)-1
			if WildPlayer.Skin.LowerBodyVar ~= newLowerBodyVar then
				WildPlayer.Skin.LowerBodyVar = newLowerBodyVar
				WildPlayer.Skin.LowerBodyTexture = 0
			else
				-- Just try a new texture instead
				WildPlayer.Skin.LowerBodyTexture = WildPlayer.Skin.LowerBodyTexture+1
			
				if WildPlayer.Skin.LowerBodyTexture > GetNumberOfPedTextureVariations(GetPlayerPed(-1), 4, WildPlayer.Skin.LowerBodyVar)-1 then
					WildPlayer.Skin.LowerBodyTexture = 0
				end
			end
		end
		
		LoadPlayerSkinComponents()
	end	
	
	if lowerBodyVariations == 0 then
		changeLowerBodyMenu.ParentItem:RightLabel("( 0 )", {R = 0, G = 128, B = 255, A = 128},  {R = 0, G = 60, B = 128, A = 128})
	else
		changeLowerBodyMenu.ParentItem:RightLabel("( "..tonumber(lowerBodyVariations).." )", {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})	
		
		local itemIndexToSelect = 1
		
		for i = 1, lowerBodyVariations do
			local newItem = NativeUI.CreateItem("Variation "..i, "...")
			changeLowerBodyMenu:AddItem( newItem )

			if WildPlayer.Skin.LowerBodyVar+1 == i then
				itemIndexToSelect = i
			end
			
		end

		changeLowerBodyMenu:CurrentSelection(itemIndexToSelect-1)
		changeLowerBodyMenu:SelectItem()
	end
	
end
print("WildPlayer->" ..tostring(WildPlayer))

AddEventHandler("playerDataIsReady", function()
	print("WildPlayer->" ..tostring(WildPlayer))
    LoadPlayerSkin()
end)

function StartSwitch()
	Citizen.CreateThread(function()
		local switchToCoords = vector3(129.063, 6616.838, 31.827)
		local switchToModel = GetHashKey("u_m_m_filmdirector")
		local currentPos = GetEntityCoords(PlayerPedId())
		local switchType = GetIdealPlayerSwitchType(currentPos.x, currentPos.y, currentPos.z, switchToCoords.x, switchToCoords.y, switchToCoords.z)
		local switchFlag = 1024

		if switchType == 3 then -- fix for SWITCH_TYPE_SHORT
			switchType = 2
			if GetDistanceBetweenCoords(switchToCoords, currentPos, false) < 40.0 then
				return
			end
		end

		while not HasModelLoaded(switchToModel) do
			RequestModel(switchToModel)
			Citizen.Wait(0)
		end

		local switchToPed = CreatePed(25, switchToModel, switchToCoords.x, switchToCoords.y, switchToCoords.z - 1, 0, 0.0, 0, false)
		SetEntityVisible(switchToPed, false, 0)
		SetEntityInvincible(switchToPed, true)
		SetEntityAsMissionEntity(switchToPed, true, 0)
		ClearPedTasksImmediately(switchToPed)
		if not IsPedInjured(PlayerPedId()) then
			SetPedDesiredHeading(switchToPed, GetEntityHeading(PlayerPedId()))
		end
		SetEntityCollision(switchToPed, false, 0)
		SetEntityVisible(switchToPed, false, 0)
		SetModelAsNoLongerNeeded(switchToModel)

		StartPlayerSwitch(PlayerPedId(), switchToPed, switchFlag, switchType)

		while GetPlayerSwitchState() ~= 8 do
			Citizen.Wait(0)
		end

		SetFocusEntity(switchToPed)
		SetEntityCoords(PlayerPedId(), switchToCoords.x, switchToCoords.y, switchToCoords.z, 0.0, 0.0, 0.0, false)
		DeletePed(switchToPed)
		DeleteEntity(switchToPed)
	end)
end

function LoadPlayerSkin(bSetupAsCop)
	
	if bIsSkinEditorOpen then
		--Reset components so we don't use the left-overs from the previous skin
		-- Also, textures are set to -1 here because the menu will increment it by one. Don't set it as -1 in global.lua!
		WildPlayer.Skin.HeadVar = 0
		WildPlayer.Skin.HeadTexture = -1
		WildPlayer.Skin.BeardMaskVar = 0
		WildPlayer.Skin.BeardMaskTexture = -1	
		WildPlayer.Skin.HairHatVar = 0
		WildPlayer.Skin.HairHatTexture = -1		
		WildPlayer.Skin.UpperBodyVar = 0
		WildPlayer.Skin.UpperBodyTexture = -1
		WildPlayer.Skin.LowerBodyVar = 0
		WildPlayer.Skin.LowerBodyTexture = -1
	end
	--ShowNotification(WildPlayer.Skin.Name) 
	
	
	local newModel = LoadModel(WildPlayer.Skin.Model)
	
	SetPlayerModel(PlayerId(), WildPlayer.Skin.Model) --After this point, GetPlayerPed(-1) returns a new ped
	

	
	ReleaseModel(newModel)
	
	SetPedDefaultComponentVariation(PlayerPedId())
	
	--SetPedRandomComponentVariation(GetPlayerPed(-1), false)
	--SetPedRandomProps(GetPlayerPed(-1))
	
	modelNamePreview:Text(WildPlayer.Skin.Name)
	RefreshSkinComponentsMenu()
	
	if bIsSkinEditorOpen then TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_HANG_OUT_STREET", 0, true) end	
	
	-- For some reason, when change ped we lose our weapons!
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(1000)
	
	if ESX.PlayerData.job.name ~= "police" then
		TriggerEvent('esx:restoreLoadout')
	else
		if bSetupAsCop == nil then
			SetupPlayerCop()
		end
	end
	
	SavePlayerSkin()
	
--StartSwitch()
	--LoadPlayerSkinComponents()
end

function LoadPlayerSkinComponents()
	SetPedComponentVariation(GetPlayerPed(-1), 0, WildPlayer.Skin.HeadVar, WildPlayer.Skin.HeadTexture, GetPedPaletteVariation(GetPlayerPed(-1), 0))
	SetPedComponentVariation(GetPlayerPed(-1), 1, WildPlayer.Skin.BeardMaskVar, WildPlayer.Skin.BeardMaskTexture, GetPedPaletteVariation(GetPlayerPed(-1), 1))
	SetPedComponentVariation(GetPlayerPed(-1), 2, WildPlayer.Skin.HairHatVar, WildPlayer.Skin.HairHatTexture, GetPedPaletteVariation(GetPlayerPed(-1), 2))
	SetPedComponentVariation(GetPlayerPed(-1), 3, WildPlayer.Skin.UpperBodyVar, WildPlayer.Skin.UpperBodyTexture, GetPedPaletteVariation(GetPlayerPed(-1), 3))
	SetPedComponentVariation(GetPlayerPed(-1), 4, WildPlayer.Skin.LowerBodyVar, WildPlayer.Skin.LowerBodyTexture, GetPedPaletteVariation(GetPlayerPed(-1), 4))
	
-- **0**: Head
-- **1**: BeardMask
-- **2**: HairHat
-- **3**: UpperBody
-- **4**: LowerBody
-- **5**: Parachute
-- **6**: Shoes
-- **7**: Accessory
-- **8**: Undershirt
-- **9**: Kevlar
-- **10**: Badge
-- **11**: Torso

	--SetPedComponentVariation(GetPlayerPed(-1), 5, WildPlayer.Skin.ParachuteVar, WildPlayer.Skin.ParachuteTexture, GetPedPaletteVariation(GetPlayerPed(-1), 5))
	--SetPedComponentVariation(GetPlayerPed(-1), 6, WildPlayer.Skin.ShoesVar, WildPlayer.Skin.ShoesTexture, GetPedPaletteVariation(GetPlayerPed(-1), 6))
	--SetPedComponentVariation(GetPlayerPed(-1), 7, WildPlayer.Skin.AccessoryVar, WildPlayer.Skin.AccessoryTexture, GetPedPaletteVariation(GetPlayerPed(-1), 7))
	--SetPedComponentVariation(GetPlayerPed(-1), 8, WildPlayer.Skin.UndershirtVar, WildPlayer.Skin.UndershirtTexture, GetPedPaletteVariation(GetPlayerPed(-1), 8))
	--SetPedComponentVariation(GetPlayerPed(-1), 9, WildPlayer.Skin.KevlarVar, WildPlayer.Skin.KevlarTexture, GetPedPaletteVariation(GetPlayerPed(-1), 9))
	--SetPedComponentVariation(GetPlayerPed(-1), 10, WildPlayer.Skin.BadgeVar, WildPlayer.Skin.BadgeTexture, GetPedPaletteVariation(GetPlayerPed(-1), 10))
	--SetPedComponentVariation(GetPlayerPed(-1), 11, WildPlayer.Skin.TorsoVar, WildPlayer.Skin.TorsoTexture, GetPedPaletteVariation(GetPlayerPed(-1), 11))
end

function SavePlayerSkin()
	TriggerServerEvent('wild-trainer:saveWildPlayerData', json.encode(WildPlayer))
end




clothesShopLocations = {
	{ ['x'] = -0.93,  ['y'] = 6516.93,  ['z'] = 31.87 },
	{ ['x'] = 1686.82,  ['y'] = 4820.49,  ['z'] = 42.06 },
	{ ['x'] = -1095.76,  ['y'] = 2706.22,  ['z'] = 19.11 },
	{ ['x'] = 618.17,  ['y'] = 2751.07,  ['z'] =  42.09} ,
	{ ['x'] = -3168.51,  ['y'] = 1056.06,  ['z'] =  20.86 },
	{ ['x'] = -1455.7,  ['y'] = -232.44,  ['z'] = 49.79 },
	{ ['x'] = -716.33,  ['y'] = -156.39,  ['z'] = 37.41 },
	{ ['x'] = -156.47,  ['y'] = -305.61,  ['z'] = 39.73 },
	{ ['x'] = 126.92,  ['y'] = -211.38,  ['z'] = 54.56 },
	{ ['x'] = -1201.25,  ['y'] = -777.67,  ['z'] =17.34 },
	{ ['x'] = -817.58,  ['y'] = -1079.29,  ['z'] =11.13 },
	{ ['x'] = 418.16,  ['y'] = -807.59,  ['z'] = 29.4 },
	{ ['x'] = 82.89,  ['y'] = -1391.66,  ['z'] = 29.41 },
	{ ['x'] = 1197.91,  ['y'] = 2702.9,  ['z'] = 38.16 } 
}

clothesShopInteriorIDs = {
	[179713] = true,
	[165633] = true,
	[166145] = true,
	[235265] = true,
	[140801] = true,
	[137217] = true,
	[169217] = true,
	[171265] = true,
	[198145] = true,
	[176129] = true,
	[175361] = true,
	[201473] = true,
	[183553] = true,
	[202497] = true
}

function AddBlips()
	Citizen.CreateThread(function()
		for _, clothesShopLocation in pairs(clothesShopLocations) do
		  clothesShopLocation.blip = AddBlipForCoord(clothesShopLocation.x, clothesShopLocation.y, clothesShopLocation.z)
		  SetBlipSprite(clothesShopLocation.blip, 73)
		  SetBlipDisplay(clothesShopLocation.blip, 4)
		  SetBlipScale(clothesShopLocation.blip, 0.9)
		  SetBlipColour(clothesShopLocation.blip, 12)
		  SetBlipAsShortRange(clothesShopLocation.blip, true)
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString("Clothes Store")
		  EndTextCommandSetBlipName(clothesShopLocation.blip)
		end
	end)
end

AddBlips()




-- Main logic/magic loop
Citizen.CreateThread(function()
    local radius = 1.0  
    local waitForPlayerToLeave = false

	while true do Citizen.Wait(1)
	
		
		--if inside clothes shop
		if GetInteriorFromEntity(GetPlayerPed(-1)) ~= 0 and clothesShopInteriorIDs[GetInteriorFromEntity(GetPlayerPed(-1))] then
			DisplayHelpText("Press ~INPUT_CONTEXT~ To Change Skin")
			
			_skinMenuPool:ProcessMenus()		
			
			if not _skinMenuPool:IsAnyMenuOpen() and bIsSkinEditorOpen or IsPedDeadOrDying(GetPlayerPed(-1),1) then
				bIsSkinEditorOpen = false
				
				ClearPedTasksImmediately(GetPlayerPed(-1))	
				SetPlayerControl(PlayerId(), true)
				SetCamActive(skinCam, false)
				RenderScriptCams(false, 1, 600, 300, 300)
				
				SavePlayerSkin()
			end
			
			if IsControlPressed(1,51) then
				bIsSkinEditorOpen = true;
				skinMenu:Visible( true )
				--SetPlayerControl(PlayerId(), false)
				

				
				local playerPed = GetPlayerPed(-1)
				local coords = GetEntityCoords(playerPed)
				
				--SetEntityCoords(playerPed, coords.x, coords.y, coords.z-0.8)
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
				
				
				skinCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
				SetCamActive(skinCam, true)
				
				local playerOffset = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, 0.0)
				SetCamCoord(skinCam, playerOffset.x, playerOffset.y, playerOffset.z+0.5)
				
				RenderScriptCams(true, true, 500, true, true)
				local heading = GetEntityHeading(playerPed)
				--SetEntityHeading(skinCam, heading+180)
				SetCamRot(skinCam, -10.0, 0.0, heading+180, true)
				--SetEntityHeading(playerPed, 90.0)				
			end			
		end
	end
end)



-- Restore look upon respawn
AddEventHandler('playerSpawned', function(spawn)
    LoadPlayerSkin()
end)


