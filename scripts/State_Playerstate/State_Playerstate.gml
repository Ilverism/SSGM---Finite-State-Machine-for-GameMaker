///@param {string} _name
function State_Playerstate(_name) : State_Demostate(_name) constructor {

	
	#region Playerstate -- Transitions
	
	///@static
	static __in__ = function() {
		
		with(obj_Player) {
			state = other;
			}
		
		}
			
	#endregion
	
	
	#region Playerstate -- Debugging
	
    ///@static
    ///@returns {string}
    static toString = function() {
        
		return $"Playerstate: {name}";
        
        }
    
	#endregion

	}