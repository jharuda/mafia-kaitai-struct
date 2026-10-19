meta:
  id: mafia_format_face_anim_dat
  file-extension: dat
  endian: le

seq:
  - id: records_count
    type: u4
  - id: unknown1
    contents: [0x01, 0x00, 0x00, 0x00]
  - id: records
    type: record_t
    repeat: expr
    repeat-expr: records_count

types:
  record_t:
    seq:
      - id: wide_mouth
        type: u1
      - id: open_mouth
        type: u1
      - id: lips_coners
        type: u1
      - id: eye_lid
        type: u1
      - id: open_eye
        type: u1
      - id: eyebrow
        type: u1
      - id: unknown
        type: u2
