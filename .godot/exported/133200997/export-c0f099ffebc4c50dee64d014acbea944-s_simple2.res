RSRC                    VisualShader            ��������                                            W      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    billboard_type    keep_scale    script    input_name    parameter_name 
   qualifier    texture_type    color_default    texture_filter    texture_repeat    texture_source    source    texture 	   operator    op_type    hint    min    max    step    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/2/node    nodes/vertex/2/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections     	   (   local://VisualShaderNodeBillboard_2mkhg Q
      $   local://VisualShaderNodeInput_tp8cn �
      1   local://VisualShaderNodeTexture2DParameter_yodj2 �
      &   local://VisualShaderNodeTexture_32n2n 6      &   local://VisualShaderNodeFloatOp_w76gc �      #   local://VisualShaderNodeStep_aupbu �      '   local://VisualShaderNodeVectorOp_ai4ev       -   local://VisualShaderNodeFloatParameter_xwn83 �         local://VisualShader_3ukdg �         VisualShaderNodeBillboard                                VisualShaderNodeInput                             color       #   VisualShaderNodeTexture2DParameter    	         Hit_texture                   VisualShaderNodeTexture                                               VisualShaderNodeFloatOp                      VisualShaderNodeStep                    )   333333�?                      VisualShaderNodeVectorOp                                                                                           VisualShaderNodeFloatParameter    	         Outline                         ��Y?         VisualShader             shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_lambert, specular_schlick_ggx, unshaded;

uniform float Outline : hint_range(0, 1) = 0.85000002384186;
uniform sampler2D Hit_texture : source_color;



void vertex() {
// GetBillboardMatrix:2
	// Node is disabled and code is not generated.
}

void fragment() {
// Input:2
	vec4 n_out2p0 = COLOR;
	float n_out2p4 = n_out2p0.a;


// FloatParameter:8
	float n_out8p0 = Outline;


	vec4 n_out4p0;
// Texture2D:4
	n_out4p0 = texture(Hit_texture, UV);
	float n_out4p1 = n_out4p0.r;


// Step:6
	float n_out6p0 = step(n_out8p0, n_out4p1);


// VectorOp:7
	vec4 n_out7p0 = n_out2p0 * vec4(n_out6p0);


// FloatOp:5
	float n_out5p0 = n_out4p1 * n_out2p4;


// Output:0
	ALBEDO = vec3(n_out7p0.xyz);
	ALPHA = n_out5p0;


}
          %         4             5   
         �C6                     
   7   
     D  C8            9   
     H�  �B:            ;   
     ��  D<            =   
     p�  D>            ?   
   sC���C@            A   
     \C  DB            C   
     \C  CD            E   
     pB  >DF       $                                                                                                                                 RSRC