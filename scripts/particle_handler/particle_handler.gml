function particle_system() {
	var object = {
		particles: [],
		
		add: method(undefined, function(_x, _y, sprite, _layer) {
			self.add_ext(_x, _y, sprite, 1, 1, 0, _layer);
		}),
		
		add_ext: method(undefined, function(_x, _y, sprite, xscale, yscale, angle, _layer, pos_type = "stay", pos_offsets = [0, 0], obj = self, callback = undefined) {
			array_push(self.particles, {
				x: round(_x),
				y: round(_y),
				sprite: sprite,
				xscale: xscale,
				yscale: yscale,
				angle: angle,
				timer: 0,
				frame: 0,
				layer: _layer,
				pos_type: pos_type,
				pos_offsets: pos_offsets,
				obj: obj,
				callback: callback
			});
		}),
		
		step: method(undefined, function() {
			for (var i = 0; i < array_length(self.particles); i++) {
				var data = self.particles[i];
				var frames = sprite_get_number(data.sprite) - 1;
				var sprite_fps = sprite_get_speed(data.sprite);
				var frame_duration = 1000 / sprite_fps;
				
				if data.pos_type = "stick" {
					data.x = data.obj.x + data.pos_offsets[0];
					data.y = data.obj.y + data.pos_offsets[1];
				}
				
				var delta = delta_time / 1000;
				
				if data.timer > frame_duration {
					if data.frame >= frames {
						if data.callback != undefined {
							if data.callback.params != [] {
								var params = array_concat([data.obj], data.callback.params);
								script_execute_ext(data.callback.funct, params);
							} else {
								script_execute(data.callback.funct);	
							}
						}
						
						array_delete(self.particles, i, 1);
						i++;
					} else {
						data.frame++;
					}
					
					data.timer = 0;
				} else {
					data.timer += delta;
				}
			}
		}),
		
		draw: method(undefined, function(_layer) {
			for (var i = 0; i < array_length(self.particles); i++) {
				var data = self.particles[i];
				
				if data.layer = _layer {
					draw_sprite_ext(data.sprite, data.frame, data.x, data.y, data.xscale, data.yscale, data.angle, c_white, 1);
				}
			}
		})
	}
	
	return object;
}