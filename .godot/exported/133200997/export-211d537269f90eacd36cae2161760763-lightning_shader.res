RSRC                    VisualShader            ��������                                            Q      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    source    texture    texture_type    script 	   function    input_name    op_type 	   operator    interpolation_mode    interpolation_color_space    offsets    colors 	   gradient    width    use_hdr    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections    
   Texture2D @   res://skills/vfx/photoshop_textures/lightning_texture_adobe.png �M��jl   &   local://VisualShaderNodeTexture_tir83 �
      %   local://VisualShaderNodeUVFunc_l5vmr �
      $   local://VisualShaderNodeInput_uowl8 �
      '   local://VisualShaderNodeVectorOp_6v1jy 5      )   local://VisualShaderNodeSmoothStep_aqfe3 �      $   local://VisualShaderNodeInput_vetef       $   local://VisualShaderNodeRemap_2w2lg a         local://Gradient_ptavv �          local://GradientTexture1D_asdql 0      &   local://VisualShaderNodeTexture_okhgi n         local://VisualShader_rfbqf �         VisualShaderNodeTexture                                          VisualShaderNodeUVFunc             VisualShaderNodeInput    
         time          VisualShaderNodeVectorOp                    
                 
         ��                            VisualShaderNodeSmoothStep                                 )   ffffff�?            ?         VisualShaderNodeInput                    
         color          VisualShaderNodeRemap                                     �?                   )   ffffff�?      	   Gradient       !      �>�~>?   $      ���=      �@  �?  �?   @   A  �?         GradientTexture1D                                  VisualShaderNodeTexture                                   VisualShader          {  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_lambert, specular_schlick_ggx, unshaded;

uniform sampler2D tex_frg_2;
uniform sampler2D tex_frg_9;



void fragment() {
// Input:7
	vec4 n_out7p0 = COLOR;
	float n_out7p1 = n_out7p0.r;


	float n_out8p0;
// Remap:8
	float n_in8p1 = 0.00000;
	float n_in8p2 = 1.00000;
	float n_in8p3 = 0.00000;
	float n_in8p4 = 0.70000;
	{
		float __input_range = n_in8p2 - n_in8p1;
		float __output_range = n_in8p4 - n_in8p3;
		n_out8p0 = n_in8p3 + __output_range * ((n_out7p1 - n_in8p1) / __input_range);
	}


// Input:4
	float n_out4p0 = TIME;


// VectorOp:5
	vec2 n_in5p1 = vec2(0.00000, -1.00000);
	vec2 n_out5p0 = vec2(n_out4p0) * n_in5p1;


// UVFunc:3
	vec2 n_in3p1 = vec2(1.00000, 1.00000);
	vec2 n_out3p0 = n_out5p0 * n_in3p1 + UV;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, n_out3p0);
	float n_out2p1 = n_out2p0.r;


// SmoothStep:6
	float n_in6p1 = 0.70000;
	float n_out6p0 = smoothstep(n_out8p0, n_in6p1, n_out2p1);


// Texture2D:9
	vec4 n_out9p0 = texture(tex_frg_9, vec2(n_out6p0));


// Output:0
	ALBEDO = vec3(n_out9p0.xyz);
	ALPHA = n_out6p0;


}
                   /   
    ��D    0             1   
     CD  �B2            3   
     �C  4C4            5   
     p�  �C6            7   
     �C  HC8            9   
     D  pB:            ;   
     �C  ��<            =   
     HD  ��>         	   ?   
     �D  ��@       $                                                                                                        	       	                     RSRC