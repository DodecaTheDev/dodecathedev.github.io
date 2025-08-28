function chunk_pos(pos_x, pos_y) {
	return {
		x: floor(pos_x / 160),
		y: floor(pos_y / 144)
	};
}
