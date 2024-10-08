RSRC                    VisualShader            ��������                                            D      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    source    texture    texture_type    script    input_name 	   operator    parameter_name 
   qualifier    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections    
   Texture2D ;   res://skills/vfx/photoshop_textures/mark_texture_adobe.png ������r   &   local://VisualShaderNodeTexture_mtot3 \      $   local://VisualShaderNodeInput_gkno4 �      &   local://VisualShaderNodeFloatOp_eiagn �      -   local://VisualShaderNodeColorParameter_4clsn (	         local://VisualShader_yi8fx z	         VisualShaderNodeTexture                                          VisualShaderNodeInput                    	         color          VisualShaderNodeFloatOp    
                  VisualShaderNodeColorParameter             mark_color                   VisualShader          K  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx, unshaded;

uniform vec4 mark_color : source_color = vec4(1.000000, 1.000000, 1.000000, 1.000000);
uniform sampler2D tex_frg_2;



void fragment() {
// ColorParameter:5
	vec4 n_out5p0 = mark_color;


// Input:3
	vec4 n_out3p0 = COLOR;
	float n_out3p1 = n_out3p0.r;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, UV);
	float n_out2p1 = n_out2p0.r;


// FloatOp:4
	float n_out4p0 = n_out3p1 * n_out2p1;


// Output:0
	ALBEDO = vec3(n_out5p0.xyz);
	ALPHA = n_out4p0;


}
          *   
     aD  �C+             ,   
     ��  �C-            .   
     ��  �C/            0   
     �C  �C1            2   
     �C  C3                                                                      RSRC