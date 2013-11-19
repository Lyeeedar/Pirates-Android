attribute vec3 a_position;

const float pi = 3.14159;

uniform float delta;
uniform int numWaves;
uniform float amplitude[8];
uniform float wavelength[8];
uniform float speed[8];
uniform vec2 direction[8];

uniform vec3 u_position;
uniform mat4 u_mvp;

varying vec2 v_pos;

float wave(int i, float x, float y) 
{
    float frequency = 2.0*pi/wavelength[i];
    float phase = speed[i] * frequency;
    float theta = dot(direction[i], vec2(x, y));
    return amplitude[i] * sin(theta * frequency + delta * phase);
}

float waveHeight(float x, float y) 
{
    float height = 0.0;
    for (int i = 0; i < numWaves; ++i)
        height += wave(i, x, y);
    return height;
}
			
void main() 
{
    vec4 position = vec4(a_position.x+u_position.x, 0.0, a_position.z+u_position.z, 1.0);
    position.y = a_position.y+waveHeight(position.x, position.z);
	gl_Position = u_mvp * position;

    v_pos = vec2(position.x/50.0, position.z/50.0);
}