
main()
{
	self setModel("c_rus_kravchenko_fb");
	self.gearModel = "c_rus_kravchenko_bandolier";
	self attach(self.gearModel, "", true);
	self.voice = "russian";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_rus_kravchenko_fb");
	precacheModel("c_rus_kravchenko_bandolier");
}  
