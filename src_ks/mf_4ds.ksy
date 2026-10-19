meta:
  id: mafia_format_4ds
  file-extension: 4ds
  endian: le

seq:
  - id: format_signature
    contents: [0x34, 'D', 'S', 0x00]  # 4DS\0
  - id: version
    type: u2
  - id: timestamp
    type: u8
  - id: materials_count
    type: u2
  - id: materials
    type: materials_t
    repeat: expr
    repeat-expr: materials_count
  - id: meshes_count
    type: u2
  - id: meshes
    type: meshes_t
    repeat: expr
    repeat-expr: meshes_count

types:
  materials_t:
    seq:
      - id: material_flags
        type: material_flags_t
      - id: ambient_color
        type: color_t
      - id: diffuse_color
        type: color_t
      - id: emmision_color
        type: color_t
      - id: oppactiy
        type: f4
      - id: env_mapping
        type: texture_environment_t
        if: material_flags.is_env
      - id: diffuse_filename_chars_count
        type: u1
      - id: diffuse_filename
        type: str
        encoding: ascii
        size: diffuse_filename_chars_count
      - id: alpha_mapping
        type: alpha_mapping_t
        if: material_flags.is_alpha_map
      - id: anim_texture
        type: anim_texture_t
        if: material_flags.is_animated

  texture_environment_t:
    seq:
      - id: env_texture_ratio
        type: f4
      - id: env_filename_chars_count
        type: u1
      - id: env_filename
        type: str
        encoding: ascii
        size: env_filename_chars_count

  alpha_mapping_t:
    seq:
      - id: alpha_texture_filename_chars_count
        type: u1
      - id: alpha_texture_filename
        type: str
        encoding: ascii
        size: alpha_texture_filename_chars_count

  anim_texture_t:
    seq:
      - id: anim_seq_count
        type: u4
      - id: unknown1
        type: u2
      - id: frame_period
        type: u4
      - id: unknown2
        type: u4
      - id: unknown3
        type: u4

  material_flags_t:
    seq:
      - id: unused1
        type: b8
      - id: is_add_effect
        type: b1
      - id: is_projection_detail_z
        type: b1
      - id: is_projection_detail_y
        type: b1
      - id: is_projection_y
        type: b1
      - id: is_multiply_env
        type: b1
      - id: is_additive_env
        type: b1
      - id: is_overlay_env
        type: b1
      - id: unused2
        type: b1
      - id: is_mip_mapping
        type: b1
      - id: unused3
        type: b3
      - id: is_env
        type: b1
      - id: is_diffuse_texture
        type: b1
      - id: unused4
        type: b2
      - id: is_addictive_mixing
        type: b1
      - id: is_alpha_map
        type: b1
      - id: is_color_key
        type: b1
      - id: is_two_side_texture
        type: b1
      - id: is_coloring
        type: b1
      - id: is_animated
        type: b1
      - id: unused5
        type: b2

  meshes_t:
    seq:
      - id: mesh_type
        type: u1
        enum: mesh_types_e
      - id: standard_mesh_subtype
        type: mesh_standard_subtype_t
        if: mesh_type == mesh_types_e::standard_mesh
      - id: parent_mesh_id
        type: u2
      - id: position
        type: vector3_float
      - id: scale
        type: vector3_float
      - id: rotation
        type: quaternion_t
      - id: culling_flags
        type: u1
      - id: mesh_name_chars_count
        type: u1
      - id: mesh_name
        type: str
        encoding: ascii
        size: mesh_name_chars_count
      - id: mesh_params_chars_count
        type: u1
      - id: mesh_params
        type: str
        encoding: ascii
        size: mesh_params_chars_count
      - id: mesh_geometry_by_type
        type:
          switch-on: mesh_type
          cases:
            mesh_types_e::bone: bone_t
            mesh_types_e::dummy: dummy_t
            mesh_types_e::sector: sector_t
            mesh_types_e::standard_mesh: geometry_definition_t
            mesh_types_e::target: target_t

  geometry_definition_t:
    seq:
      - id: visual_type
        type:
          switch-on: _parent.standard_mesh_subtype.mesh_visual_type
          cases:
            mesh_visual_types_e::billboard: billboard_t
            mesh_visual_types_e::glow: glow_t
            mesh_visual_types_e::single_mesh: single_mesh_t
            mesh_visual_types_e::single_morph: single_morph_t
            mesh_visual_types_e::morph: morph_object_t
            mesh_visual_types_e::mirror: mirror_t
            mesh_visual_types_e::standard_mesh: mesh_standard_t

  morph_object_t:
    seq:
      - id: standard_mesh
        type: mesh_standard_t
      - id: morph
        type: morph_t

  single_morph_t:
    seq:
      - id: single_mesh
        type: single_mesh_t
      - id: morph
        type: morph_t

  single_mesh_t:
    seq:
      - id: standard_mesh
        type: mesh_standard_t
      - id: single_mesh_lods
        type: single_mesh_lods_t
        repeat: expr
        repeat-expr: standard_mesh.lods.lods_count

  single_mesh_lods_t:
    seq:
      - id: bone_joint_count
        type: u1
      - id: unknown1
        type: u4
      - id: bounding_box
        type: bounding_box_t
      - id: bone_joints_lods
        type: single_mesh_bone_joint_lods_t
        repeat: expr
        repeat-expr: bone_joint_count

  single_mesh_bone_joint_lods_t:
    seq:
      - id: transformation_matrix
        type: transformation_matrix_t
      - id: one_weighted_verticies_count
        type: u4
      - id: weight_count
        type: u4
      - id: bone_id
        type: u4
      - id: bounding_box
        type: bounding_box_t
      - id: weights
        type: f4
        repeat: expr
        repeat-expr: weight_count

  morph_t:
    seq:
      - id: frames_count
        type: u1
      - id: lods_count
        type: u1
        if: frames_count > 0
      - id: unknown1
        type: u1
        if: frames_count > 0
      - id: morph_lods
        type: morph_lods_t
        if: frames_count > 0
        repeat: expr
        repeat-expr: lods_count
      - id: bouding_box
        type: bounding_box_t
        if: frames_count > 0
      - id: unknown2
        type: f4
        if: frames_count > 0
        repeat: expr
        repeat-expr: 4

    types:
      morph_lods_t:
        seq:
          - id: verticies_count
            type: u2
          - id: morph_lod_verticies
            type: morph_lod_verticies_t
            repeat: expr
            repeat-expr: verticies_count * _parent.frames_count
          - id: unknown1
            type: u1
            if: verticies_count * _parent.frames_count > 0
          - id: verticies_link
            type: u2
            repeat: expr
            repeat-expr: verticies_count

  morph_lod_verticies_t:
    seq:
      - id: position
        type: vector3_float
      - id: normal
        type: vector3_float

  mirror_t:
    seq:
      - id: bounding_box
        type: bounding_box_t
      - id: unknown1
        type: f4
        repeat: expr
        repeat-expr: 4
      - id: transform_matrix
        type: transformation_matrix_t
      - id: background_color
        type: color_t
      - id: draw_distance
        type: f4
      - id: verticies_count
        type: u4
      - id: faces_count
        type: u4
      - id: verticies
        type: vector3_float
        repeat: expr
        repeat-expr: verticies_count
      - id: faces
        type: faces_t
        repeat: expr
        repeat-expr: faces_count

  sector_t:
    seq:
      - id: unknown1
        type: u4
      - id: unknown2
        type: u4
      - id: vertices_count
        type: u4
      - id: faces_count
        type: u4
      - id: vertices
        type: vector3_float
        repeat: expr
        repeat-expr: vertices_count
      - id: faces
        type: faces_t
        repeat: expr
        repeat-expr: faces_count
      - id: bounding_box
        type: bounding_box_t
      - id: portals_count
        type: u1
      - id: portals
        type: portal_t
        repeat: expr
        repeat-expr: portals_count

  portal_t:
    seq:
      - id: verticies_count
        type: u1
      - id: unknown_1 # always 4  
        type: f4
        repeat: expr
        repeat-expr: 7
      - id: verticies
        type: vector3_float
        repeat: expr
        repeat-expr: verticies_count

  target_t:
    seq:
      - id: unknown_1
        type: u2
      - id: target_count
        type: u1
      - id: targets # by hierarchy
        type: u2 
        repeat: expr
        repeat-expr: target_count

  bone_t:
    seq:
      - id: transform_matrix
        type: transformation_matrix_t
      - id: bone_id
        type: u4

  billboard_t:
    seq:
      - id: standard_mesh
        type: mesh_standard_t
      - id: rotate_axis # 0: x, 1: y, 2: z
        type: u4
      - id: use_one_axis # 0: use all, 1: use selected axis
        type: u1

  glow_t:
    seq:
      - id: glow_count
        type: u1
      - id: glows
        repeat: expr
        repeat-expr: glow_count
        type: glow_child_t

  glow_child_t:
    seq:
      - id: position
        type: f4
      - id: material_id
        type: u2

  mesh_standard_subtype_t:
    seq:
      - id: mesh_visual_type
        type: u1
        enum: mesh_visual_types_e
      - id: mesh_rendering_flags
        type: u2
        enum: mesh_rendering_flags_e

  mesh_standard_t:
    seq:
      - id: geometry_duplication
        type: u1
      - id: lods
        type: mesh_lods_t
        if: geometry_duplication == 0
      - id: unknown1
        type: u1
        if: geometry_duplication != 0

  mesh_lods_t:
    meta:
      endian: be
    seq:
      - id: lods_count
        type: u2
      - id: lod_object
        type: mesh_lod_geometry_t
        repeat: expr
        repeat-expr: lods_count

  mesh_lod_geometry_t:
    seq:
      - id: switch_distance
        type: f4
      - id: verticies_count
        type: u2
      - id: verticies
        type: mesh_verticie_t
        repeat: expr
        repeat-expr: verticies_count
      - id: faces_groups_count
        type: u1
      - id: faces_groups
        type: faces_groups_t
        repeat: expr
        repeat-expr: faces_groups_count

  mesh_verticie_t:
    seq:
      - id: position
        type: vector3_float
      - id: normal
        type: vector3_float
      - id: texture_coord_x
        type: f4
      - id: texture_coord_y
        type: f4

  faces_groups_t:
    seq:
      - id: faces_count
        type: u2
      - id: faces
        type: faces_t
        repeat: expr
        repeat-expr: faces_count
      - id: material_id
        type: u2

  dummy_t:
    seq:
      - id: bounding_box
        type: bounding_box_t

  transformation_matrix_t:
    seq:
      - id: x
        type: vector4_float
      - id: y
        type: vector4_float
      - id: z
        type: vector4_float
      - id: w
        type: vector4_float

  bounding_box_t:
    seq:
      - id: min
        type: vector3_float
      - id: max
        type: vector3_float

  color_t:
    seq:
      - id: red
        type: f4
      - id: green
        type: f4
      - id: blue
        type: f4

  faces_t:
    seq:
      - id: face_1
        type: u2
      - id: face_2
        type: u2
      - id: face_3
        type: u2

  quaternion_t:
    seq:
      - id: re_w
        type: f4
      - id: im_x
        type: f4
      - id: im_y
        type: f4
      - id: im_z
        type: f4

  vector3_float:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

  vector4_float:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
      - id: w
        type: f4

