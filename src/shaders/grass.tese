#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];


layout(location = 0) out vec4 pos;
layout(location = 1) out vec4 nor;
layout(location = 2) out vec2 uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec4 a = in_v0[0] + v * (in_v1[0] - in_v0[0]);
    vec4 b = in_v1[0] + v * (in_v2[0] - in_v1[0]);
    vec4 c = a + v * (b - a);
    vec4 t1 = vec4(sin(in_v0[0].w), 0.0, cos(in_v0[0].w), 0.0);
    vec4 c0 = c - in_v2[0].w * t1;
    vec4 c1 = c + in_v2[0].w * t1;
    vec4 t0 = normalize(b - a);
    vec4 n = normalize(vec4(cross(t0.xyz, t1.xyz), 0.0));

    //float t = u; // quad
    //float t = u + 0.5 * v - u * v; // triangle
    //float t = u - u * v * v; // side parabola
    float threshold = 0.5;
    float t = 0.5 + (u - 0.5) * (1 - max(v - threshold, 0.0) / (1.0 - threshold));


    pos = (1 - t) * c0 + t * c1;
    nor = n;
    uv = vec2(u, v);
    gl_Position = camera.proj * camera.view * vec4(pos.xyz, 1.0);

}
