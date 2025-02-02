#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
init()
{
	level.trap_kills = 0;
	traps = GetEntArray( "zombie_trap", "targetname" );
	
	if( level.mutators["mutator_noTraps"] )
	{
		disable_traps( traps );
		return;
	}
	
	array_thread( traps, ::trap_init );
	level.burning_zombies = [];		
 	level.elec_trap_time = 40;
 	level.elec_trap_cooldown_time = 60;
}
disable_traps( traps )
{
	for( i = 0; i < traps.size; i++ )
	{
		if( isDefined( traps[i].target ) )
		{
			components = GetEntArray( traps[i].target, "targetname" );
			for( j = 0; j < components.size; j++ )
			{
				if( components[j].classname == "trigger_use" )
				{
					components[j] disable_trigger();
				}
			}
		}
		traps[i] disable_trigger();
	}
}
trap_init()
{
	
	self ent_flag_init( "flag_active" );
	self ent_flag_init( "flag_cooldown" );
	self._trap_type = "";
	
	if ( IsDefined(self.script_noteworthy) )
	{
		self._trap_type = self.script_noteworthy;
		
		if ( IsDefined( level._zombiemode_trap_activate_funcs ) &&
			 IsDefined( level._zombiemode_trap_activate_funcs[ self._trap_type ] ) )
		{
			self._trap_activate_func = level._zombiemode_trap_activate_funcs[ self._trap_type ];
		}
		else
		{
			switch( self.script_noteworthy )
			{
			case "rotating":
				self._trap_activate_func = ::trap_activate_rotating;
				break;
			case "electric":
				self._trap_activate_func = ::trap_activate_electric;
				break;
			case "flipper":
				self._trap_activate_func = ::trap_activate_flipper;
				break;
			case "fire":
			default:
				self._trap_activate_func = ::trap_activate_fire;
			}
		}
		
		if ( IsDefined( level._zombiemode_trap_use_funcs ) &&
			 IsDefined( level._zombiemode_trap_use_funcs[ self._trap_type ] ) )
		{
			self._trap_use_func = level._zombiemode_trap_use_funcs[ self._trap_type ];
		}
		else
		{
			self._trap_use_func = ::trap_use_think;
		}
	}
	
	
	self trap_model_type_init();
	
	self._trap_use_trigs = [];	
	self._trap_lights = [];		
	self._trap_movers = [];		
	self._trap_switches = [];	
	components = GetEntArray( self.target, "targetname" );
	for ( i=0; i<components.size; i++ )
	{
		if ( IsDefined( components[i].script_noteworthy ) )
		{
			switch ( components[i].script_noteworthy )
			{
			case "counter_1s":
				self.counter_1s = components[i];
				continue;
			case "counter_10s":
				self.counter_10s = components[i];
				continue;
			case "counter_100s":
				self.counter_100s = components[i];
				continue;
			case "mover":
				self._trap_movers[ self._trap_movers.size ] = components[i];
				continue;
			case "switch":
				self._trap_switches[ self._trap_switches.size ] = components[i];
				continue;
			case "light":
				self._trap_lightes[ self._trap_lightes.size ] = components[i];
				continue;
			}
		}
		if( IsDefined( components[i].script_string ) ) 
		{
			switch ( components[i].script_string )
			{
			case "flipper1":
				self.flipper1 = components[i];
				continue;
			case "flipper2":
				self.flipper2 = components[i];
				continue;
			case "flipper1_radius_check":
				self.flipper1_radius_check = components[i];
				continue;
			case "flipper2_radius_check":
				self.flipper2_radius_check = components[i];
				continue;
			case "target1":
				self.target1 = components[i];
				continue;
			case "target2":
				self.target2 = components[i];
				continue;
			case "target3":
				self.target3 = components[i];
				continue;
			}
		}
		switch ( components[i].classname )
		{
		case "trigger_use":
			self._trap_use_trigs[ self._trap_use_trigs.size ] = components[i];
			break;
		case "script_model":
			if ( components[i].model == self._trap_light_model_off )
			{
				self._trap_lights[ self._trap_lights.size ] = components[i];
			}
			else if ( components[i].model == self._trap_switch_model )  
			{
				self._trap_switches[ self._trap_switches.size ] = components[i];
			}
		}
	}
	self._trap_fx_structs = [];
	components = GetStructArray( self.target, "targetname" );
	
	for ( i=0; i<components.size; i++ )
	{
		if ( IsDefined( components[i].script_string ) && components[i].script_string == "use_this_angle" )
		{
			self.use_this_angle = components[i];
		}
		else
		{
			self._trap_fx_structs[ self._trap_fx_structs.size ] = components[i];
		}
	}
	assertEx( self._trap_use_trigs.size > 0, "_zombiemode_traps::init no use triggers found for "+self.target );
	if ( !IsDefined( self.zombie_cost ) )
	{
		self.zombie_cost = 1000;
	}
	self._trap_in_use = 0;
	self._trap_cooling_down = 0;
	self thread trap_dialog();
	flag_wait( "all_players_connected" );
	self trap_lights_red();
	
	for ( i=0; i<self._trap_use_trigs.size; i++ )
	{
		self._trap_use_trigs[i] SetCursorHint( "HINT_NOICON" );
	}
	
	if ( !IsDefined( self.script_flag_wait ) )
	{
		self trap_set_string( &"ZOMBIE_NEED_POWER" );
		flag_wait( "power_on" );
	}
	else
	{
		
		if ( !isdefined( level.flag[ self.script_flag_wait ] ) )
		{
			flag_init( self.script_flag_wait );
		}
		flag_wait( self.script_flag_wait );
	}
	
	self trap_set_string( &"ZOMBIE_BUTTON_BUY_TRAP", self.zombie_cost );
	
	self trap_lights_green();
	for ( i=0; i<self._trap_use_trigs.size; i++ )
	{
		self._trap_use_trigs[i] thread [[ self._trap_use_func ]]( self );
	}
}
trap_use_think( trap )
{	
	while(1)
	{
		
		self waittill("trigger",who);
		if( who in_revive_trigger() )
		{
			continue;
		}
		if( is_player_valid( who ) && !trap._trap_in_use )
		{
			
			players = get_players();
			if ( players.size == 1 && who.score >= trap.zombie_cost )
			{
				
				who maps\_zombiemode_score::minus_to_player_score( trap.zombie_cost ); 
			}
			else if( level.team_pool[who.team_num].score >= trap.zombie_cost )
			{
				
				who maps\_zombiemode_score::minus_to_team_score( trap.zombie_cost ); 
			}
			else if( level.team_pool[ who.team_num ].score + who.score >= trap.zombie_cost )
			{
				
				team_points = level.team_pool[ who.team_num ].score;
				who maps\_zombiemode_score::minus_to_player_score( trap.zombie_cost - team_points ); 
				who maps\_zombiemode_score::minus_to_team_score( team_points ); 
			}
			else
			{
				continue;
			}
			trap._trap_in_use = 1;
			trap trap_set_string( &"ZOMBIE_TRAP_ACTIVE" );
			play_sound_at_pos( "purchase", who.origin );
			if ( trap._trap_switches.size )
			{
				trap thread trap_move_switches();
				
				trap waittill("switch_activated");
			}
			
			trap trigger_on();
			
			trap thread [[ trap._trap_activate_func ]]();
			
			trap waittill("trap_done");
			
			trap trigger_off();
			trap._trap_cooling_down = 1;
			trap trap_set_string( &"ZOMBIE_TRAP_COOLDOWN" );
			wait( trap._trap_cooldown_time );
			trap._trap_cooling_down = 0;
			
			
			
			trap notify("available");
			trap._trap_in_use = 0;
			trap trap_set_string( &"ZOMBIE_BUTTON_BUY_TRAP", trap.zombie_cost );
		}
	}
}
trap_lights_red()
{
	if( level.mutators["mutator_noTraps"] )
	{
		return;
	}
	for(i=0;i<self._trap_lights.size;i++)
	{
		light = self._trap_lights[i];
		light setmodel( self._trap_light_model_red );	
		if(isDefined(light.fx))
		{
			light.fx delete();
		}
		light.fx = maps\_zombiemode_net::network_safe_spawn( "trap_lights_red", 2, "script_model", light.origin );
		light.fx setmodel("tag_origin");
		light.fx.angles = light.angles;
		playfxontag(level._effect["zapper_light_notready"],light.fx,"tag_origin");
	}
}
trap_lights_green()
{
	if( level.mutators["mutator_noTraps"] )
	{
		return;
	}
	
	
	for(i=0;i<self._trap_lights.size;i++)
	{
		light = self._trap_lights[i];
		if(isDefined(light._switch_disabled))
		{
			continue;
		}
		
		light setmodel( self._trap_light_model_green );	
		if(isDefined(light.fx))
		{
			light.fx delete();
		}
		light.fx = maps\_zombiemode_net::network_safe_spawn( "trap_lights_green", 2, "script_model", light.origin );
		light.fx setmodel("tag_origin");
		light.fx.angles = light.angles;
		playfxontag(level._effect["zapper_light_ready"],light.fx,"tag_origin");
	}
}
trap_set_string( string, param1, param2 )
{
	
	for ( i=0; i<self._trap_use_trigs.size; i++ )
	{
		if ( !IsDefined(param1) )
		{
			self._trap_use_trigs[i] SetHintString( string );
		}
		else if ( !IsDefined(param2) )
		{
			self._trap_use_trigs[i] SetHintString( string, param1 );
		}
		else
		{
			self._trap_use_trigs[i] SetHintString( string, param1, param2 );
		}
	}
}
trap_move_switches()
{
	if( level.mutators["mutator_noTraps"] )
	{
		return;
	}
	self trap_lights_red();
	for ( i=0; i<self._trap_switches.size; i++ )
	{
		
		self._trap_switches[i] rotatepitch( 180, .5 );
		self._trap_switches[i] playsound( "amb_sparks_l_b" );
	}
	self._trap_switches[0] waittill( "rotatedone" );
	
	self notify( "switch_activated" );
	self waittill( "available" );
	for ( i=0; i<self._trap_switches.size; i++ )
	{
		
		self._trap_switches[i] rotatepitch( -180, .5 );
	}
	self._trap_switches[0] waittill( "rotatedone" );
	self trap_lights_green();
}
trap_activate_electric()
{
	self._trap_duration = 40;
	self._trap_cooldown_time = 60;
	self notify("trap_activate");
	
	if ( IsDefined( self.script_string ) )
	{
		number = Int( self.script_string );
		if ( number != 0 )
		{
			Exploder( number );
		}
		else
		{
			clientnotify( self.script_string+"1" );
		}
	}
	
	fx_points = getstructarray( self.target,"targetname" );
	for( i=0; i<fx_points.size; i++ )
	{
		wait_network_frame();
		fx_points[i] thread trap_audio_fx(self);		
	}
	
	
	self thread trap_damage();
	wait( self._trap_duration );
	
	self notify ("trap_done");
	if ( IsDefined( self.script_string ) )
	{
		clientnotify(self.script_string +"0");	
	}
}
trap_activate_fire()
{
	self._trap_duration = 40;
	self._trap_cooldown_time = 60;
	
	clientnotify( self.script_string+"1" );
	clientnotify( self.script_parameters );
	
	fx_points = getstructarray( self.target,"targetname" );
	for( i=0; i<fx_points.size; i++ )
	{
		wait_network_frame();
		fx_points[i] thread trap_audio_fx(self);		
	}
	
	self thread trap_damage();
	wait( self._trap_duration );
	
	self notify ("trap_done");	
	clientnotify(self.script_string +"0");	
	clientnotify( self.script_parameters );
}
trap_activate_rotating()
{
	self endon( "trap_done" );	
	self._trap_duration = 30;
	self._trap_cooldown_time = 60;
	
	
	
	self thread trap_damage();
	self thread trig_update( self._trap_movers[0] );
	old_angles = self._trap_movers[0].angles;
	
	
	
	for ( i=0; i<self._trap_movers.size; i++ )
	{
		self._trap_movers[i] RotateYaw( 360, 5.0, 4.5 );
	}
	wait( 5.0 );
	step = 1.5;
	
	
		
	for (t=0; t<self._trap_duration; t=t+step )
	{
		for ( i=0; i<self._trap_movers.size; i++ )
		{
			self._trap_movers[i] RotateYaw( 360, step );
		}
		wait( step );
	}
	
	
	
	for ( i=0; i<self._trap_movers.size; i++ )
	{
		self._trap_movers[i] RotateYaw( 360, 5.0, 0.0, 4.5 );
	}
	wait( 5.0 );
	for ( i=0; i<self._trap_movers.size; i++ )
	{
		self._trap_movers[i].angles = old_angles;
	}
	
	self notify ("trap_done");	
}
trap_activate_flipper()
{ 
	
	
	
	
	
	
}
trap_audio_fx( trap )
{
	if( level.mutators["mutator_noTraps"] )
	{
		return;
	}
	
	sound_origin = undefined;
    
    if( trap.script_noteworthy == "electric" )
    {
	    sound_origin = spawn( "script_origin", self.origin );
	    sound_origin playsound( "zmb_elec_start" );
	    sound_origin playloopsound( "zmb_elec_loop" );
	    self thread play_electrical_sound( trap );
	}
	else if( trap.script_noteworthy == "fire" )
	{
	    sound_origin = spawn( "script_origin", self.origin );
	    sound_origin playsound( "zmb_firetrap_start" );
	    sound_origin playloopsound( "zmb_firetrap_loop" );
	}
	trap waittill_any_or_timeout( trap._trap_duration, "trap_done");
	if(IsDefined(sound_origin))
	{	
		if( trap.script_noteworthy == "fire" )
		    playsoundatposition( "zmb_firetrap_end", sound_origin.origin );
		    
		sound_origin stoploopsound();
		wait(.05);
		sound_origin delete();
	}	 
}
play_electrical_sound( trap )
{
	trap endon ("trap_done");
	while( 1 )
	{	
		wait( randomfloatrange(0.1, 0.5) );
		playsoundatposition( "zmb_elec_arc", self.origin );
	}
}
trap_damage()
{	
	self endon( "trap_done" );
	while(1)
	{
		self waittill( "trigger", ent );
		
		
		if( isplayer(ent) )
		{
			switch ( self._trap_type )
			{
			case "electric":
				ent thread player_elec_damage();
				break;
			case "fire":
			case "rocket":
				ent thread player_fire_damage();
				break;
			case "rotating":
				if ( ent GetStance() == "stand" )
				{
					ent dodamage( 50, ent.origin+(0,0,20) );
					ent SetStance( "crouch" );
				}
				break;
			}
		}
		else
		{
			if(!isDefined(ent.marked_for_death))
			{
				switch ( self._trap_type )
				{
				case "rocket":
					ent thread zombie_trap_death( self, 100 );
					break;
				case "rotating":
					ent thread zombie_trap_death( self, 200 );
					break;
				case "electric":
				case "fire":
				default:
					ent thread zombie_trap_death( self, randomint(100) );
					break;
				}
			}
		}
	}
}
trig_update( parent )
{
	if( level.mutators["mutator_noTraps"] )
	{
		return;
	}
	self endon( "trap_done" );
	start_angles = self.angles;
	while (1)
	{
		self.angles = parent.angles;
		wait( 0.05 );
	}
}
player_elec_damage()
{	
	self endon("death");
	self endon("disconnect");
	
	if( !IsDefined(level.elec_loop) )
	{
		level.elec_loop = 0;
	}	
	
	if( !isDefined(self.is_burning) && !self maps\_laststand::player_is_in_laststand() )
	{
		self.is_burning = 1;		
		self setelectrified(1.25);
		shocktime = 2.5;
		
		self shellshock("electrocution", shocktime);
		
		if(level.elec_loop == 0)
		{	
			elec_loop = 1;
			
			self playsound("zmb_zombie_arc");
		}
		if(!self hasperk("specialty_armorvest")  || self.health - 100 < 1)
		{
			radiusdamage(self.origin,10,self.health + 100,self.health + 100);
			self.is_burning = undefined;
		}
		else
		{
			self dodamage(50, self.origin);
			wait(.1);
			
			self.is_burning = undefined;
		}
	}
}
player_fire_damage()
{	
	self endon("death");
	self endon("disconnect");
	
	if( !isDefined(self.is_burning) && !self maps\_laststand::player_is_in_laststand() )
	{
		self.is_burning = 1;		
		self setburn(1.25);
		if(!self hasperk("specialty_armorvest")  || self.health - 100 < 1)
		{
			radiusdamage(self.origin,10,self.health + 100,self.health + 100);
			self.is_burning = undefined;
		}
		else
		{
			self dodamage(50, self.origin);
			wait(.1);
			
			self.is_burning = undefined;
		}
	}
}
zombie_trap_death( trap, param )
{
	if( level.mutators["mutator_noTraps"] )
	{
		return;
	}
	self endon("death");
	
	self.marked_for_death = true;
	switch (trap._trap_type)
	{
	case "fire":
	case "electric":
	case "rocket":
		
		if ( IsDefined( self.animname ) && self.animname != "zombie_dog" )
		{
			
			
			if( (param > 90) && (level.burning_zombies.size < 6) )
			{
				level.burning_zombies[level.burning_zombies.size] = self;
				self thread zombie_flame_watch();
				self playsound("ignite");
				self thread animscripts\zombie_death::flame_death_fx();
				wait( randomfloat(1.25) );
			}
			else
			{
				refs[0] = "guts";
				refs[1] = "right_arm"; 
				refs[2] = "left_arm"; 
				refs[3] = "right_leg"; 
				refs[4] = "left_leg"; 
				refs[5] = "no_legs";
				refs[6] = "head";
				self.a.gib_ref = refs[randomint(refs.size)];
                
				playsoundatposition("zmb_zombie_arc", self.origin);
				
				if( trap._trap_type == "electric" )
				{
					if(randomint(100) > 50 )
					{
						self thread electroctute_death_fx();
						self thread play_elec_vocals();
					}
				}
				
				wait(randomfloat(1.25));
				self playsound("zmb_zombie_arc");
			}
		}
		
		if ( IsDefined( self.fire_damage_func ) )
		{
			self [[ self.fire_damage_func ]]( trap );
		}
		else
		{
			level notify( "trap_kill", self, trap );
			self dodamage(self.health + 666, self.origin, trap);
		}
	
		break;
	case "rotating":
	case "centrifuge":
		
		
		
		ang = VectorToAngles( trap.origin - self.origin );
		
		
		direction_vec = vector_scale( AnglesToRight( ang ), param);
		
		if ( IsDefined( self.trap_reaction_func ) )
		{
			self [[ self.trap_reaction_func ]]( trap );
		}
		level notify( "trap_kill", self, trap );
		self StartRagdoll();
		self launchragdoll(direction_vec);
		wait_network_frame();
		
		self.a.gib_ref = "head";
		self dodamage(self.health, self.origin, trap);
		break;
	}
}
zombie_flame_watch()
{
	if( level.mutators["mutator_noTraps"] )
	{
		return;
	}
	self waittill("death");
	self stoploopsound();
	level.burning_zombies = array_remove_nokeys(level.burning_zombies,self);
}
play_elec_vocals()
{
	if( IsDefined (self) )
	{
		org = self.origin;
		wait(0.15);
		playsoundatposition("zmb_elec_vocals", org);
		playsoundatposition("zmb_zombie_arc", org);
		playsoundatposition("zmb_exp_jib_zombie", org);
	}
}
	
