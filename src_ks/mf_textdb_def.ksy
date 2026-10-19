meta:
  id: mafia_format_textdb
  file-extension: def
  endian: le

seq:
  - id: header
    type: header_t
  - id: blocks
    type: block_t
    repeat: expr
    repeat-expr: header.strings_count
  - id: text
    type: str
    encoding: ASCII
    terminator: 0
    repeat: expr
    repeat-expr: header.strings_count

types:
  header_t:
    seq:
      - id: strings_count
        type: u4
      - id: unknow1
        type: u4

  block_t:
    seq:
      - id: id
        type: u4
      - id: offset
        type: u4
