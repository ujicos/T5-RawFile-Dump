
main()
{
	self setModel("c_usa_pent_zombie_officeworker_body");
	self.headModel = codescripts\character::randomElement(xmodelalias\c_ger_honorguard_zomb_headalias::main());
	self attach(self.headModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
	self.torsoDmg1 = "c_zom_pent_worker_body_g_upclean";
	self.torsoDmg2 = "c_zom_pent_worker_body_g_rarmoff";
	self.torsoDmg3 = "c_zom_pent_worker_body_g_larmoff";
	self.torsoDmg5 = "char_ger_honorgd_body1_g_behead";
	self.legDmg1 = "c_zom_pent_worker_body_g_lowclean";
	self.legDmg2 = "c_zom_pent_worker_body_g_rlegoff";
	self.legDmg3 = "c_zom_pent_worker_body_g_llegoff";
	self.legDmg4 = "c_zom_pent_worker_body_g_legsoff";
	self.gibSpawn1 = "char_ger_honorgd_body1_g_rarmspawn";
	self.gibSpawnTag1 = "J_Elbow_RI";
	self.gibSpawn2 = "char_ger_honorgd_body1_g_larmspawn";
	self.gibSpawnTag2 = "J_Elbow_LE";
	self.gibSpawn3 = "char_ger_honorgd_body1_g_rlegspawn";
	self.gibSpawnTag3 = "J_Knee_RI";
	self.gibSpawn4 = "char_ger_honorgd_body1_g_llegspawn";
	self.gibSpawnTag4 = "J_Knee_LE";
}
precache()
{
	precacheModel("c_usa_pent_zombie_officeworker_body");
	codescripts\character::precacheModelArray(xmodelalias\c_ger_honorguard_zomb_headalias::main());
	precacheModel("c_zom_pent_worker_body_g_upclean");
	precacheModel("c_zom_pent_worker_body_g_rarmoff");
	precacheModel("c_zom_pent_worker_body_g_larmoff");
	precacheModel("char_ger_honorgd_body1_g_behead");
	precacheModel("c_zom_pent_worker_body_g_lowclean");
	precacheModel("c_zom_pent_worker_body_g_rlegoff");
	precacheModel("c_zom_pent_worker_body_g_llegoff");
	precacheModel("c_zom_pent_worker_body_g_legsoff");
	precacheModel("char_ger_honorgd_body1_g_rarmspawn");
	precacheModel("char_ger_honorgd_body1_g_larmspawn");
	precacheModel("char_ger_honorgd_body1_g_rlegspawn");
	precacheModel("char_ger_honorgd_body1_g_llegspawn");
	precacheModel("c_zom_pent_worker_body_g_upclean");
	precacheModel("c_zom_pent_worker_body_g_rarmoff");
	precacheModel("c_zom_pent_worker_body_g_larmoff");
	precacheModel("char_ger_honorgd_body1_g_behead");
	precacheModel("c_zom_pent_worker_body_g_lowclean");
	precacheModel("c_zom_pent_worker_body_g_rlegoff");
	precacheModel("c_zom_pent_worker_body_g_llegoff");
	precacheModel("c_zom_pent_worker_body_g_legsoff");
	precacheModel("char_ger_honorgd_body1_g_rarmspawn");
	precacheModel("char_ger_honorgd_body1_g_larmspawn");
	precacheModel("char_ger_honorgd_body1_g_rlegspawn");
	precacheModel("char_ger_honorgd_body1_g_llegspawn");
}  