enums:
  mesh_types_e:
    0x01:
      id: standard_mesh
      -orig-id: STANDARD_MESH
    0x05:
      id: sector
      -orig-id: SECTOR
    0x06:
      id: dummy
      -orig-id: DUMMY
    0x07:
      id: target
      -orig-id: TARGET
    0x0a:
      id: bone
      -orig-id: BONE

  mesh_rendering_flags_e:
    0x0001:
      id: use_depth_bias
      -orig-id: USE_DEPTH_BIAS
    0x0002:
      id: use_shadow
      -orig-id: USE_SHADOW
    0x0008:
      id: unknown1
      -orig-id: UNKNOWN1
    0x0020:
      id: use_projection
      -orig-id: USE_PROJECTION
    0x0080:
      id: do_not_use_fog
      -orig-id: DO_NOT_USE_FOG

  mesh_visual_types_e:
    0x00:
      id: standard_mesh
      -orig-id: STANDARD_MESH
    0x02:
      id: single_mesh
      -orig-id: SINGLE_MESH
    0x03:
      id: single_morph
      -orig-id: SINGLE_MORPH
    0x04:
      id: billboard
      -orig-id: BILLBOARD
    0x05:
      id: morph
      -orig-id: MORPH
    0x06:
      id: glow
      -orig-id: GLOW
    0x08:
      id: mirror
      -orig-id: MIRROR
