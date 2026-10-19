meta:
  id: mafia_format_taxi_pas
  file-extension: dat
  endian: le

seq:
  - id: magic_number1
    contents: [0x01, 0x00, 0x00, 0x00, 0x00]
  - id: magic_number2
    type: u4
  - id: magic_number3
    contents: ['[', 'd', 'e', 'b', 'u', 'g', '_', 'm', 'e', ']', 0x0D, 0x0A]
  - id: script_text
    type: script_line_t
    repeat: eos

types:
  script_line_t:
    seq:
      - id: line_of_code
        type: str
        encoding: ascii
        terminator: 0x0a
