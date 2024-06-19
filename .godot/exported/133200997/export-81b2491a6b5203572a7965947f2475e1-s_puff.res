RSRC                    VisualShader            ��������                                            {      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    input_name    script    op_type 	   operator 	   constant 	   function    parameter_name 
   qualifier    texture_type    color_default    texture_filter    texture_repeat    texture_source    source    texture    hint    min    max    step    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/2/node    nodes/vertex/2/position    nodes/vertex/3/node    nodes/vertex/3/position    nodes/vertex/4/node    nodes/vertex/4/position    nodes/vertex/5/node    nodes/vertex/5/position    nodes/vertex/6/node    nodes/vertex/6/position    nodes/vertex/8/node    nodes/vertex/8/position    nodes/vertex/9/node    nodes/vertex/9/position    nodes/vertex/10/node    nodes/vertex/10/position    nodes/vertex/11/node    nodes/vertex/11/position    nodes/vertex/12/node    nodes/vertex/12/position    nodes/vertex/14/node    nodes/vertex/14/position    nodes/vertex/15/node    nodes/vertex/15/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/20/node    nodes/fragment/20/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/2/node    nodes/light/2/position    nodes/light/3/node    nodes/light/3/position    nodes/light/4/node    nodes/light/4/position    nodes/light/5/node    nodes/light/5/position    nodes/light/6/node    nodes/light/6/position    nodes/light/7/node    nodes/light/7/position    nodes/light/9/node    nodes/light/9/position    nodes/light/10/node    nodes/light/10/position    nodes/light/11/node    nodes/light/11/position    nodes/light/12/node    nodes/light/12/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        $   local://VisualShaderNodeInput_byhh6 �      $   local://VisualShaderNodeInput_rp3u7 �      '   local://VisualShaderNodeVectorOp_tto6y �      '   local://VisualShaderNodeVectorOp_4kc7i (      ,   local://VisualShaderNodeFloatConstant_0fkc3 ]      '   local://VisualShaderNodeVectorOp_8vyhr �      %   local://VisualShaderNodeUVFunc_3660r �      $   local://VisualShaderNodeInput_54w41 �      '   local://VisualShaderNodeVectorOp_hxirm *      +   local://VisualShaderNodeVec2Constant_fulqq �      1   local://VisualShaderNodeTexture2DParameter_cks4n �      &   local://VisualShaderNodeTexture_5ipk4 4      ,   local://VisualShaderNodeProximityFade_bk5iy �      $   local://VisualShaderNodeInput_ifne7 �      &   local://VisualShaderNodeFloatOp_oo2ap "      -   local://VisualShaderNodeFloatParameter_q0h42 V      $   local://VisualShaderNodeInput_38l5x �      $   local://VisualShaderNodeInput_tmy0i �      )   local://VisualShaderNodeDotProduct_7aqwu 5      )   local://VisualShaderNodeSmoothStep_sg42o `      ,   local://VisualShaderNodeFloatConstant_dv6ue �      ,   local://VisualShaderNodeFloatConstant_1502k       ,   local://VisualShaderNodeFloatConstant_m5ihb S      $   local://VisualShaderNodeClamp_0550s �      ,   local://VisualShaderNodeFloatConstant_7ccuh       &   local://VisualShaderNodeFresnel_6opv4 M         local://VisualShader_6t4n2 �         VisualShaderNodeInput             normal          VisualShaderNodeInput             vertex          VisualShaderNodeVectorOp             VisualShaderNodeVectorOp                      VisualShaderNodeFloatConstant    	      ���         VisualShaderNodeVectorOp                      VisualShaderNodeUVFunc             VisualShaderNodeInput             time          VisualShaderNodeVectorOp                    
                 
                                       VisualShaderNodeVec2Constant    	   
   ���=  �?      #   VisualShaderNodeTexture2DParameter             Vertex_Noise                   VisualShaderNodeTexture                                               VisualShaderNodeProximityFade                    )   �������?         VisualShaderNodeInput                             color          VisualShaderNodeFloatOp                      VisualShaderNodeFloatParameter             Proximity_Fade                         ��L>         VisualShaderNodeInput             normal          VisualShaderNodeInput             light          VisualShaderNodeDotProduct             VisualShaderNodeSmoothStep                                              �?  �?  �?            ?   ?   ?                  VisualShaderNodeFloatConstant             VisualShaderNodeFloatConstant    	      ���=         VisualShaderNodeFloatConstant    	      ���=         VisualShaderNodeClamp                                                                   �?  �?  �?                  VisualShaderNodeFloatConstant    	        �?         VisualShaderNodeFresnel                                    �?         VisualShader =         	  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx, fog_disabled;

uniform sampler2D Vertex_Noise : source_color;
uniform float Proximity_Fade : hint_range(0, 1) = 0.20000000298023;
uniform sampler2D depth_tex_frg_2 : hint_depth_texture;



void vertex() {
// Input:3
	vec3 n_out3p0 = VERTEX;


// Input:2
	vec3 n_out2p0 = NORMAL;


// Input:10
	float n_out10p0 = TIME;


// Vector2Constant:12
	vec2 n_out12p0 = vec2(0.100000, 1.000000);


// VectorOp:11
	vec2 n_out11p0 = vec2(n_out10p0) * n_out12p0;


// UVFunc:9
	vec2 n_in9p1 = vec2(1.00000, 1.00000);
	vec2 n_out9p0 = n_out11p0 * n_in9p1 + UV;


	vec4 n_out15p0;
// Texture2D:15
	n_out15p0 = texture(Vertex_Noise, n_out9p0);
	float n_out15p1 = n_out15p0.r;


// VectorOp:8
	vec3 n_out8p0 = n_out2p0 * vec3(n_out15p1);


// FloatConstant:6
	float n_out6p0 = -0.600000;


// VectorOp:5
	vec3 n_out5p0 = n_out8p0 * vec3(n_out6p0);


// VectorOp:4
	vec3 n_out4p0 = n_out3p0 + n_out5p0;


// Output:0
	VERTEX = n_out4p0;


}

void fragment() {
// Input:3
	vec4 n_out3p0 = COLOR;
	float n_out3p4 = n_out3p0.a;


// FloatParameter:20
	float n_out20p0 = Proximity_Fade;


	float n_out2p0;
// ProximityFade:2
	{
		float __depth_tex = texture(depth_tex_frg_2, SCREEN_UV).r;
		vec4 __depth_world_pos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, __depth_tex, 1.0);
		__depth_world_pos.xyz /= __depth_world_pos.w;
		n_out2p0 = clamp(1.0 - smoothstep(__depth_world_pos.z + n_out20p0, __depth_world_pos.z, VERTEX.z), 0.0, 1.0);
	}


// FloatOp:5
	float n_out5p0 = n_out3p4 * n_out2p0;


// Output:0
	ALBEDO = vec3(n_out3p0.xyz);
	ALPHA = n_out5p0;


}

