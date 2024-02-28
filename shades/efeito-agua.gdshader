shader_type canvas_item;

uniform sampler2D screen_texture :  filter_linear_mipmap;

uniform sampler2D ruido1 : repeat_enable;
uniform sampler2D ruido2 : repeat_enable;

uniform vec2 rolagem1 = vec2(0.05, 0.05);
uniform vec2 rolagem2 = vec2(-0.05, -0.05);
uniform float forca_distorcao : hint_range(0.0, 1.0) = 0.1;
uniform vec4 tom_cores : source_color;
uniform vec4 cor_topo : source_color;
uniform float luz_inicial: hint_range(0.0,1.0) = 0.275;
uniform float luz_final : hint_range(0.0, 1.0) = 0.4;

void fragment() {
	float profundidade = texture(ruido1, UV + rolagem1 * TIME).r +
	 texture(ruido2, UV + rolagem2 * TIME).r;
	
	vec4 coluna_rolagem = texture(screen_texture , 
	SCREEN_UV + forca_distorcao * vec2(profundidade) );
	
	vec4 luz_topo = smoothstep( luz_final, luz_inicial,profundidade)*cor_topo;
	
	COLOR = coluna_rolagem* tom_cores+luz_topo;
	COLOR.a= 1.0;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
