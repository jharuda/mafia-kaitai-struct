meta:
  id: mafia_format_parnik
  file-extension: def
  endian: le

seq:
  - id: magic_number
    contents: [0x04, 0x00, 0x00, 0x00]
  - id: unknown
    type: u4
  - id: points
    type: point_t
    repeat: eos

types:
  point_t:
    seq:
      - id: position
        type: vector3_float
      - id: rotation
        type: vector3_float

  vector3_float:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
