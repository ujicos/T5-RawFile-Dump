
main()
{
	codescripts\character::setModelFromArray(xmodelalias\c_ger_honorguard_zomb_bodyalias_zt::main());
	self.headModel = codescripts\character::randomElement(xmodelalias\c_ger_honorguard_zomb_headalias_zt::main());
	self attach(self.headModel, "", true);
	self.voice = "german";
	self.skeleton = "base";
	self.torsoDmg1 = "char_ger_honorgd_body1_g_upclean";
	self.torsoDmg2 = codescripts\character::randomElement(xmodelalias\char_ger_hnrgrd_body1_g_rarmoffalias::main());
	self.torsoDmg3 = codescripts\character::randomElement(xmodelalias\char_ger_hnrgrd_body1_g_larmoffalias::main());
	self.torsoDmg4 = codescripts\character::randomElement(xmodelalias\char_ger_hnrgrd_body1_g_torsoalias::main());
	self.torsoDmg5 = "c_zt_honorguard_body1_g_behead";
	self.legDmg1 = "char_ger_honorgd_body1_g_lowclean";
	self.legDmg2 = codescripts\character::randomElement(xmodelalias\char_ger_hnrgrd_body1_g_rlegoffalias::main());
	self.legDmg3 = codescripts\character::randomElement(xmodelalias\char_ger_hnrgrd_body1_g_llegoffalias::main());
	self.legDmg4 = codescripts\character::randomElement(xmodelalias\char_ger_hnrgrd_body1_g_legsoffalias::main());
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
	codescripts\character::precacheModelArray(xmodelalias\c_ger_honorguard_zomb_bodyalias_zt::main());
	codescripts\character::precacheModelArray(xmodelalias\c_ger_honorguard_zomb_headalias_zt::main());
	precacheModel("char_ger_honorgd_body1_g_upclean");
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_rarmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_larmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_torsoalias::main());
	precacheModel("c_zt_honorguard_body1_g_behead");
	precacheModel("char_ger_honorgd_body1_g_lowclean");
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_rlegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_llegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_legsoffalias::main());
	precacheModel("char_ger_honorgd_body1_g_rarmspawn");
	precacheModel("char_ger_honorgd_body1_g_larmspawn");
	precacheModel("char_ger_honorgd_body1_g_rlegspawn");
	precacheModel("char_ger_honorgd_body1_g_llegspawn");
	precacheModel("char_ger_honorgd_body1_g_upclean");
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_rarmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_larmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_torsoalias::main());
	precacheModel("c_zt_honorguard_body1_g_behead");
	precacheModel("char_ger_honorgd_body1_g_lowclean");
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_rlegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_llegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_ger_hnrgrd_body1_g_legsoffalias::main());
	precacheModel("char_ger_honorgd_body1_g_rarmspawn");
	precacheModel("char_ger_honorgd_body1_g_larmspawn");
	precacheModel("char_ger_honorgd_body1_g_rlegspawn");
	precacheModel("char_ger_honorgd_body1_g_llegspawn");
} 
