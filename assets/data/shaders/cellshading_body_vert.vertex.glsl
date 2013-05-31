
attribute vec3 a_position;
attribute vec3 a_normal; 
attribute vec2 a_texCoord0;

uniform vec3 u_al_col;
uniform vec3 u_dl_dir;
uniform vec3 u_dl_col;
uniform vec3 u_pl_pos[4];
uniform vec3 u_pl_col[4];
uniform float u_pl_att[4];

uniform mat4 u_pv;
uniform mat4 u_mm;
uniform mat3 u_nm;
uniform vec3 u_colour;

varying vec2 v_texCoords;
varying vec3 v_light;

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
	vec4 worldPos = u_mm * vec4(a_position, 1.0);
	gl_Position = u_pv * worldPos;

	vec3 pos = worldPos.xyz;
	vec3 normal = normalize(u_nm * a_normal);

	float brightness = calculateLight(u_dl_dir, normal, 0.0);
	vec3 light = u_al_col + (u_dl_col * brightness);
	float intensity = brightness;

	for ( int i = 0; i < 4; i++ ) {
		vec3 light_model = u_pl_pos[i] - pos;

		brightness = calculateLight(light_model, normal, u_pl_att[i]);

		if (brightness > 0.0)
		{
			intensity += brightness;
			light += u_pl_col[i] * brightness;
		}
	}

	light = normalize(light);

	float factor = 1.0;

	if (intensity < 0.5) {
		factor = 0.5;
	}

	v_texCoords = a_texCoord0;
	v_light = u_colour * light * factor;
}