
main()
{
	self setModel("c_usa_jungmar_body_drab_char");
	self.headModel = "c_usa_jungmar_head1_nc_char";
	self attach(self.headModel, "", true);
	self.gearModel = "c_usa_jungmar_gear1_char";
	self attach(self.gearModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_jungmar_body_drab_char");
	precacheModel("c_usa_jungmar_head1_nc_char");
	precacheModel("c_usa_jungmar_gear1_char");
}  
