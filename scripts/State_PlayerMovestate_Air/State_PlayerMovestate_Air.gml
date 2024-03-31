function State_PlayerMovestate_Air() : State_PlayerMovestate("PlayerMovestate_Air") constructor {


	#region PlayerMovestate Air -- Transitions
	
	///@static
	static __in__ = function() {
		
		
		super("__in__");
		
		
		with(obj_Player) {
			velocityVertical = -jumpStrength;
			}
		
		}
			
	#endregion
	
	
	#region PlayerMovestate Air -- Events
	
	///@static
	static step = function() {
		
		
		super("step");
		
		
		with(other) {	//<-- Access the calling Player instance from this Playerstate instance
			
			velocityVertical += (gravityStrength * DT);
			var yTarget/*:number*/ = (y + velocityVertical);
			
			//Check for collision with ground
			var wallTarget = instance_place(x, yTarget, obj_Wall);
			if (wallTarget != noone) {
				
				if (wallTarget.y >= yTarget) {
				
					y = (wallTarget.y - round(sprite_get_height(sprite_index)/2));
					state.movestate.transition("PlayerMovestate_Ground");
					return;
					
					}
				
				}
				
			//No collision, move to target y position
			y = yTarget;
							
			}
			
		}
	
	#endregion
	
	}