
//Draw recorded transitions
var transitionCount = array_length(stateTransitionsList);

var transitionCountThreshold = 16;
var transitionCountDiff = (transitionCount - transitionCountThreshold);
var transitionIndexLow = max(0, transitionCountDiff);
var transitionIndexHigh = min(transitionCount, transitionCountThreshold+transitionCountDiff);

var transitionStringWhole/*:string*/ = "";
for(var i = transitionIndexLow ; i < transitionIndexHigh ; i++) {
	
	transitionStringWhole += $"\n{i}. {stateTransitionsList[i]}";
	
	}

var xDrawPos = 64;
var yDrawPos = display_get_gui_height() - 64;

draw_set_color(c_blue);
draw_set_alpha(1.00);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(
	xDrawPos, yDrawPos,
	transitionStringWhole
	);