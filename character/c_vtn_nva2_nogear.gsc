
main()
{
	self setModel("c_vtn_nva2_body");
	self.headModel = "c_vtn_nva2_head";
	self attach(self.headModel, "", true);
	self.voice = "vietnamese";
	self.skeleton = "base";
	self.torsoDmg1 = "c_vtn_nva2_body_g_upclean";
	self.torsoDmg2 = "c_vtn_nva2_body_g_rarmoff";
	self.torsoDmg3 = "c_vtn_nva2_body_g_larmoff";
	self.torsoDmg4 = "c_vtn_nva2_body_g_torso";
	self.legDmg1 = "c_vtn_nva2_body_g_lowclean";
	self.legDmg2 = "c_vtn_nva2_body_g_rlegoff";
	self.legDmg3 = "c_vtn_nva2_body_g_llegoff";
	self.legDmg4 = "c_vtn_nva2_body_g_legsoff";
	self.gibSpawn1 = "c_vtn_g_rarmspawn";
	self.gibSpawnTag1 = "J_Elbow_RI";
	self.gibSpawn2 = "c_vtn_g_larmspawn";
	self.gibSpawnTag2 = "J_Elbow_LE";
	self.gibSpawn3 = "c_vtn_g_rlegspawn";
	self.gibSpawnTag3 = "J_Knee_RI";
	self.gibSpawn4 = "c_vtn_g_llegspawn";
	self.gibSpawnTag4 = "J_Knee_LE";
}
precache()
{
	precacheModel("c_vtn_nva2_body");
	precacheModel("c_vtn_nva2_head");
	precacheModel("c_vtn_nva2_body_g_upclean");
	precacheModel("c_vtn_nva2_body_g_rarmoff");
	precacheModel("c_vtn_nva2_body_g_larmoff");
	precacheModel("c_vtn_nva2_body_g_torso");
	precacheModel("c_vtn_nva2_body_g_lowclean");
	precacheModel("c_vtn_nva2_body_g_rlegoff");
	precacheModel("c_vtn_nva2_body_g_llegoff");
	precacheModel("c_vtn_nva2_body_g_legsoff");
	precacheModel("c_vtn_g_rarmspawn");
	precacheModel("c_vtn_g_larmspawn");
	precacheModel("c_vtn_g_rlegspawn");
	precacheModel("c_vtn_g_llegspawn");
	precacheModel("c_vtn_nva2_body_g_upclean");
	precacheModel("c_vtn_nva2_body_g_rarmoff");
	precacheModel("c_vtn_nva2_body_g_larmoff");
	precacheModel("c_vtn_nva2_body_g_torso");
	precacheModel("c_vtn_nva2_body_g_lowclean");
	precacheModel("c_vtn_nva2_body_g_rlegoff");
	precacheModel("c_vtn_nva2_body_g_llegoff");
	precacheModel("c_vtn_nva2_body_g_legsoff");
	precacheModel("c_vtn_g_rarmspawn");
	precacheModel("c_vtn_g_larmspawn");
	precacheModel("c_vtn_g_rlegspawn");
	precacheModel("c_vtn_g_llegspawn");
}  
