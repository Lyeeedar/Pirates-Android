#ifdef GL_ES
    precision mediump float;
#endif

varying vec4 v_color;
varying vec2 v_texCoords;
uniform sampler2D u_texture;
uniform float u_far;

void main() {

	vec4 colour = texture2D(u_texture, v_texCoords);

	float z = ( colour.r * 2.0 ) - 1.0;

    gl_FragColor.rgb = z;
    gl_FragColor.a = 1.0;
}