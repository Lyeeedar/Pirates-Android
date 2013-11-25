#ifdef GL_ES
	precision mediump float;
#endif
			
uniform sampler2D glow;
uniform sampler2D color;

uniform vec3 sun_dir;

varying vec3 v_pos;

void main()
{
    vec3 V = normalize(v_pos);
    vec3 L = normalize(sun_dir);

    // Compute the proximity of this fragment to the sun.

    float vl = dot(V, L);

    // Look up the sky color and glow colors.

    vec4 Kc = texture2D(color, vec2((L.y + 1.0) / 2.0, (V.y - 1.0) * -1.0));
    vec4 Kg = texture2D(glow,  vec2(vl, (L.y + 1.0) / 2.0));

    // Combine the color and glow giving the pixel value.

    gl_FragColor = vec4( (Kc.rgb + (Kg.rgb * Kg.a)) / 2.0, Kc.a);
}