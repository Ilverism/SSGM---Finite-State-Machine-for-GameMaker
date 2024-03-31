///@param {string} _name
///@param {int} [definitionBehavior=STATE_DEFINITION_BEHAVIOR.GlobalConstant]
function State(_name, definitionBehavior=STATE_DEFINITION_BEHAVIOR.GlobalConstant) constructor {

    /*
    ---------------------------------------------------------------------------------
	
		*   StateStream for GameMaker   *
		
		
		!!!	READ ME !!! 
		
	    STATE TRANSITIONS ORDER:
	    1. 'Out'  - Generic Transition from current State
	    2. 'To'   - Specific Transition from current State to target State
	    3. 'From' - Specific Transition from previous State to current State
	    4. 'In'   - Generic Transition into current (new) State
	
		Methods containing the comment '// (Implement ...)' should have their
		logic overwritten (when needed!) in child constructors.
		
		Methods formatted as __function_name__ are considered private,
		and should not be called manually. However, you will want to add
		some logic or behavior to the content of the private transition methods
		if you want any updates to occur when moving between States.
		
		The specific 'To' and 'From' transition methods can be assigned using
		the 'set_transition_to' and 'set_transition_from' static methods below.
		These methods will only be triggered upon transitioning to/from the
		specified State, whereas the 'Out' and 'In' methods will always be
		triggered upon exit/entry.
		
		A global mapping of all States is kept via the global.gStates variable,
		primarilly for ease of use in transitioning to other States via
		their supplied name instead of their variables. This behavior
		can be overwritten when creating a new State, allowing the instances
		in the global struct to be overwritten or simply have it not
		be added at all.
		
		Additionally, there is also a 'state_global_load' function that allows you
		to fetch existing States from the global set and initialize them, but this
		is not required to use.
		
		To ensure that an instance of a State exists, they can be pre-created
		using the included 'asset_tags_init' function which creates instances
		based on tags applied in the GameMaker Asset Browser. For States that
		you only want one instance of, make sure you include the 'Singleton' tag.
		If you want to load in different types of States in batches, give them
		different tags such as "Asset_Gamestate" or "Asset_Playerstate" and supply
		these strings to the 'asset_tags_init' function at the start of the game
		(or at least before you need to use an instance of those States).
		
		Inheritence can be used to group the logic of certain States. For example,
		the SSGM demo has 'State_Playerstate_Alive' and 'State_Playerstate_Dead'
		constructors which both inherit from the 'State_Playerstate' constructor.
		The latter is never actually initialized as a State instance, but has logic
		for updating the 'state' variable of the Player instance when transitioning
		between being alive/dead. To assist with calling parent methods (for both
		events and transitions), States are equipped with a 'super' method, though
		calling it each frame may be noticeably more performance intensive than
		manually caching the parent's method.
		
	
		CHANGELOG (... -> v0.2.0):
		- Created WIP demo
		- Imported asset tags initialization
		- Extended documentation to explain asset tags
		- Fixed typo in '__states_init__'
		- Removed an extraneous call to removed 'pass' function from '__out__'
		- Re-added initializations 'transitionsTo' and 'transitionsFrom'
		- Replaced calls to removed 'is_defined' function with negations of 'is_undefined'
		- Added 'super' helper method

		
		SSGM uses GMEdit for formatting.
		
		Code by Ilverism :) 					https://github.com/Ilverism/
		v0.2.0
		03/31/24
	
	---------------------------------------------------------------------------------
    */
	
		
	enum STATE_DEFINITION_BEHAVIOR {
	
		GlobalConstant,		//<-- Default behavior. States are held in a global set and can't be redefined inside of it.
		GlobalDynamic,		//<-- States are held in a global set and can be redefined if a new State has the name name as an old one.
		Manual				//<-- States are not held in a global set and should be manually stored as needed.
	
		}
	
	
	//Initialize State System Variables
	__states_init__();

    //Initialize instance variables
    name = _name;   ///@is {string}
	transitionsTo = {}		///@is {struct}
	transitionsFrom = {}	///@is {struct}
    
    //Add this State to the global set if it is not marked as Manual
    if (definitionBehavior != STATE_DEFINITION_BEHAVIOR.Manual) 
    	state_global_set(self, definitionBehavior);
    
    
    #region State -- Getters
    
    ///@static
    ///@returns {string}
    static get_name = function() {
        
        return name;
        
        }
	
	///@static
	///@param {string} eventName
	///@returns {any?}
	static super = function(eventName) {
		
		/*
			Attempts to call a parent's method event with the
			supplied event name, e.g. 'super("draw_gui")'.
		*/

		var eventMethod = static_get(static_get(self))[$ eventName];
		return eventMethod();
		
		}
	
	#endregion
        
    
    #region State -- Setters
    
    ///@static
    ///@param {State} targetState
    ///@param {function} transitionMethod
    static set_transition_to = function(targetState, transitionMethod) {
        
        transitionsTo[$ targetState] = transitionMethod;
        
        }
        
    ///@static
    ///@param {State} targetState
    ///@param {function} transitionMethod
    static set_transition_from = function(targetState, transitionMethod) {
        
        transitionsFrom[$ targetState] = transitionMethod;
        
        }
    
    #endregion
    
    
    #region State -- Transitions
    
    ///@static
    ///@param {string|State} targetStateOrName
    static transition = function(targetStateOrName) {
        
        //Perform generic transition out of current State
        __out__();
        
        //Perform specific transition to target State
		var targetState = (is_string(targetStateOrName) ? state_global_get(targetStateOrName) : targetStateOrName); 
        __to__(targetState);
        
        }
		
    ///@static
    ///@returns {State}
    static load = function() {
        
		__in__();
        
        }
		
    ///@static
    ///@param {State} targetState
    ///@returns {function}
    static __fetch_transition_to__ = function(targetState) {
        
        return transitionsTo[$ targetState.name];
        
        }
            
    ///@static
    ///@param {State} targetState
    ///@returns {function}
    static __fetch_transition_from__ = function(targetState) {
        
        return transitionsFrom[$ targetState.name];
        
        }
	
    ///@static
    static __out__ = function() {
        
        // ...
        
        }
    
    ///@static
    ///@param {State} targetState
    static __to__ = function(targetState) {
        
        //Perform specific transititon method for target state (if it exists)
        var transitionMethod = __fetch_transition_to__(targetState);
        if (!is_undefined(transitionMethod))
            transitionMethod();
        
        //Pass off to next State
        targetState.__transition_from__(self);
        
        }
    
    ///@static
    ///@param {State} targetState
    static __transition_from__ = function(previousState) {
        
        //Perform specific transition form target State
        __from__(previousState);
        
        //Perform generic transition into current State
        __in__();
        
        }
    
    ///@static
    ///@param {State} previousState
    static __from__ = function(previousState) {
        
        //Perform specific transititon method for previous state (if it exists)
        var transitionMethod = __fetch_transition_from__(previousState);
        if (!is_undefined(transitionMethod))
            transitionMethod();
        
        }
        
    ///@static
    static __in__ = function() {
    
        // (Implement ...)
    
        }
    
    #endregion
    
    
    #region State -- Events
    
	/*
		States can be configured to call
		methods inside events if needed,
		but they will have to be manually
		called. Any additional methods of
		your choosing can also be added,
		e.g. begin_step, draw_end, etc.
	*/
	
	///@static
	static step = function() {
		
		// (Implement ...)
		
		}
	
	///@static
	static step_end = function() {
		
		// (Implement ...)
		
		}
	
    
    ///@static
    static draw = function() {
        
        // (Implement ...)
        
        }
    
    ///@static
    static draw_gui = function() {
        
		// (Implement ...)
		
        //Default GUI Drawing method (Debug information)
        draw_set_color(c_black);
        draw_set_alpha(1.00);
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
		
        draw_text(128.00, 128.00, toString());
        
        }
    
    #endregion


    #region State -- Debugging
    
    ///@static
    ///@returns {string}
    static toString = function() {
        
		// (Implement ...)
		
		//Default toString method
        return $"Name: {name}";
        
        }
    
    #endregion

	
	#region State -- Internal
	
	///@static
	static __states_init__ = function() {
	
		static initialized = false;
		
		//Already initialized
		if (initialized)
			return;
			
		initialized = true;
		
		
		global.gStates = {}; ///@is {struct}
		
		}
	
	#endregion

    }