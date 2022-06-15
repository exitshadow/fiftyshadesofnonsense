// exercise
// to make something alla mondriana


// steps

// 1 function per line, horizontal or vertical
// use floor and ceiling to force values in

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

void main() {

//y = mod(x,0.5); // return x modulo of 0.5
//y = fract(x); // return only the fraction part of a number
//y = ceil(x);  // nearest integer that is greater than or equal to x
//y = floor(x); // nearest integer less than or equal to x
//y = sign(x);  // extract the sign of x
//y = abs(x);   // return the absolute value of x
//y = clamp(x,0.0,1.0); // constrain x to lie between 0.0 and 1.0
//y = min(0.0,x);   // return the lesser of x and 0.0
//y = max(0.0,x);   // return the greater of x and 0.0 

    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    vec3 col = vec3(1.,1.,1.);

    float line_1 = step(.9, uv.x) + step(0.13, 1.-uv.x);
    float line_2 = step(.3, uv.x) + step(0.74, 1.-uv.x);
    float line_3 = step(.2, uv.x) + step(0.85, 1.-uv.x);

    float line_4 = step(.7, uv.y) + step(0.33, 1.-uv.y);
    float line_5 = step(.05, uv.y) + step(0.97, 1.-uv.y);

    col *= line_1 * line_2 * line_3 * line_4 * line_5;

    float redRec = step(.0, uv.x) - step(.2, uv.x);
    redRec *= step(0.7, uv.y);

    float blueRec = step(.0, uv.x) - step(.1, 1.-uv.x);
    //blueRec *= step(0.7, uv.y);
    
    col.bg -= redRec;

    col.rg -= blueRec;

    gl_FragColor = vec4(col, 1.);


}