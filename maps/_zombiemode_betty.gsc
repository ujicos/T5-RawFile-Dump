#include common_scripts\utility; 
#include maps\_utility;
#include maps\_zombiemode_utility;
init()
{
	trigs = getentarray("betty_purchase","targetname");
	for(i=0; i<trigs.size; i++)
	{
		model = getent( trigs[i].target, "targetname" ); 
		model hide(); 
	}
	array_thread(trigs,::buy_bouncing_betties);
	level thread give_betties_after_rounds();
}
buy_bouncing_betties()
{
	self.zombie_cost = 1000;
	self sethintstring( &"ZOMBIE_BETTY_PURCHASE" );	
	self setCursorHint( "HINT_NOICON" );
	level thread set_betty_visible();
	self.betties_triggered = false;
	while(1)
	{
		self waittill("trigger",who);
		if( who in_revive_trigger() )
		{
			continue;
		}
		if( is_player_valid( who ) )
		{
			if( who.score >= self.zombie_cost )
			{				
				if ( !who is_player_placeable_mine( "mine_bouncing_betty" ) )
				{
					play_sound_at_pos( "purchase", self.origin );
					
					who maps\_zombiemode_score::minus_to_player_score( self.zombie_cost ); 
					who maps\_zombiemode_weapons::check_collector_achievement( "mine_bouncing_betty" );
					who thread bouncing_betty_setup();
					who thread show_betty_hint("betty_purchased");
					
					if( self.betties_triggered == false )
					{						
						model = getent( self.target, "targetname" ); 					
						model thread maps\_zombiemode_weapons::weapon_show( who ); 
						self.betties_triggered = true;
					}
					trigs = getentarray("betty_purchase","targetname");
					for(i = 0; i < trigs.size; i++)
					{
						trigs[i] SetInvisibleToPlayer(who);
					}
				}
				else
				{
					
				}
			}
		}
	}
}
set_betty_visible()
{
	players = getplayers();	
	trigs = getentarray("betty_purchase","targetname");
	while(1)
	{
		for(j = 0; j < players.size; j++)
		{
			if( !players[j] is_player_placeable_mine( "mine_bouncing_betty" ) )
			{						
				for(i = 0; i < trigs.size; i++)
				{
					trigs[i] SetInvisibleToPlayer(players[j], false);
				}
			}
		}
		wait(1);
		players = getplayers();	
	}
}
bouncing_betty_watch()
{
	self endon("death");
	while(1)
	{
		self waittill("grenade_fire",betty,weapname);
		if(weapname == "mine_bouncing_betty")
		{
			betty.owner = self;
			betty thread betty_think();
			self thread betty_death_think();
		}
	}
}
betty_death_think()
{
	self waittill("death");
	if(isDefined(self.trigger))
	{
		self.trigger delete();
	}
	self delete();
}
bouncing_betty_setup()
{	
	self thread bouncing_betty_watch();
	self giveweapon("mine_bouncing_betty");
	self set_player_placeable_mine("mine_bouncing_betty");
	self setactionslot(4,"weapon","mine_bouncing_betty");
	self setweaponammostock("mine_bouncing_betty",5);
}
betty_think()
{
	wait(2);
	trigger = spawn("trigger_radius",self.origin,9,80,64);
	trigger waittill( "trigger" );
	trigger = trigger;
	self playsound("betty_activated");
	wait(.1);	
	fake_model = spawn("script_model",self.origin);
	fake_model setmodel(self.model);
	self hide();
	tag_origin = spawn("script_model",self.origin);
	tag_origin setmodel("tag_origin");
	tag_origin linkto(fake_model);
	playfxontag(level._effect["betty_trail"], tag_origin,"tag_origin");
	fake_model moveto (fake_model.origin + (0,0,32),.2);
	fake_model waittill("movedone");
	playfx(level._effect["betty_explode"], fake_model.origin);
	earthquake(1, .4, fake_model.origin, 512);
	if ( isdefined( self.owner ) )
	{
		self detonate( self.owner );
	}
	else
	{
		self detonate( undefined );
	}
	if ( isdefined( trigger ) )
	{
		trigger delete();
	}
	if ( isdefined( fake_model ) )
	{
		fake_model delete();
	}
	if ( isdefined( tag_origin ) )
	{
		tag_origin delete();
	}
	if ( isdefined( self ) )
	{
		self delete();
	}
}
betty_smoke_trail()
{
	self.tag_origin = spawn("script_model",self.origin);
	self.tag_origin setmodel("tag_origin");
	playfxontag(level._effect["betty_trail"],self.tag_origin,"tag_origin");
	self.tag_origin moveto(self.tag_origin.origin + (0,0,100),.15);
}
give_betties_after_rounds()
{
	while(1)
	{
		level waittill( "between_round_over" );
		{
			players = get_players();
			for(i=0;i<players.size;i++)
			{
				if ( players[i] is_player_placeable_mine( "mine_bouncing_betty" ) )
				{
					players[i]  giveweapon("mine_bouncing_betty");
					players[i]  set_player_placeable_mine("mine_bouncing_betty");
					players[i]  setactionslot(4,"weapon","mine_bouncing_betty");
					players[i]  setweaponammoclip("mine_bouncing_betty",2);
				}
			}
		}
	}
}
init_hint_hudelem(x, y, alignX, alignY, fontscale, alpha)
{
	self.x = x;
	self.y = y;
	self.alignX = alignX;
	self.alignY = alignY;
	self.fontScale = fontScale;
	self.alpha = alpha;
	self.sort = 20;
	
}
setup_client_hintelem()
{
	self endon("death");
	self endon("disconnect");
	if(!isDefined(self.hintelem))
	{
		self.hintelem = newclienthudelem(self);
	}
	self.hintelem init_hint_hudelem(320, 220, "center", "bottom", 1.6, 1.0);
}
show_betty_hint(string)
{
	self endon("death");
	self endon("disconnect");
	if(string == "betty_purchased")
		text = &"ZOMBIE_BETTY_HOWTO";
	else
		text = &"ZOMBIE_BETTY_ALREADY_PURCHASED";
	self setup_client_hintelem();
	self.hintelem setText(text);
	wait(3.5);
	self.hintelem settext("");
}  
