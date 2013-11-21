#ifdef GL_ES
	precision mediump float;
#endif

uniform vec3 u_al_col;
uniform vec3 u_dl_dir;
uniform vec3 u_dl_col;
uniform vec3 u_pl_pos[4];
uniform vec3 u_pl_col[4];
uniform float u_pl_att[4];

uniform sampler2D u_texture;

uniform vec3 fog_colour;
uniform float fog_min;
uniform float fog_max;

varying vec3 v_pos;
varying float v_vposLen;
varying vec3 v_normal;

float calculateLight(vec3 l_vector, vec3 n_dir, float l_attenuation)
{
    float distance = length(l_vector);
    vec3 l_dir = l_vector / distance;

    float NdotL = dot( n_dir, l_dir );

    float attenuation = 1.0;
	if (l_attenuation != 0.0)
	{
    	attenuation = 1.0 / (l_attenuation*distance);
	}

	float light = NdotL * attenuation;

	if (light < 0.0) {
		light = 0.0;
	}
 
	return light;
}
			
void main() 
{
	float brightness = calculateLight(u_dl_dir, v_normal, 0.0);
	vec3 light = u_al_col + (u_dl_col * brightness);
	float intensity = brightness;

	for ( int i = 0; i < 4; i++ ) {
		vec3 light_model = u_pl_pos[i] - v_pos;

		brightness = calculateLight(light_model, v_normal, u_pl_att[i]);

		if (brightness > 0.0)
		{
			intensity += brightness;
			light += u_pl_col[i] * brightness;
		}
	}

	//light = normalize(light);

	float factor = 1.0;

	if (intensity < 0.5) {
		factor = 0.5;
	}

	float fog_fac = (v_vposLen - fog_min) / (fog_max - fog_min);
	fog_fac = clamp (fog_fac, 0.0, 1.0);

	vec3 col = texture2D(u_texture, v_pos.xz/50.0).rgb * light * factor;

	gl_FragColor = mix(vec4(col, 1.0), vec4(fog_colour, 1.0), fog_fac);
}