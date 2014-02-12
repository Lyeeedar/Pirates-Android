#ifdef GL_ES
	precision mediump float;
#endif

uniform vec3 u_al_col;
uniform vec3 u_pl_pos[4];
uniform vec3 u_pl_col[4];
uniform float u_pl_att[4];

uniform sampler2D u_texture1;
uniform sampler2D u_texture2;
uniform sampler2D u_texture3;
uniform sampler2D u_texture4;

uniform vec3 fog_col;
uniform float fog_min;
uniform float fog_max;

varying vec3 v_pos;
varying vec3 v_viewDir;
varying float v_vposLen;
varying vec3 v_normal;

varying vec3 v_splat_opacities;

vec3 splat(vec3 t1, vec3 t2, float a2)
{
	return mix(t1, t2, a2);
}

vec3 calculateLight(vec3 l_vector, vec3 n_dir, float l_attenuation, vec3 l_col, float shininess, vec3 s_col, vec3 v_dir)
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
		vec3 spec_light = l_col * s_col * attenuation * pow( max( 0.0, dot( reflect( -l_dir, n_dir ), v_dir ) ), shininess);
		light += spec_light;
	}

	light = clamp(light, 0.0, 1.0);
 
	return light;
}


void main()
{	
	float shininess = 0.0;
	vec3 s_col = vec3(1.0);
	vec3 normal = normalize(v_normal);
	vec3 v_dir = normalize(v_viewDir);

	vec3 light = u_al_col;

	for ( int i = 0; i < 4; i++ ) 
	{
		vec3 light_model = u_pl_pos[i] - v_pos;
		light += calculateLight(light_model, normal, u_pl_att[i], u_pl_col[i], shininess, s_col, v_dir);
	}

	light = clamp(light, 0.0, 1.0);

	float fog_fac = (v_vposLen - fog_min) / (fog_max - fog_min);
	fog_fac = clamp (fog_fac, 0.0, 1.0);

	float texop = 1.0 - clamp(v_splat_opacities.r+v_splat_opacities.g+v_splat_opacities.b, 0.0, 1.0);

	vec3 tex = texture2D(u_texture1, v_pos.xz/10.0).rgb * texop;
	tex = splat(tex, texture2D(u_texture2, v_pos.xz/10.0).rgb, v_splat_opacities.r);
	tex = splat(tex, texture2D(u_texture3, v_pos.xz/10.0).rgb, v_splat_opacities.g);
	tex = splat(tex, texture2D(u_texture4, v_pos.xz/10.0).rgb, v_splat_opacities.b);

	vec3 col = tex * light;

	gl_FragColor = mix(vec4(col, 1.0), vec4(fog_col, 1.0), fog_fac);
}