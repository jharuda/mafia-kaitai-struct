meta:
  id: mafia_format_tbl
  file-extension: tbl
  endian: le

seq:
  - id: blocks
    type: block_t
    repeat: eos

types:
  block_t:
    seq:
      - id: header                  # always 0x64 0x00
        type: block_header_t
      - id: name_block              # always 0x67 0x00
        type: string_block_t
      - id: model_block             # always 0x68 0x00
        type: string_block_t
      - id: unnamed_block_first     # always 0x6A 0x00
        type: unnamed_block_t
      - id: unnamed_block_second    # always 0xEA 0x00
        type: unnamed_block_t
      - id: unnamed_block_third_t   # always 0x65 0x00
        type: block_layers_t
        size: header.size - 6 - name_block.header.size - model_block.header.size - unnamed_block_first.header.size - unnamed_block_second.header.size

  block_layers_t:
    seq:
      - id: subblocks
        type: block_layer_t
        repeat: eos

  string_block_t:
    seq:
      - id: header  # always 0x67 0x00
        type: block_header_t
      - id: effect_name
        type: string_t

  unnamed_block_t:
    seq:
      - id: header
        type: block_header_t
      - id: data
        type: u1
        repeat: expr
        repeat-expr: header.size - 6

  string_t:
    seq:
      - id: string
        type: str
        encoding: ascii
        terminator: 0

  block_header_t:
    seq:
      - id: key
        type: u2
      - id: size
        type: u4

  block_layer_t:
    seq:
      - id: header
        type: block_header_t
      - id: key_1
        type: block_header_t
      - id: layer_name
        type: string_t
        if: key_1.key == 0x67
      - id: mesh_name_
        type: string_t
        if: key_1.key == 0x69
      - id: key_2
        type: block_header_t
        if: key_1.key == 0x67  # we do expect this time is key 0x69. It is very basic check, maybe I should rewrite it
      - id: mesh_name
        type: string_t
        if: key_1.key == 0x67
      - id: block_layer_subtype
        type: block_layer_subtype_t
      - id: six_d_header
        type: block_header_t
      - id: six_d_data
        type: u1
        repeat: expr
        repeat-expr: six_d_header.size - 6
      - id: subblock_second_level
        type: last_block_t
        if: key_1.key == 0x67
        repeat: expr
        repeat-expr: (header.size - 162 - key_1.size - key_2.size) / 124
      - id: subblock_second_v2_level
        type: last_block_t
        repeat: expr
        repeat-expr: (header.size - 162 - key_1.size) / 124
        if: key_1.key == 0x69

  last_block_t:  # size: 0x7C
    seq:
      - id: header
        type: block_header_t
      - id: first_key
        type: block_header_t
      - id: layer_name  # 0x67 0x00 -> String key
        type: string_t
        if: first_key.key == 0x67
      - id: block_six_a # 0x6A 0x00 -> read 6A data
        type: u1
        repeat: expr
        repeat-expr: first_key.size - 6 
        if: first_key.key == 0x6A
      - id: param_six_a_key # If we doesn't 6A data ^, then now we are reading 6A header. It is for usecase wehen we there was string.
        type: u1
        repeat: expr
        repeat-expr: header.size - first_key.size - 6 # 0x6B and 0x6C headers and data are here

  block_layer_subtype_t:
    seq:
      - id: six_a_header     # 0x6A 0x00
        type: block_header_t
      - id: six_a_data
        type: u1
        repeat: expr
        repeat-expr: six_a_header.size - 6
      - id: six_b_header     # 0x6B 0x00
        type: block_header_t
      - id: six_b_data
        type: u1
        repeat: expr
        repeat-expr: six_b_header.size - 6
      - id: six_c_header     # 0x6C 0x00
        type: block_header_t
      - id: six_c_data
        type: u1
        repeat: expr
        repeat-expr: six_c_header.size - 6
