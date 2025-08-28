if cam.panning {
	var delta = delta_time / 1000;
	var pos = cam.position;

	if (cam.start.x = 0) && (cam.start.y = 0) {
		cam.start.x = pos.x;
		cam.start.y = pos.y;
	}
	
	cam.timer += delta;
	
	var percent = max(cam.timer / cam.duration, 0);
	
	pos.x = lerp(cam.start.x, cam.chunk.x * cam.size.w, percent);
	pos.y = lerp(cam.start.y, cam.chunk.y * cam.size.h, percent);
	
	if cam.timer > cam.duration {
		pos.x = cam.chunk.x * cam.size.w;
		pos.y = cam.chunk.y * cam.size.h;
		
		cam.panning = false;
		cam.timer = 0;
		
		cam.start.x = 0;
		cam.start.y = 0;
	}
}

camera_set_view_pos(view_camera[0], cam.position.x, cam.position.y);