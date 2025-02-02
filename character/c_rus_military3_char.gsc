
main()
{
	self setModel("c_rus_military_body3_char");
	self.headModel = "c_rus_military_head3_char";
	self attach(self.headModel, "", true);
	self.gearModel = "c_rus_military_body3_gear1_char";
	self attach(self.gearModel, "", true);
	self.voice = "russian";
	self.skeleton = "base";
	self.torsoDmg1 = "c_rus_military_body3_g_upclean";
	self.torsoDmg2 = "c_rus_military_body3_g_rarmoff";
	self.torsoDmg3 = "c_rus_military_body3_g_larmoff";
	self.torsoDmg4 = "c_rus_military_body3_g_torso";
	self.legDmg1 = "c_rus_military_body1_g_lowclean";
	self.legDmg2 = "c_rus_military_body1_g_rlegoff";
	self.legDmg3 = "c_rus_military_body1_g_llegoff";
	self.legDmg4 = "c_rus_military_body1_g_legsoff";
	self.gibSpawn1 = "c_rus_military_body1_g_rarmspawn";
	self.gibSpawnTag1 = "J_Elbow_RI";
	self.gibSpawn2 = "c_rus_military_body1_g_larmspawn";
	self.gibSpawnTag2 = "J_Elbow_LE";
	self.gibSpawn3 = "c_rus_military_body1_g_rlegspawn";
	self.gibSpawnTag3 = "J_Knee_RI";
	self.gibSpawn4 = "c_rus_military_body1_g_llegspawn";
	self.gibSpawnTag4 = "J_Knee_LE";
}
precache()
{
	precacheModel("c_rus_military_body3_char");
	precacheModel("c_rus_military_head3_char");
	precacheModel("c_rus_military_body3_gear1_char");
	precacheModel("c_rus_military_body3_g_upclean");
	precacheModel("c_rus_military_body3_g_rarmoff");
	precacheModel("c_rus_military_body3_g_larmoff");
	precacheModel("c_rus_military_body3_g_torso");
	precacheModel("c_rus_military_body1_g_lowclean");
	precacheModel("c_rus_military_body1_g_rlegoff");
	precacheModel("c_rus_military_body1_g_llegoff");
	precacheModel("c_rus_military_body1_g_legsoff");
	precacheModel("c_rus_military_body1_g_rarmspawn");
	precacheModel("c_rus_military_body1_g_larmspawn");
	precacheModel("c_rus_military_body1_g_rlegspawn");
	precacheModel("c_rus_military_body1_g_llegspawn");
	precacheModel("c_rus_military_body3_g_upclean");
	precacheModel("c_rus_military_body3_g_rarmoff");
	precacheModel("c_rus_military_body3_g_larmoff");
	precacheModel("c_rus_military_body3_g_torso");
	precacheModel("c_rus_military_body1_g_lowclean");
	precacheModel("c_rus_military_body1_g_rlegoff");
	precacheModel("c_rus_military_body1_g_llegoff");
	precacheModel("c_rus_military_body1_g_legsoff");
	precacheModel("c_rus_military_body1_g_rarmspawn");
	precacheModel("c_rus_military_body1_g_larmspawn");
	precacheModel("c_rus_military_body1_g_rlegspawn");
	precacheModel("c_rus_military_body1_g_llegspawn");
}  
