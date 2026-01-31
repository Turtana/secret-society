shader_type canvas_item;

uniform vec4 tint_color : source_color = vec4(1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // How close the pixel is to white
    //float whiteness = min(min(tex.r, tex.g), tex.b);
	float whiteness = step(0.95, min(min(tex.r, tex.g), tex.b));

    // Mix original with tinted version based on whiteness
    vec3 tinted = tex.rgb * tint_color.rgb;
    vec3 final_color = mix(tex.rgb, tinted, whiteness);

    COLOR = vec4(final_color, tex.a);
}