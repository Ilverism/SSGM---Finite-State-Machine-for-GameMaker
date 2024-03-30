///@param {string} stateName
///@returns {State}
function state_global_load(stateName) {

    var targetState = state_global_get(stateName);
    targetState.load();
    
    return targetState;

    }