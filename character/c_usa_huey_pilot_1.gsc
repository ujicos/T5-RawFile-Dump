
main()
{
	self setModel("c_usa_huey_pilot_body");
	self.headModel = "c_usa_huey_pilot_head1";
	self attach(self.headModel, "", true);
	self.hatModel = "c_usa_huey_pilot_helmet_logo";
	self attach(self.hatModel);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_huey_pilot_body");
	precacheModel("c_usa_huey_pilot_head1");
	precacheModel("c_usa_huey_pilot_helmet_logo");
}  
