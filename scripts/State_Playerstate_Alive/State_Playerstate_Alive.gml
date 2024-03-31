function State_Playerstate_Alive() : State_Playerstate("Playerstate_Alive") constructor {
	
	
	/*
		This State is equipped with its own substate,
		rather than storing it as another varaible in
		obj_Player.
	*/
	
	asset_tags_init("Asset_PlayerMovestat");	//<-- (Reached tag character limit)
	movestate = state_global_get("PlayerMovestate_Ground");
	
	

	#region Playerstate -- Transitions
	
	///@static
	static __in__ = function() {
		
		//Player is respawning
		
		super("__in__");
		
		with(obj_Player) {
			
			x = xstart;
			y = ystart;
			
			velocityHorizontal = 0.00;
			velocityVertical   = 0.00;
			
			image_angle = 0.00;
			
			}
		
		movestate = state_global_get("PlayerMovestate_Ground");
		
		}
			
	#endregion

	
	#region Playerstate Alive -- Events
	
	///@static
	static step = function() {
				
		//Movement
		movestate.step();
		
		
		with(other) {
		
			//Fell out of map
			if (y > room_height)
				other.transition("Playerstate_Dead");
			
			}
		
		}
	
	#endregion
	
	
	#region Playerstate Alive -- Debugging
	
    ///@static
    ///@returns {string}
    static toString = function() {
        
		var str = super("toString");
		str += $"\n - {movestate}";
		
		with(obj_Player) {
			str += $"\n - x delta: ({x - xprevious})";
			str += $"\n - y delta: ({y - yprevious})";
			}
		
		return str;
        
        }
    
	#endregion

	
	}