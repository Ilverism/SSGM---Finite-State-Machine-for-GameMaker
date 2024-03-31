
//Initialize Player State Variables
asset_tags_init("Asset_Playerstate");
state = state_global_load("Playerstate_Dead");


//Initialize Player Attribute Variables
velocityHorizontal = 0.00;  ///@is {number}
velocityVertical   = 0.00;  ///@is {number}

rollAngle = 0.00;   ///@is {number}
rollFriction = 1.00575;    ///@is {number}

jumpStrength = 4.00; ///@is {number}
gravityStrength = 9.81;	///@is {number}