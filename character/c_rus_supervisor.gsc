
main()
{
	self setModel("c_rus_spetznaz_body2");
	self.headModel = "c_rus_supervisor_head";
	self attach(self.headModel, "", true);
	self.gearModel = "c_rus_supervisor_gear";
	self attach(self.gearModel, "", true);
	self.voice = "russian";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_rus_spetznaz_body2");
	precacheModel("c_rus_supervisor_head");
	precacheModel("c_rus_supervisor_gear");
}  
