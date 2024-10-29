#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 nor;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec4 tipColor = vec4(0.31, 0.74, 0.54, 1.0);
    vec4 baseColor = vec4(0.06, 0.42, 0.25, 1.0);
    outColor = mix(baseColor, tipColor, uv.y);

    //outColor = vec4(0.06, 0.42, 0.25, 1.0);
}
