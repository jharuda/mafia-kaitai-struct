meta:
  id: mafia_format_carcyclopedia
  file-extension: def
  endian: le

seq:
  - id: empty_record_start
    type: record_t
  - id: records
    type: record_t
    repeat: eos

types:
  record_t:
    seq:
      - id: car_id
        type: str
        encoding: ascii
        size: 32
      - id: model_4ds
        type: str
        encoding: ascii
        size: 32
      - id: shadow_model_6ds
        type: str
        encoding: ascii
        size: 32
      - id: car_name
        type: str
        encoding: ascii
        size: 32
      - id: unknown
        type: u1
        repeat: expr
        repeat-expr: 12 # it is 36 dec == 0x24 for game.exe version 1.0
      - id: color_count
        type: u8
      - id: unknown2
        type: u8
      - id: car_colors
        type: car_color_t
      - id: car_text_id
        type: u8

  car_color_t:
    seq:
      - id: car_color1
        type: u8
      - id: car_color2
        type: u8
      - id: car_color3
        type: u8
      - id: car_color4
        type: u8
      - id: car_color5
        type: u8
