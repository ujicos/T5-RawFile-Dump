
main()
{
	self setModel("c_usa_jungmar_bowman_pris_body");
	self.headModel = "c_usa_jungmar_bowman_pris_head_bleed";
	self attach(self.headModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_jungmar_bowman_pris_body");
	precacheModel("c_usa_jungmar_bowman_pris_head_bleed");
}  
