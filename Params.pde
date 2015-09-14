/** Params for UI drawing */

int window_width=800, window_height=600;
float icon_x=window_width*0.05,icon_y=window_height*0.06667;  //40,40
float board_x=window_width*0.25,board_y=window_height*0.16667;   //200,100

float blue_cd_x=window_width*0.05,red_cd_x=window_width*0.05,  blue_cd_y=window_height*0.3583,red_cd_y=window_height*0.8583;   //40,40,215,515
float textcd_x=window_width*0.0125,textcd_y=window_height*0.2833;  //10,170
float textcdsize=window_width*window_height*0.0000625;  //30

float textwin_x=window_width*0.2625,textwin_y=window_height*0.10833;   //210,65
float textwinsize=window_width*window_height*0.000625/6;  //50

float[][] PLAYER_CD_LOC = {{window_width*0.05, window_height*0.3583}, {window_width*0.05, window_height*0.8583}};

final int IMAGE_BRICK 			= 0;
final int IMAGE_SELECTED_BRICK 	= 1;
final int IMAGE_COIN 			= 2;
final int IMAGE_BOMB 			= 3;
final int IMAGE_THOMAS_BLUE		= 4;
final int IMAGE_THOMAS_RED 		= 5;
final int IMAGE_THOMAS_BG 		= 6;
final int IMAGE_RAIL_I 			= 7;
final int IMAGE_RAIL_I2			= 8;
final int IMAGE_RAIL_L 			= 9;
final int IMAGE_RAIL_L2			= 10;
final int IMAGE_RAIL_L3			= 11;
final int IMAGE_RAIL_L4			= 12;
final int IMAGE_CD 				= 13;

final int DIR_NORTH = 0;
final int DIR_EAST 	= 1;
final int DIR_SOUTH	= 2;
final int DIR_WEST 	= 3;

final int RAIL_I  = 7;
final int RAIL_I2 = 8;
final int RAIL_L  = 9;
final int RAIL_L2 = 10;
final int RAIL_L3 = 11;
final int RAIL_L4 = 12;

final int BOMB_GENERATER_TIME 	= 100;
final int SCORE_LIMIT 			= 10;

final int[][][] TAG_GAUSS = {
	{ // Player 1
		{1, 1, 1, 1, 1},
		{2, 2, 2, 2, 2}
	},
	{ // Player 2
		{3, 3, 3, 3, 3},
		{4, 4, 4, 4, 4}
	}
};