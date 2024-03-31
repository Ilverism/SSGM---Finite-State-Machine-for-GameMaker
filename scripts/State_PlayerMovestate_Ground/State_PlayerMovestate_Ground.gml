function State_PlayerMovestate_Ground() : State_PlayerMovestate("PlayerMovestate_Ground") constructor {
	

	#region PlayerMovestate Ground -- Transitions
	
	///@static
	static __in__ = function() {
		
		
		super("__in__");
		
		
		with(obj_Player) {
			velocityVertical = 0.00;
			}
		
		}
			
	#endregion
	
	
	#region PlayerMovestate Ground -- Events
	
	///@static
	static step = function() {
		
		
		super("step");
		
		
		with(other) {	//<-- Access the calling Player instance from this Playerstate instance

			 //Movement
			 var leftHeld/*:bool*/  = (keyboard_check(vk_left)  | keyboard_check(ord("A")));
			 var rightHeld/*:bool*/ = (keyboard_check(vk_right) | keyboard_check(ord("D")));
	
			 //If trying to move in one direction...
			 if (leftHeld xor rightHeld) {
	    
			     var horizontalMovementSign/*:int*/ = (rightHeld - leftHeld);
			     velocityHorizontal += (horizontalMovementSign * DT);
	    
			     }
			     
			//Slide with acceleration
			rollAngle -= velocityHorizontal;
					
			//Jump (Enter 'Air' Movestate)
			if (keyboard_check_pressed(vk_space)) {
				
				state.movestate.transition("PlayerMovestate_Air");
				return;
				
				}
			
			//Apply friction
			velocityHorizontal *= (1.00 / rollFriction);			

			}

		}
	
	#endregion
	
	}