meta:
  id: mafia_format_circuits
  file-extension: def
  endian: le

seq:
  - id: tracks
    type: track_t
    repeat: eos

types:
  track_t:
    seq:
      - id: track_name
        type: str
        encoding: ascii
        size: 32
      - id: mise_folder
        type: str
        encoding: ascii
        size: 32
      - id: unknown1
        type: u8
      - id: car_description
        type: u4
        repeat: expr
        repeat-expr: 16
