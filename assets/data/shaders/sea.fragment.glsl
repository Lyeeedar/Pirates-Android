#ifdef GL_ES
	precision mediump float;
#endif

uniform vec3 u_al_col;
uniform vec3 u_dl_dir;
uniform vec3 u_dl_col;
uniform vec3 u_pl_pos[4];
uniform vec3 u_pl_col[4];
uniform float u_pl_att[4];
			
uniform vec3 u_colour;

uniform sampler2D u_texture;

uniform vec3 fog_col;
uniform float fog_min;
uniform float fog_max;

varying vec3 v_pos;
varying vec3 v_viewDir;
varying float v_vposLen;
varying vec3 v_normal;
varying float v_depth;

vec3 calculateLight(vec3 l_vector, vec3 n_dir, float l_attenuation, vec3 l_col, float shininess, vec3 s_col)
{
    float distance = length(l_vector);
    vec3 l_dir = l_vector / distance;

    float NdotL = dot( n_dir, l_dir );

    float attenuation = 1.0;
	if (l_attenuation != 0.0)
	{
    	attenuation = 1.0 / (l_attenuation*distance);
	}

	vec3 light = l_col * NdotL * attenuation;

	if (NdotL > 0.0 && shininess > 0.0)
	{
		vec3 spec_light = l_col * s_col * attenuation * pow( max( 0.0, dot( reflect( -l_dir, n_dir ), v_viewDir ) ), shininess);
		light += spec_light;
	}

	light = clamp(light, 0.0, 1.0);
 
	return light;
}


void main()
{	
	float shininess = 100.0;
	vec3 s_col = vec3(1.0);

	vec3 light = u_al_col + calculateLight(u_dl_dir, v_normal, 0.0, u_dl_col, shininess, s_col);

	for ( int i = 0; i < 4; i++ ) 
	{
		vec3 light_model = u_pl_pos[i] - v_pos;
		light += calculateLight(light_model, v_normal, u_pl_att[i], u_pl_col[i], shininess, s_col);
	}

	light = clamp(light, 0.0, 1.0);

	float fog_fac = (v_vposLen - fog_min) / (fog_max - fog_min);
	fog_fac = clamp (fog_fac, 0.0, 1.0);

	vec3 seaCol = texture2D(u_texture, v_pos.xz/50.0).rgb * u_colour * light;
	seaCol -= vec3(0.05*v_depth);

	gl_FragColor = mix(vec4(seaCol, 1.0), vec4(fog_col, 1.0), fog_fac);
}