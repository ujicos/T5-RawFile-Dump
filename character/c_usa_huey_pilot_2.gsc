
main()
{
	self setModel("c_usa_huey_pilot_body");
	self.headModel = "c_usa_huey_pilot_head2";
	self attach(self.headModel, "", true);
	self.hatModel = "c_usa_huey_pilot_helmet";
	self attach(self.hatModel);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_huey_pilot_body");
	precacheModel("c_usa_huey_pilot_head2");
	precacheModel("c_usa_huey_pilot_helmet");
}  
