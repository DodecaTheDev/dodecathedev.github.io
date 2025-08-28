var layer_name = "Tiles";
var layer_id = layer_get_id(layer_name);
tilemap = layer_tilemap_get_id(layer_id);

jump_force = 2;

velocity = {
	x: 0,
	y: 0
};

touching = {
	top: false,
	bottom: false,
	left: false,
	right: false,
	side: false
}

velocity_state = 0;
grav = 0.4;
frct = 0.6;

slide_friction = 0.2;
slide_timer = 0;
slide_duration = 250;

can_move = true;

grapple = {
	active: false,
	anchor: {
		x: 0,
		y: 0
	}
}

dash = {
	active: false,
	available: true,
	timer: 0,
	duration: 300,
	goal: {
		x: 0,
		y: 0
	},
	collision: true
};

particles = particle_system();

// idle state
fsm = new SnowState("jump");

fsm.history_enable();
fsm.history_set_max_size(12);

fsm.add("idle", {
	enter: function() {
		sprite_index = spr_player_idle;
		image_index = 0;
		dash.active = false;
		dash.available = true;
	},
	
	step: function() {
		if can_move {
			if keyboard_check(ctrl_map.left) xor keyboard_check(ctrl_map.right) {
				fsm.change("walk");
			}
		
			if keyboard_check_pressed(ctrl_map.a) {
				fsm.change("jump");
				particles.add_ext(x, y, spr_fx_smoke, image_xscale, 1, 0, "over");
				velocity.y = -jump_force;
			}
		}
	}
});

// walk state
fsm.add("walk", {
	enter: function() {
		sprite_index = spr_player_walk;
		image_index = 0;
		slide_duration = 125;
		slide_timer = slide_duration;
	},
	step: function() {
		var delta = delta_time / 1000;
		slide_timer += delta;
		
		if !(keyboard_check(ctrl_map.left) xor keyboard_check(ctrl_map.right)) {
			if !cam.panning {
				fsm.change("idle");
			}
		}
		
		if slide_timer > slide_duration {
			slide_timer = 0;
			particles.add_ext(x - (2 * image_xscale), y, spr_fx_walk_smoke, -image_xscale, 1, 0, "over");
		}
		
		if can_move {
			if keyboard_check_pressed(ctrl_map.a) {
				fsm.change("jump");
				particles.add(x, y, spr_fx_smoke, image_xscale, 1, "over");
				velocity.y = -jump_force;
			}
		}
	}
});

// grapple state
fsm.add("grapple", {
	enter: function() {
		sprite_index = spr_player_dash;
		image_index = 0;
	},
	step: function() {
		
	}
});

// dash state
fsm.add("dash", {
	enter: function() {
		sprite_index = spr_player_dash;
		image_index = 0;
		dash.available = true;
		dash.active = false;
		velocity.y = 0;
		velocity.x = 8 * image_xscale;
		
		frct = 0.9;
		dash.timer = 0;
		
		// dash is roughly 7.5 frames, so you multiply the distance by 7.5
		dash.goal.x = x + (velocity.x * 7.5);
		dash.goal.y = y + (velocity.y * 7.5);
		
		dash.collision = place_meeting_roughrect(dash.goal.x - 4, y, dash.goal.x + 4, y, tilemap);
		
		if !dash.collision {
			if (dash.goal.x < 0)	|| (dash.goal.x > room_width) {
				dash.collision = true;	
			}
		}
	},
	step: function() {
		if !cam.panning {
			var delta = delta_time / 1000;
			dash.timer += delta;
		}
		
		if dash.timer > dash.duration {
			if !place_meeting(x, y, tilemap) {
				fsm.change("jump");
			}
		}	
	},
	leave: function() {
		dash.active = false;
		dash.collision = true;
	}
});

// wall slide & jump state
fsm.add("wall_slide", {
	enter: function() {
		sprite_index = spr_player_wall_slide;
		image_index = 0;
		velocity.y = slide_friction;
		dash.available = true;
		slide_duration = 250;
		slide_timer = slide_duration;
	},
	step: function() {
		var delta = delta_time / 1000;
		
		slide_timer += delta;
		
		if slide_timer > slide_duration {
			particles.add_ext(x, y, spr_fx_slide_smoke, -image_xscale, 1, 0, "over");
			slide_timer = 0;
		}
		
		if !touching.side {
			velocity.y = 0;
			fsm.change("jump");
		}
		
		if touching.bottom {
			velocity.y = 0;
			fsm.change("idle")	
		}
		
		if touching.left {
			image_xscale = -1;	
		} else if touching.right {
			image_xscale = 1;	
		}
		
		if keyboard_check_pressed(ctrl_map.a) {
			velocity.y = -jump_force;
			particles.add_ext(x + (4 * image_xscale), y, spr_fx_smoke, image_xscale, 1, 90 * image_xscale, "over");
			velocity.x = -5 * image_xscale;
			frct = 0.85;
			
			fsm.change("jump");
		}
	}
});

// jump state
fsm.add("jump", {
	enter: function() {
		sprite_index = spr_player_jump;
		dash.active = false;
	},
	step: function() {
		var delta = delta_time / 100000;
		
		image_index = 0;
		
		// when going upward
		if velocity.y < 0 {
			image_index = 0
		}
		
		// when nearing jump apex
		if velocity.y > -jump_force / 2 {
			image_index = 1
			
			// when falling down
			if velocity.y > jump_force / 2 {
				frct = 0.6;
				image_index = 2
			}
		}
		
		if !cam.panning {
			velocity.y += grav * delta;
		}
		
		// touching floor
		if touching.bottom {
			velocity.y = 0;
			fsm.change("idle");
		}
		
		// touching ceiling
		if touching.top {
			if !touching.bottom {
				y += 1;
			}
			
			velocity.y = max(velocity.y, 0);
		}
	}
});

