RSRC                    VisualShader            ��������                                            V      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    billboard_type    keep_scale    script    parameter_name 
   qualifier    texture_type    color_default    texture_filter    texture_repeat    texture_source    input_name 	   operator    source    texture    hint    min    max    step    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/2/node    nodes/vertex/2/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections     	   (   local://VisualShaderNodeBillboard_rs84t M
      1   local://VisualShaderNodeTexture2DParameter_db0yx �
      $   local://VisualShaderNodeInput_ehvfy �
      &   local://VisualShaderNodeFloatOp_3spoj 3      ,   local://VisualShaderNodeProximityFade_ntf5i g      &   local://VisualShaderNodeFloatOp_8641m �      &   local://VisualShaderNodeTexture_tq3oa �      -   local://VisualShaderNodeFloatParameter_yej4j 9         local://VisualShader_cohfk �         VisualShaderNodeBillboard                            #   VisualShaderNodeTexture2DParameter             Main_Texture 
                  VisualShaderNodeInput                             color          VisualShaderNodeFloatOp                      VisualShaderNodeProximityFade                          ?         VisualShaderNodeFloatOp                      VisualShaderNodeTexture                             
                  VisualShaderNodeFloatParameter             Proximity_Fade                            ?         VisualShader          �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx, unshaded, shadows_disabled;

uniform sampler2D Main_Texture : source_color;
uniform float Proximity_Fade : hint_range(0, 1) = 0.5;
uniform sampler2D depth_tex_frg_5 : hint_depth_texture;



void vertex() {
	mat4 n_out2p0;
// GetBillboardMatrix:2
	{
		mat4 __wm = mat4(normalize(INV_VIEW_MATRIX[0]), normalize(INV_VIEW_MATRIX[1]), normalize(INV_VIEW_MATRIX[2]), MODEL_MATRIX[3]);
		__wm = __wm * mat4(vec4(cos(INSTANCE_CUSTOM.x), -sin(INSTANCE_CUSTOM.x), 0.0, 0.0), vec4(sin(INSTANCE_CUSTOM.x), cos(INSTANCE_CUSTOM.x), 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
		__wm = __wm * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
		n_out2p0 = VIEW_MATRIX * __wm;
	}


// Output:0
	MODELVIEW_MATRIX = n_out2p0;


}

void fragment() {
// Input:3
	vec4 n_out3p0 = COLOR;
	float n_out3p4 = n_out3p0.a;


	vec4 n_out7p0;
// Texture2D:7
	n_out7p0 = texture(Main_Texture, UV);
	float n_out7p1 = n_out7p0.r;


// FloatOp:4
	float n_out4p0 = n_out3p4 * n_out7p1;


// FloatParameter:8
	float n_out8p0 = Proximity_Fade;


	float n_out5p0;
// ProximityFade:5
	{
		float __depth_tex = texture(depth_tex_frg_5, SCREEN_UV).r;
		vec4 __depth_world_pos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, __depth_tex, 1.0);
		__depth_world_pos.xyz /= __depth_world_pos.w;
		n_out5p0 = clamp(1.0 - smoothstep(__depth_world_pos.z + n_out8p0, __depth_world_pos.z, VERTEX.z), 0.0, 1.0);
	}


// FloatOp:6
	float n_out6p0 = n_out4p0 * n_out5p0;


// Output:0
	ALBEDO = vec3(n_out3p0.xyz);
	ALPHA = n_out6p0;


}
 $         )         3             4   
     �B  �C5                     
   6   
     D  C7            8   
     �  �C9            :   
     p�  �B;            <   
   F�C˱�C=            >   
     HC  D?            @   
   s(�C�q�CA            B   
   yÉ�CC            D   
     p�  /DE                                                                                                                             RSRC