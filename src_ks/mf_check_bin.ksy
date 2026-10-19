meta:
  id: mafia_format_check
  file-extension: bin
  endian: le

seq:
  - id: file_signature
    contents: [0xdf, 0xce, 0xab, 0x01]
  - id: num_points
    type: u4
  - id: points
    type: point_t
    repeat: expr
    repeat-expr: num_points
  - id: links
    type: link_t
    repeat: eos

types:
  point_t:
    seq:
      - id: position
        type: vector3_float_t
      - id: type
        type: u2
        enum: point_type_e
      - id: id
        type: u2
      - id: area_size
        type: u2
      - id: unknown
        type: u1
        repeat: expr
        repeat-expr: 10
      - id: enter_links
        type: u1
      - id: exit_links
        type: u1

  link_t:
    seq:
      - id: target_point
        type: u2
      - id: link_type
        type: u2
        enum: link_type_e
      - id: unknown
        type: f4

  vector3_float_t:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

enums:
  point_type_e:
    0x1:
      id: pedestrain
    0x2:
      id: ai
    0x4:
      id: vehicle
    0x8:
      id: tram_station
    0x10:
      id: special

  link_type_e:
    0x1:
      id: pedestrain
    0x2:
      id: ai
    0x4:
      id: trains_and_salinas_forward
    0x84:
      id: trains_and_salinas_reverse
    0x1000:
      id: other
