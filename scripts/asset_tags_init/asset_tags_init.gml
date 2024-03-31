///@param {string|array<string>}	tagStringOrArray
function asset_tags_init(tagStringOrArray) {

	var tagAssetNames/*:array<string>*/ = tag_get_assets(tagStringOrArray);
	var tagAssetCount/*:int*/ = array_length(tagAssetNames);
	
	var tagAssetNameCur/*:string*/;
	var tagAssetCur/*:asset*/;
	
	var tagsAdjacent/*:array<string>*/;
	var tagsAdjacentCount/*:int*/;
	var tagAdjacentCur;
	
	for(var i = 0 ; i < tagAssetCount ; i++) {
	
		tagAssetNameCur = tagAssetNames[i];
		tagAssetCur = asset_get_index(tagAssetNameCur);
	
		var isSingletonInstance = false;
		var isInitializableInstance = false;
	
		//Check if the target asset is marked as singleton
		tagsAdjacent = asset_get_tags(tagAssetNameCur);
		tagsAdjacentCount = array_length(tagsAdjacent);
		for(var j = 0 ; j < tagsAdjacentCount ; j++) {
			
			tagAdjacentCur = tagsAdjacent[j];
			
			//Found singleton tag
			if (tagAdjacentCur == "Singleton") {
				isSingletonInstance = true;
				break;
				}
				
			//Found initializable tag
			else if (tagAdjacentCur == "Initializable") {
				
				isInitializableInstance = true;
				break;
				
				}
				
			}
	
		//Target script asset is a singleton constructor, initialize it with 'new'
		if (isSingletonInstance) {
			new tagAssetCur();
			continue;
			}
		
	
		//Target script asset is an initializable constructor, initialize it with 'new'
		if (isInitializableInstance) {			
			var tempInstance = new tagAssetCur();
			delete tempInstance;
			continue;
			}
		
		//Standard call to target script
		tagAssetCur();
	
		}
		
	}