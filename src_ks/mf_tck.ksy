meta:
  id: mafia_format_tck
  file-extension: tck
  endian: le

seq:
  - id: file_signature
    type: u4 # 0x(04, 0x00, 0x00, 0x00) or (e8 08 00 00)   #contents: [0x04, 0x00, 0x00, 0x00]
  - id: start_position
    type: vector3_float_t
  - id: end_position
    type: vector3_float_t
  - id: duration
    type: u4
  - id: miliseconds_per_frame
    type: u4
  - id: position_blocks_def
    type: position_blocks_def_t
    repeat: eos

types:
  position_blocks_def_t:
    seq:
      - id: position_blocks_count
        type: u4
      - id: position_blocks # skip the first block if there are zeros
        type: vector3_float_t
        repeat: expr
        repeat-expr: position_blocks_count
        if: position_blocks_count != 0 # 0 means it is end

  vector3_float_t:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
    