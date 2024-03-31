///@param {string} _name
function State_Demostate(_name) : State(_name) constructor {
	
	/*
		This State is an ancestor of all other States
		defined in the demo. It is used to record and
		display all State transitions that occur.
	*/
	
	
	#region Demostate -- Transitions
	
    /////@static
    /////@param {State} targetState
    //static __to__ = function(targetState) {
        
	//	static super = static_get(static_get(self))[$ "__to__"];
	//	super();
		
	//	//var transitionString = $"{previousState} -> {self}";
	//	//array_push(obj_Controller, transitionString);
		
    //    }
    
	
    ///@static
    ///@param {State} previousState
    static __from__ = function(previousState) {
		 	 
		var __from__super = static_get(State)[$ "__from__"];
		__from__super(previousState);
		
		var transitionString = $"{previousState.name} -> {name}";
		array_push(obj_Controller.stateTransitionsList, transitionString);
		 
        }
		
	#endregion
	
	}