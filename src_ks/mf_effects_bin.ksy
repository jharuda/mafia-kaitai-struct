meta:
  id: mafia_formats_effectsbin
  file-extension: bin
  endian: le

seq:
  - id: magic_number
    contents: [0x64, 0x00]
  - id: file_size
    type: u4
  - id: effects_desc
    type: effect_desc_t
    repeat: eos

types:
  effect_desc_t:
    seq:
      - id: effect_sign  # 0xE8, 0x03
        type: u2be
      - id: block_size
        type: u4        # 0x4A, 0x00, 0x00, 0x00
      - id: unknown
        type: u1
        repeat: expr
        repeat-expr: 48
      - id: position
        type: vector3_float
      - id: unknown2
        type: u4be
      - id: effect_number  # by effects.tbl
        type: u4

  vector3_float:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4