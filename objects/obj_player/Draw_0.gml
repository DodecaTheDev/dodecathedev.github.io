particles.draw("under");

draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);

particles.draw("over");

if grapple.active {
	draw_set_color(#E9EFEC);
	
	var angle = point_direction(x, y, grapple.anchor.x, grapple.anchor.y);
	
	draw_line(x, y - 3, grapple.anchor.x, grapple.anchor.y);
}