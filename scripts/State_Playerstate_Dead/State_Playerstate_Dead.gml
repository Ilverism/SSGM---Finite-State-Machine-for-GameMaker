function State_Playerstate_Dead() : State_Playerstate("Playerstate_Dead") constructor {
	

	#region Playerstate Dead -- Events
	
	///@static
	static step = function() {
		
		with(other) {	//<-- Access the calling Player instance from this Playerstate instance
			
			//Respawn
			if (keyboard_check_pressed(vk_space)) { 
			
				state.transition("Playerstate_Alive");
			
				}
				
			}
		
		}
	
	///@static
	static draw_gui = function() {
				
				
		super("draw_gui");
		
				
		//Draw death overlay
		var guiWidth  = display_get_gui_width();
		var guiHeight = display_get_gui_height();
		var guiCenter = (guiWidth / 2);
		var guiMiddle = (guiHeight / 2);
		
		draw_set_color(c_black);
		draw_set_alpha(0.50);
		draw_rectangle(
			0.00, 0.00,
			guiWidth, guiHeight,
			false
			);

		draw_set_color(c_red);
		draw_set_alpha(1.00);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(
			guiCenter, guiMiddle,
			"Dead!"
			);
			
		draw_set_color(c_white);
		draw_text(
			guiCenter, guiMiddle + 256,
			"Press [SPACE] to respawn"
			);
			
		
		
		}
	
	#endregion
	
	}