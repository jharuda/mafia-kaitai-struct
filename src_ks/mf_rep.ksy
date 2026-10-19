meta:
  id: mafia_format_rep
  file-extension: rep
  endian: le

seq:
  - id: magic_byte
    contents: [0x31, 0x16, 0x00, 0x00]
  - id: anim_block_size
    type: u4
  - id: object_def_section_size
    type: u4
  - id: object_def_count # 108 bytes
    type: u4
  - id: cc_block
    type: u4
  - id: camera_chunks_count
    type: u4
  - id: camera_focus_chunks_count
    type: u4
  - id: script_event_sequence_size
    type: u4
  - id: dialog_section_size
    type: u4
  - id: zeros_padding # Zeros
    type: u1
    repeat: expr
    repeat-expr: 60
  - id: anim_blocks_count
    type: u4
  - id: unknown3
    contents: [0x00, 0x01, 0x00, 0x00]
  - id: list_of_animations
    type: animaton_block_t
    repeat: expr
    repeat-expr: anim_blocks_count
  - id: list_of_objects
    type: object_definition_blocks_t #  object_definition_t
    repeat: expr
    repeat-expr: object_def_count

types:
  animaton_block_t: # 52 bytes
    seq:
      - id: anim_id
        type: u4
      - id: model_name
        type: str
        encoding: ascii
        size: 48

  object_definition_blocks_t: # 108 bytes
    seq:
      - id: object_definitions1
        type: object_definition_t
      - id: object_definitions2
        type: object_definition_t
      - id: data
        type: u1
        repeat: expr
        repeat-expr: 36
    
  object_definition_t:
    seq:
      - id: anim_name
        type: str
        encoding: ascii
        size: 36