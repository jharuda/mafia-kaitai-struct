meta:
  id: mafia_format_credits
  file-extension: def
  endian: le

seq:
  - id: credits
    type: credits_row_t
    repeat: eos

types:
  credits_row_t:
    seq:
      - id: align_sign
        type: u1
        enum: title_type
      - id: unknown
        type: u1
        repeat: expr
        repeat-expr: 7
      - id: text_id
        type: u4
      - id: row_text_part_1
        type: str
        encoding: ascii
        size: 64
      - id: row_text_part_2
        type: str
        encoding: ascii
        size: 64

enums:
  title_type:
    0x41: # A
      id: textid_one_column_author_font
    0x42: # B
      id: part1_part2_two_columns
    0x43: # C
      id: textid_part1
    0x44: # D
      id: textid_part1_two_columns
    0x45: # E
      id: part1_part2_smaller_two_columns
    0x46: # F
      id: textid_middle_smaller_author_font
    0x47: # G
      id: part1_middle
