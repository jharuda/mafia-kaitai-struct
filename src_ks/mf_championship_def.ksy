meta:
  id: mafia_format_championship
  file-extension: def
  endian: le

seq:
  - id: races
    type: race_t
    repeat: eos

types:
  race_t:
    seq:
      - id: type_text_id
        type: u4be
        enum: classes_of_cars_e
      - id: type_text_id_secondpart
        type: u4le
      - id: records
        type: record_t
        repeat: expr
        repeat-expr: 11

  record_t:
    seq:
      - id: unknown1
        type: u8
      - id: unknown2
        type: u8

enums:
  classes_of_cars_e:
    0xAE010000:
      id: class_a
      -orig-id: CLASS_A
    0xAF010000:
      id: class_b
      -orig-id: CLASS_B
    0xB0010000:
      id: class_c
      -orig-id: CLASS_C
    0xB1010000:
      id: classic
      -orig-id: CLASSIC
    0xB2010000:
      id: sports
      -orig-id: SPORTS
    0xB3010000:
      id: racing
      -orig-id: RACING
    0xBE010000:
      id: checkin
      -orig-id: CHECK_IN
    0xB4010000:
      id: various
      -orig-id: VARIOUS