void light() {
// FloatConstant:6
	float n_out6p0 = 0.000000;


// FloatConstant:7
	float n_out7p0 = 0.100000;


// Input:2
	vec3 n_out2p0 = NORMAL;


// Fresnel:12
	float n_in12p3 = 1.00000;
	float n_out12p0 = pow(clamp(dot(NORMAL, VIEW), 0.0, 1.0), n_in12p3);


// DotProduct:4
	float n_out4p0 = dot(n_out2p0, vec3(n_out12p0));


// SmoothStep:5
	vec3 n_out5p0 = smoothstep(vec3(n_out6p0), vec3(n_out7p0), vec3(n_out4p0));


// FloatConstant:9
	float n_out9p0 = 0.100000;


// FloatConstant:11
	float n_out11p0 = 1.000000;


// Clamp:10
	vec3 n_out10p0 = clamp(n_out5p0, vec3(n_out9p0), vec3(n_out11p0));


// Output:0
	DIFFUSE_LIGHT = n_out10p0;


}
 2         3   
      D   C4             5   
     %�  �C6            7   
     ��  HC8            9   
     �C  HC:            ;   
     4C  �C<            =   
     p�  *D>            ?   
   ђ�èN
D@            A   
     ��  DB            C   
     ��  �CD            E   
     ��  DF         	   G   
    ���  CDH         
   I   
     ��  aDJ            K   
     C�   DL       0                                                         
                                  	                                 	                                         M   
     kD  �BN            O   
     ��  DP            Q   
     ��  �CR            S   
         �CT            U   
     �   DV                                                                               W   
    ��D  �CX            Y   
     p�  \CZ            [   
     \C  D\            ]   
     �C  �C^            _   
     D   B`            a   
     �C    b            c   
     �C  �Bd            e   
     �C  �Cf            g   
     >D  HCh            i   
     �C  �Cj            k   
     p�  �Cl       $                                            	       
             
      
                      
                                       RSRC