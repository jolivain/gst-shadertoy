//#version 100

#ifdef GL_ES
precision mediump float;
#endif

//1.50, 3.30, 1.00 ES, and 3.00 ES

// glslsandbox uniforms
uniform float time;
uniform float width;
uniform float height;
uniform sampler2D tex;

// shadertoy globals
vec3  iResolution = vec3(0.0);
float iGlobalTime = 0.0;
vec3  iMouse = vec3(0.0);
vec4  iDate = vec4(0.0);

#define iChannel0 tex

// Protect gst uniform names
#define time        gstemu_time
#define width       gstemu_width
#define height      gstemu_height

// Thanks GregRostami!
void mainImage( out vec4 c , vec2 u ) {
    u /= iResolution.xy;
    c = texture2D(iChannel0, u + vec2(sin(u.y * 25. + iDate.w) / 30., 0));
}

#undef time
#undef width
#undef height

void main(void)
{
  iResolution = vec3(width, height, 0.0);
  iGlobalTime = time;
  iDate.w = time;

  mainImage(gl_FragColor, gl_FragCoord.xy);
}
