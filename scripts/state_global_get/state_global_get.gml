///@param {string} stateName
///@param {bool} [allowFailure=false]
///@returns {State}
function state_global_get(stateName, allowFailure=false) {

	var stateOut/*:State*/ = global.gStates[$ stateName];
	
	//Target State does not exist with the supplied name
	if (is_undefined(stateOut)) {
		
		//Allow this function call to fail and return 'undefined'
		if (allowFailure)
			return undefined;
		
		//Function failure is not permitted, throw an error
		else
			throw($"ERROR -- Failed to find State with name: {stateName}");
			
		}

	return stateOut;

	}