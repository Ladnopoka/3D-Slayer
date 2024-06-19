RSRC                    VisualShader            ��������                                            X      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    source    texture    texture_type    script 	   function    input_name    op_type 	   operator    interpolation_mode    interpolation_color_space    offsets    colors 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat    parameter_name 
   qualifier    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections    
   Texture2D ;   res://skills/vfx/photoshop_textures/wave_texture_adobe.png �qd���
   &   local://VisualShaderNodeTexture_de7sg �
      %   local://VisualShaderNodeUVFunc_s5d2u �
      $   local://VisualShaderNodeInput_300bw       '   local://VisualShaderNodeVectorOp_ng3af i         local://Gradient_kqe01 �          local://GradientTexture2D_c2qvh _      &   local://VisualShaderNodeTexture_d6xkd �      &   local://VisualShaderNodeFloatOp_gh8ga �      -   local://VisualShaderNodeColorParameter_0c7ol          local://VisualShader_ayv3y _         VisualShaderNodeTexture                                          VisualShaderNodeUVFunc             VisualShaderNodeInput                    
         color          VisualShaderNodeVectorOp                    
                 
         �?                         	   Gradient       !          ���>�F?  �?   $                    �?g` ?g` ?g` ?  �?  �?  �?  �?  �?              �?         GradientTexture2D                   
         �?         VisualShaderNodeTexture                         VisualShaderNodeFloatOp                      VisualShaderNodeColorParameter             wave_color                   VisualShader          m  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx, unshaded;

uniform vec4 wave_color : source_color = vec4(1.000000, 1.000000, 1.000000, 1.000000);
uniform sampler2D tex_frg_2;
uniform sampler2D tex_frg_6;



void fragment() {
// ColorParameter:8
	vec4 n_out8p0 = wave_color;


// Input:4
	vec4 n_out4p0 = COLOR;
	float n_out4p1 = n_out4p0.r;


// VectorOp:5
	vec2 n_in5p1 = vec2(0.00000, 1.00000);
	vec2 n_out5p0 = vec2(n_out4p1) * n_in5p1;


// UVFunc:3
	vec2 n_in3p1 = vec2(1.00000, 1.00000);
	vec2 n_out3p0 = n_out5p0 * n_in3p1 + UV;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, n_out3p0);
	float n_out2p1 = n_out2p0.r;


// Texture2D:6
	vec4 n_out6p0 = texture(tex_frg_6, UV);


// FloatOp:7
	float n_out7p0 = n_out2p1 * n_out6p0.x;


// Output:0
	ALBEDO = vec3(n_out8p0.xyz);
	ALPHA = n_out7p0;


}
    
   �Ħ��(         8   
     D  �B9             :   
     �B  C;            <   
     �  C=            >   
     *�   B?            @   
     ��  \CA            B   
      B  DC            D   
   �C���CE            F   
     �C   �G                                                                                                               RSRC