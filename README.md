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
