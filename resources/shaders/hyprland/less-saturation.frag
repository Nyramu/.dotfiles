#version 300 es
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

void main() {
    vec4 col = texture(tex, v_texcoord);

    float gamma = 0.85;
    vec3 result = pow(col.rgb, vec3(gamma));

    fragColor = vec4(result, col.a);
}
