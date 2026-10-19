meta:
  id: mafia_format_load
  file-extension: def
  endian: le

seq:
  - id: loading_screens
    type: loading_screen_t
    repeat: eos

types:
  loading_screen_t:
    seq:
      - id: mission_name
        type: str
        encoding: ascii
        size: 32
      - id: image_filename
        type: str
        encoding: ascii
        size: 32
      - id: text_id # see textdb_xx.def file
        type: u4