fsm.step();

var horizontal = 0;

if can_move && !cam.panning  && !dash.active {
	if keyboard_check(ctrl_map.left) {
		image_xscale = -1;
	}

	if keyboard_check(ctrl_map.right) {
		image_xscale = 1;
	}

	horizontal = keyboard_check(ctrl_map.right) - keyboard_check(ctrl_map.left);
}

if horizontal != 0 {
	frct = 0.6;	
}

if !cam.panning {
	velocity.x += horizontal;
	velocity.x *= frct;
	
	var target = tilemap;
	
	if grapple.active {
		var dir = point_direction(x, y, grapple.anchor.x, grapple.anchor.y);
		
		velocity.x = lengthdir_x(point_distance(x, y, grapple.anchor.x, grapple.anchor.y) * 0.1, dir);
		velocity.y = lengthdir_y(point_distance(x, y, grapple.anchor.x, grapple.anchor.y) * 0.1, dir);
		
		move_and_collide(velocity.x, velocity.y, tilemap);
	} else {
		if dash.collision {
			move_and_collide(velocity.x, velocity.y, target);
		} else {
			x += velocity.x;
			y += velocity.y;
		}
	}

	if x > (cam.position.x + cam.size.w) {
		cam.chunk.x += 1;
		cam.panning = true;
	}
	
	if x < (cam.position.x) {
		cam.chunk.x -= 1;
		cam.panning = true;
	}
	
	if y > (cam.position.y + cam.size.h) {
		cam.chunk.y += 1;
		cam.panning = true;
	}
	
	if y < (cam.position.y) {
		cam.chunk.y -= 1;
		cam.panning = true;
	}
}

touching.bottom = place_meeting(x, y + 1, tilemap);
touching.left = place_meeting(x - 1, y, tilemap);
touching.right = place_meeting(x + 1, y, tilemap);
touching.top = place_meeting(x, y -1, tilemap);
touching.side = touching.left || touching.right;

// not on ground
if !touching.bottom && !grapple.active{
	if !dash.active {
		if fsm.get_current_state() != "jump"  and fsm.get_current_state() != "wall_slide" {
			fsm.change("jump");
		}
	}
}

// touching sides
if touching.side && dash.collision {
	velocity.x = 0;
	
	if !touching.bottom and !(fsm.get_current_state() = "jump" and velocity.y < -jump_force * 0.9) {
		if fsm.get_current_state() != "wall_slide" {
			grapple.active = false;
			fsm.change("wall_slide");
		}
	}
}

if dash.available && can_move && !grapple.active {
	if keyboard_check_pressed(ctrl_map.up) {
		if !cam.panning {
			if fsm.get_current_state() = "wall_slide" {
				if horizontal = 0 {
					image_xscale = -image_xscale;
				}
			}
			
			fsm.change("dash");
			dash.available = false;
			dash.active = true;
		}
	}
}

if !cam.panning {
	particles.step();
}

if keyboard_check_pressed(ctrl_map.b) {
	if grapple.active {
		grapple.active = false;
		velocity.y *= 0.5;
		fsm.change("jump");
	} else {
		var ang = point_direction(x, y, mouse_x, mouse_y) - 90;
		grapple.anchor.x = mouse_x;
		grapple.anchor.y = mouse_y;
		
		grapple.active = false;
		particles.add_ext(x, y, spr_fx_grapple, 1, 1, round(ang), "over", "stick", [0, -3], self, {
			funct: function(obj, _x, _y) {
				obj.grapple.active = true;
				obj.fsm.change("grapple");
			},
			params: [-5, 0]
		});
	}
}