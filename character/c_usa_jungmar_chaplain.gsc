
main()
{
	self setModel("c_usa_jungmar_body_drab");
	self.headModel = "c_usa_jungmar_head_chaplain";
	self attach(self.headModel, "", true);
	self.gearModel = "c_usa_jungmar_gear_chaplain";
	self attach(self.gearModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_jungmar_body_drab");
	precacheModel("c_usa_jungmar_head_chaplain");
	precacheModel("c_usa_jungmar_gear_chaplain");
}  
