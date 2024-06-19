RSRC                    VisualShader            ��������                                            n      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat    output_port_for_preview    default_input_values    expanded_output_ports    source    texture    texture_type 	   function    input_name    op_type 	   operator    parameter_name 
   qualifier    default_value_enabled    default_value    color_default    texture_filter    texture_repeat    texture_source    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/16/node    nodes/fragment/16/position    nodes/fragment/17/node    nodes/fragment/17/position    nodes/fragment/18/node    nodes/fragment/18/position    nodes/fragment/19/node    nodes/fragment/19/position    nodes/fragment/20/node    nodes/fragment/20/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections           local://Gradient_70boo �          local://GradientTexture2D_q08j1 ;      &   local://VisualShaderNodeTexture_42dua }      %   local://VisualShaderNodeUVFunc_enhec �      $   local://VisualShaderNodeInput_j6f20       '   local://VisualShaderNodeVectorOp_tioym ?      ,   local://VisualShaderNodeVec2Parameter_lpkfm �      %   local://VisualShaderNodeUVFunc_gcrfm       ,   local://VisualShaderNodeVec2Parameter_rxf05 K      &   local://VisualShaderNodeFloatOp_1bdmv �      $   local://VisualShaderNodeInput_c50qf �      &   local://VisualShaderNodeFloatOp_0pvne /      1   local://VisualShaderNodeTexture2DParameter_4s20d c      &   local://VisualShaderNodeTexture_ysewx �      ,   local://VisualShaderNodeProximityFade_pmdb0       &   local://VisualShaderNodeFloatOp_w60cs Y      &   local://VisualShaderNodeFloatOp_phyjv �         local://Gradient_st0bi �          local://GradientTexture2D_yssfs "      &   local://VisualShaderNodeTexture_cvbss d         local://VisualShader_bdq4x �      	   Gradient       !          s�<  �?   $                    �?  �?  �?  �?  �?              �?         GradientTexture2D                    
     �?  �?         VisualShaderNodeTexture                                                            VisualShaderNodeUVFunc             VisualShaderNodeInput             time          VisualShaderNodeVectorOp                    
                 
                                       VisualShaderNodeVec2Parameter             Texture_Speed             
      ?  @@         VisualShaderNodeUVFunc                      VisualShaderNodeVec2Parameter             Texture_Scale             
     �?  �?         VisualShaderNodeFloatOp                      VisualShaderNodeInput                             color          VisualShaderNodeFloatOp                   #   VisualShaderNodeTexture2DParameter             Aura_Texture                   VisualShaderNodeTexture                                               VisualShaderNodeProximityFade                          ?         VisualShaderNodeFloatOp                      VisualShaderNodeFloatOp          	   Gradient       !          N��<y��>   $                    �?!?!?!?  �?              �?         GradientTexture2D                   
     �?  �?         VisualShaderNodeTexture                                                            VisualShader '   !      �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_lambert, specular_schlick_ggx, unshaded, shadows_disabled;

uniform vec2 Texture_Scale = vec2(1.000000, 1.000000);
uniform vec2 Texture_Speed = vec2(0.500000, 3.000000);
uniform sampler2D Aura_Texture : source_color;
uniform sampler2D tex_frg_3 : source_color;
uniform sampler2D tex_frg_20 : source_color;
uniform sampler2D depth_tex_frg_17 : hint_depth_texture;



void fragment() {
// Input:11
	vec4 n_out11p0 = COLOR;
	float n_out11p4 = n_out11p0.a;


// Vector2Parameter:9
	vec2 n_out9p0 = Texture_Scale;


// UVFunc:8
	vec2 n_in8p2 = vec2(0.00000, 0.00000);
	vec2 n_out8p0 = (UV - n_in8p2) * n_out9p0 + n_in8p2;


// Input:5
	float n_out5p0 = TIME;


// Vector2Parameter:7
	vec2 n_out7p0 = Texture_Speed;


// VectorOp:6
	vec2 n_out6p0 = vec2(n_out5p0) * n_out7p0;


// UVFunc:4
	vec2 n_in4p1 = vec2(1.00000, 1.00000);
	vec2 n_out4p0 = n_out6p0 * n_in4p1 + n_out8p0;


	vec4 n_out16p0;
// Texture2D:16
	n_out16p0 = texture(Aura_Texture, n_out4p0);
	float n_out16p1 = n_out16p0.r;


// Texture2D:3
	vec4 n_out3p0 = texture(tex_frg_3, UV);
	float n_out3p1 = n_out3p0.r;


// FloatOp:10
	float n_out10p0 = n_out16p1 * n_out3p1;


// Texture2D:20
	vec4 n_out20p0 = texture(tex_frg_20, UV);
	float n_out20p1 = n_out20p0.r;


// FloatOp:19
	float n_out19p0 = n_out10p0 + n_out20p1;


// FloatOp:12
	float n_out12p0 = n_out11p4 * n_out19p0;


	float n_out17p0;
// ProximityFade:17
	float n_in17p0 = 0.50000;
	{
		float __depth_tex = texture(depth_tex_frg_17, SCREEN_UV).r;
		vec4 __depth_world_pos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, __depth_tex, 1.0);
		__depth_world_pos.xyz /= __depth_world_pos.w;
		n_out17p0 = clamp(1.0 - smoothstep(__depth_world_pos.z + n_in17p0, __depth_world_pos.z, VERTEX.z), 0.0, 1.0);
	}


// FloatOp:18
	float n_out18p0 = n_out12p0 * n_out17p0;


// Output:0
	ALBEDO = vec3(n_out11p0.xyz);
	ALPHA = n_out18p0;


}
 &         ,         1         <   
    ��D  C=            >   
   6<f�ǃ(D?            @   
   �ǨÍ�CA            B   
   �cQč�CC            D   
   �cč�CE            F   
   .C�V�DG            H   
   �c�<BI            J   
     p�  ��K         	   L   
   =j]C���CM         
   N   
     �B  ��O            P   
     D  pCQ            R   
     ��  DS            T   
      �  �CU            V   
     D  �CW            X   
     WD  �CY            Z   
     �C  D[            \   
     �C  HD]       D                                                         	                   
                                                                   
                                                
                                             RSRC