meta:
  id: mafi_format_chg
  file-extension: diff
  endian: le

seq:
  - id: file_signature
    type: u2
  - id: file_size # in bytes
    type: u4
  - id: objects_descrs
    type: object_desc_t
    repeat: eos

types:
  object_desc_t:
    seq:
      - id: block_key
        type: u2
        enum: block_key_e
      - id: data
        type:
          switch-on: block_key
          cases:
            block_key_e::definition_block_type_first: definition_block_type_first_t
            block_key_e::def_subblock_first: definition_block_type_subblock_t
            block_key_e::def_subblock_second: definition_block_type_subblock_t
            block_key_e::definition_block_type_third: definition_block_type_third_t
            block_key_e::object_block_desc: object_block_desc_t
            block_key_e::script_block: script_descr_block_t

  object_block_desc_t:
    seq:
      - id: block_size
        type: u4
      - id: object_type
        type: u4
        enum: object_types_e
      - id: position
        type: vector3_float_t
      - id: scale
        type: vector3_float_t
      - id: rotation
        type: vector3_float_t
      - id: unknown1         # 00 00 00 00
        type: f4
      - id: name_size
        type: u4
      - id: name
        type: str
        encoding: ascii
        size: name_size
      - id: name_sector_size
        type: u4
      - id: name_sector
        type: str
        encoding: ascii
        size: name_sector_size
      - id: param
        type: param_t
        if: object_type != object_types_e::bytes
      - id: data
        type: data_t
        if: object_type == object_types_e::bytes

    types:
      data_t:
        seq:
          - id: block_key
            type: u2
          - id: size
            type: u4
          - id: data
            type: u4

      param_t:
        seq:
          - id: param_size
            type: u4
          - id: param
            type: str
            encoding: ascii
            size: param_size

  definition_block_type_first_t:
    seq:
      - id: block_size
        type: u4
      - id: object_type
        type: u4
      - id: object_type_descr
        type: u1
        repeat: expr
        repeat-expr: block_size - 10

  definition_block_type_third_t:
    seq:
      - id: size
        type: u4
      - id: frame_name_size
        type: u4
      - id: frame_name
        type: str
        encoding: ascii
        size: frame_name_size
      - id: data       # Usually 0x(01 00 00 00)
        type: u1
        repeat: expr
        repeat-expr: 4 # size - 10 - frame_name_size

  definition_block_type_subblock_t:
    seq:
      - id: data
        type: u1
        repeat: expr
        repeat-expr: 40

  script_descr_block_t:
    seq:
      - id: block_size
        type: u4
      - id: script_descrs
        type: script_list_t
        size: block_size - 6

  script_list_t:
    seq:
      - id: script_list
        type: script_descr_t
        repeat: eos

  script_descr_t:
    seq:
      - id: script_signature # 0x01
        type: u1
      - id: script_name_size
        type: u4
      - id: script_name
        type: str
        encoding: ascii
        size: script_name_size
      - id: script_text_size
        type: u4
      - id: script_text
        type: str
        encoding: ascii
        size: script_text_size

  vector3_float_t:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

enums:
  object_types_e:
    0x4:
      id: sound
    0x6:
      id: bytes
    0x9:
      id: model

  block_key_e:
    0x01:
      id: def_subblock_first
    0x03:
      id: def_subblock_second
    0x64:
      id: object_block_desc
    0xC8:
      id: definition_block_type_first
    0x190:
      id: definition_block_type_third
    0x1F4:
      id: script_block
