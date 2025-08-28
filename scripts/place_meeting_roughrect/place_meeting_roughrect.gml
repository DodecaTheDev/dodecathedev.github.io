function place_meeting_roughrect(x1, y1, x2, y2, obj, draw = false) {
	if draw {
		draw_set_color(place_meeting(x1, y1, obj) ? c_orange : c_red);
		draw_point(x1, y1);
	
		draw_set_color(place_meeting(x2, y1, obj) ? c_orange : c_red);
		draw_point(x2, y1);
	
		draw_set_color(place_meeting(x1, y2, obj) ? c_orange : c_red);
		draw_point(x1, y2);
	
		draw_set_color(place_meeting(x2, y2, obj) ? c_orange : c_red);
		draw_point(x2, y2);
	}
	
	return place_meeting(x1, y1, obj) ||
	place_meeting(x2, y1, obj) ||
	place_meeting(x1, y2, obj) ||
	place_meeting(x2, y2, obj);
}