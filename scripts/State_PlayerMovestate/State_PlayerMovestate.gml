///@param {string} _name
function State_PlayerMovestate(_name) : State_Demostate(_name) constructor {

	
	#region PlayerMovestate -- Transitions
	
	///@static
	static __in__ = function() {
		
		with(obj_Player) {
			state.movestate = other;
			}
		
		}
			
	#endregion
	
	
	
	#region PlayerMovestate  -- Events
	
	///@static
	static step = function() {
				
		with(other) {
		
			//Apply Velocities
			x += velocityHorizontal;
			//y += velocityVertical;
			
			}
			
		}
	
	#endregion
	
	
	#region PlayerMovestate -- Debugging
	
    ///@static
    ///@returns {string}
    static toString = function() {
        
		return $"PlayerMovestate: {name}";
        
        }
    
	#endregion
	

	}