meta:
  id: mafia_format_menu
  file-extension: def
  endian: le

seq:
  - id: controls
    type: control_t
    repeat: eos

types:
  control_t:
    seq:
      - id: unknown1
        type: u4
      - id: menu_type
        type: str
        encoding: ascii
        size: 4
      - id: position
        type: vector2_float
      - id: scale
        type: vector2_float
      - id: text_id # see textdb_xx.def file
        type: u4
      - id: text_color
        type: u4
      - id: background_color
        type: u4

  vector2_float:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4

enums:
  srev_e:
    0x73726576:
      id: srev
      #unde ...

