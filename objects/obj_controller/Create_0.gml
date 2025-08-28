var player_chunk = chunk_pos(obj_player.x, obj_player.y);

global.camera = {
	position: {
		x: player_chunk.x * 160,
		y: player_chunk.y * 144
	},
	chunk: {
		x: player_chunk.x,
		y: player_chunk.y
	},
	start: {
		x: 0,
		y: 0
	},
	size: {
		w: 160,
		h: 144
	},
	timer: 0,
	duration: 800,
	panning: false
};

global.controls = {
	left: vk_left,
	right: vk_right,
	up: vk_up,
	down: vk_down,
	a: ord("Z"),
	b: ord("X"),
	start: vk_enter,
	select: vk_rshift,
};

#macro ctrl_map global.controls
#macro cam global.camera

scale = 6;

var camera_width = camera_get_view_width(view_camera[0]);
var camera_height = camera_get_view_height(view_camera[0]);

window_set_size(camera_width * scale, camera_height * scale);
window_center();

// tile stuff
var layer_name = "Tiles";
var layer_id = layer_get_id(layer_name);
layer_set_visible(layer_name, false);

tilemap_id = layer_tilemap_get_id(layer_id);

