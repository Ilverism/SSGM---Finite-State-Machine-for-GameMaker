///@param {State} newState
///@param {int} allowRedefinition
function state_global_set(newState, allowRedefinition) {

	var newStateName/*:string*/ = newState.name;
	
	//Attempted to redefine a State in the global set
	if (variable_struct_exists(gStates, newStateName) and (allowRedefinition == STATE_DEFINITION_BEHAVIOR.GlobalConstant))
		throw($"ERROR -- Tried to redefine State with name: {newStateName}");
		
	gStates[$ newStateName] = newState;

	}