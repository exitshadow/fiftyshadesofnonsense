// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

/*
    Animate these shapes.

    Combine different shaping functions to cut holes in the shape to make flowers, snowflakes and gears.

    Use the plot() function we were using in the Shaping Functions Chapter to draw just the contour.
*/

vec3 drawFlake(float beat1, float beat2, vec3 targetCol, vec2 pos, float speed, float size, float modulation) {
    vec3 col;
    float radius = length(pos)*size;
    float angle = atan(pos.x, pos.y) + speed;
    float flake = smoothstep(-beat1*modulation, clamp(beat2 * 2.3, 3., 1.5), cos(angle * 6.)) * 0.2 + 0.3;
    col = vec3( 1. - smoothstep(flake, flake + modulation / 10., radius) );
    col *= targetCol;
    return col;
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    //st.y *= 1.3;
    vec3 color = vec3(0.0);
    float speed = u_time * .3;

    float beatmaster = .3;

    float beat1 = abs(cos(u_time*beatmaster));
    float beat2 = abs(sin(u_time*beatmaster));

    vec2 pos = vec2(0.5)-st;

    float r = length(pos)*3.0;
    float a = atan(pos.y,pos.x) + speed ;

    float f;
    f = smoothstep(-beat1*3., clamp(beat2 * 2.3, 3.1,1.3), cos(a*10.))*0.2+0.3;

    // color = vec3( 1.-smoothstep(f,f+0.3,r) );

    vec3 flake = drawFlake(beat1, beat2, vec3(1.,.0,.0), pos, speed, 1.8, 3.);

    vec3 flake2 = drawFlake(beat1, beat2, vec3(0.,1.0,.0), pos, speed*.96, 2., 3.3);

    vec3 flake3 = drawFlake(beat1, beat2, vec3(0.,.0,1.0), pos, speed*.74, 1.7, 2.3);

    flake += flake2;
    flake += flake3;

    gl_FragColor = vec4(flake, 1.0);
}
