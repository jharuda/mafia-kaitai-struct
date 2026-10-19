meta:
  id: mafia_format_carindex
  file-extension: def
  endian: le

seq:
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
      - id: crash_model_4ds
        type: str
        encoding: ascii
        size: 32
      - id: shadow_model_6ds
        type: str
        encoding: ascii
        size: 32
      - id: full_car_name
        type: str
        encoding: ascii
        size: 32
      - id: unknown1
        type: u1
        repeat: expr
        repeat-expr: 40
