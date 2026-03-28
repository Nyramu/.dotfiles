#version 300 es
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

void main() {
    vec4 col = texture(tex, v_texcoord);

    float max_val = max(col.r, max(col.g, col.b));
    float min_val = min(col.r, min(col.g, col.b));
    
    float sat = max_val - min_val;
    float luma = dot(col.rgb, vec3(0.2126, 0.7152, 0.0722));

    float vibrance = 0.8;
    float amount = vibrance * (1.0 - sat);

    vec3 result = mix(vec3(luma), col.rgb, 1.0 + amount);

    fragColor = vec4(result, col.a);
}
