// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

/*Basically we are using a re-interpretation of the space (based on the distance to the center) to make shapes. This technique is known as a “distance field” and is used in different ways from font outlines to 3D graphics.

Try the following exercises:

    Use step() to turn everything above 0.5 to white and everything below to 0.0.

    Inverse the colors of the background and foreground.

    Using smoothstep(), experiment with different values to get nice smooth borders on your circle.

    Once you are happy with an implementation, make a function of it that you can reuse in the future.

    Add color to the circle.

    Can you animate your circle to grow and shrink, simulating a beating heart? (You can get some inspiration from the animation in the previous chapter.)

    What about moving this circle? Can you move it and place different circles in a single billboard?
    What happens if you combine distances fields together using different functions and operations?
*/

float drawCircle(vec2 uv, vec2 pos, float radius, float thickness){
    float dist = distance(uv, pos);

    float circle = step(radius, dist);
    float innerCircle = step(radius + thickness, 1.-dist);

    circle += innerCircle;

    return circle ;
}

float fluffCircle(vec2 uv, vec2 pos, float radius, float thickness){
    float dist = distance(uv, pos);
    float circle = smoothstep(radius, thickness, dist);

    circle = -1. * (circle -1. );

    return circle ;
}

float reverseFluffCircle(vec2 uv, vec2 pos, float radius, float thickness) {
    float dist = distance(uv, pos);

    float circle = step(radius, dist);
    float innerFluff = smoothstep(radius, thickness, dist);

    circle += innerFluff;

    return circle;
}

float fluffRing(vec2 uv, vec2 pos, float radius, float thickness) {
    float dist = distance(uv, pos);
    float circle = smoothstep(radius, radius - thickness, dist);
    circle = -1. * (circle -1. );

    float innerCircle = smoothstep(radius, radius - thickness - thickness, dist);

    circle += innerCircle;

    //circle = clamp(circle, 0.,1.);

    return circle;
}

void main(){
	vec2 st = gl_FragCoord.xy/u_resolution;
    st.y *= 1.25;
    float pct = drawCircle(st, vec2( .3, .5 ), .5, .06);

    pct = fluffRing(st, vec2( .3, .5 ), .5, .04);

    vec3 color = vec3(pct);

	gl_FragColor = vec4( color, 1.0 );
}