electroctute_death_fx()
{
	self endon( "death" );
	if (isdefined(self.is_electrocuted) && self.is_electrocuted )
	{
		return;
	}
	self.is_electrocuted = true;
	
	self thread electrocute_timeout();
		
	
	
	if(self.team == "axis")
	{
		level.bcOnFireTime = gettime();
		level.bcOnFireOrg = self.origin;
	}
	
	PlayFxOnTag( level._effect["elec_torso"], self, "J_SpineLower" );
	self playsound ("zmb_elec_jib_zombie");
	wait 1;
	tagArray = []; 
	tagArray[0] = "J_Elbow_LE"; 
	tagArray[1] = "J_Elbow_RI"; 
	tagArray[2] = "J_Knee_RI"; 
	tagArray[3] = "J_Knee_LE"; 
	tagArray = array_randomize( tagArray ); 
	PlayFxOnTag( level._effect["elec_md"], self, tagArray[0] ); 
	self playsound ("zmb_elec_jib_zombie");
	wait 1;
	self playsound ("zmb_elec_jib_zombie");
	tagArray[0] = "J_Wrist_RI"; 
	tagArray[1] = "J_Wrist_LE"; 
	if( !IsDefined( self.a.gib_ref ) || self.a.gib_ref != "no_legs" )
	{
		tagArray[2] = "J_Ankle_RI"; 
		tagArray[3] = "J_Ankle_LE"; 
	}
	tagArray = array_randomize( tagArray ); 
	PlayFxOnTag( level._effect["elec_sm"], self, tagArray[0] ); 
	PlayFxOnTag( level._effect["elec_sm"], self, tagArray[1] );
}
electrocute_timeout()
{
	self endon ("death");
	self playloopsound("fire_manager_0");
	
	wait 12;
	self stoploopsound();
	if (isdefined(self) && isalive(self))
	{
		self.is_electrocuted = false;
		self notify ("stop_flame_damage");
	}
	
}
trap_dialog()
{
	self endon ("warning_dialog");
	level endon("switch_flipped");
	timer =0;
	while(1)
	{
		wait(0.5);
		players = get_players();
		for(i = 0; i < players.size; i++)
		{		
			dist = distancesquared(players[i].origin, self.origin );
			if(dist > 70*70)
			{
				timer = 0;
				continue;
			}
			if(dist < 70*70 && timer < 3)
			{
				wait(0.5);
				timer ++;
			}
			if(dist < 70*70 && timer == 3)
			{
				
				index = maps\_zombiemode_weapons::get_player_index(players[i]);
				plr = "plr_" + index + "_";
				
				wait(3);				
				self notify ("warning_dialog");
				
			}
		}
	}
}
get_trap_array( trap_type )
{
	ents = GetEntArray( "zombie_trap", "targetname" );
	traps = [];
	for ( i=0; i<ents.size; i++ )
	{
		if ( ents[i].script_noteworthy == trap_type )
		{
			traps[ traps.size ] = ents[i];
		}
	}
	return traps;
}
trap_disable()
{
	cooldown = self._trap_cooldown_time;
	if ( self._trap_in_use )
	{
		self notify( "trap_done" );
		self._trap_cooldown_time = 0.05;
		self waittill( "available" );
	}
	array_thread( self._trap_use_trigs, ::trigger_off );
	self trap_lights_red();
	self._trap_cooldown_time = cooldown;
}
trap_enable()
{
	array_thread( self._trap_use_trigs, ::trigger_on );
	self trap_lights_green();
}
trap_model_type_init()
{
	
	
	if( !IsDefined( self.script_parameters ) ) 
	{
		self.script_parameters = "default";
	}
	
	
	switch( self.script_parameters )
	{
		case "pentagon_electric": 
			self._trap_light_model_off = "zombie_trap_switch_light";
			self._trap_light_model_green = "zombie_trap_switch_light_on_green";
			self._trap_light_model_red = "zombie_trap_switch_light_on_red";
			self._trap_switch_model = "zombie_trap_switch_handle";
			break;
				
		case "default":
		default:
			self._trap_light_model_off = "zombie_zapper_cagelight";
			self._trap_light_model_green = "zombie_zapper_cagelight_green";
			self._trap_light_model_red = "zombie_zapper_cagelight_red";
			self._trap_switch_model = "zombie_zapper_handle";
			break;	
	}
	
} 
  
