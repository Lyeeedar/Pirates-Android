#ifdef GL_ES
    precision mediump float;
#endif

varying vec4 v_color;
varying vec2 v_texCoords;
uniform sampler2D u_texture;
uniform float limit;

const vec3 W = vec3(0.2125, 0.7154, 0.0721);

float intensity(in vec4 color)
{
    return color.xyz * W;//sqrt((color.x*color.x)+(color.y*color.y)+(color.z*color.z));
}
 
float sobel(float offset, vec2 center)
{
    // get samples around pixel
    float tleft = intensity(texture2D(u_texture,center + vec2(-offset,offset)));
    float left = intensity(texture2D(u_texture,center + vec2(-offset,0)));
    float bleft = intensity(texture2D(u_texture,center + vec2(-offset,-offset)));
    float top = intensity(texture2D(u_texture,center + vec2(0,offset)));
    float bottom = intensity(texture2D(u_texture,center + vec2(0,-offset)));
    float tright = intensity(texture2D(u_texture,center + vec2(offset,offset)));
    float right = intensity(texture2D(u_texture,center + vec2(offset,0)));
    float bright = intensity(texture2D(u_texture,center + vec2(offset,-offset)));
 
    // Sobel masks (to estimate gradient)
    //        1 0 -1     -1 -2 -1
    //    X = 2 0 -2  Y = 0  0  0
    //        1 0 -1      1  2  1
 
    float x = tleft + 2.0*left + bleft - tright - 2.0*right - bright;
    float y = -tleft - 2.0*top - tright + bleft + 2.0 * bottom + bright;
    float color = sqrt((x*x) + (y*y));
    if (color > 0.1){return 0.0;}
    return 1.0;
 }
 
void main(void)
{
    float offset = 1.0/1000.0;
    gl_FragColor.rgb = sobel(offset, v_texCoords);
    gl_FragColor.a = 1.0;
}