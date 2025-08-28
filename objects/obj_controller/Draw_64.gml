draw_set_font(fnt_tachycardia);
draw_set_color(c_lime);

var hist = obj_player.fsm.history_get();

for (var i = 0, _y = 5; i < array_length(hist); i++;) {
	draw_set_alpha(1 - (i / array_length(hist)));
	
	draw_text(5, _y, hist[i]);
	
	_y += 10;
}

draw_set_alpha(1);