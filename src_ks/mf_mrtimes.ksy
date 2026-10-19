meta:
  id: mrtimes
  file-extension: mrtimes
  endian: le

seq:
  - id: riders_count
    type: u4
  - id: riders
    type: rider_t
    repeat: expr
    repeat-expr: riders_count
  - id: payload_zeors
    type: u1
    repeat: expr
    repeat-expr: 40

types: 
  rider_t:
    seq:
      - id: rider_name
        type: str
        encoding: ascii
        terminator: 0
      - id: unused
        type: str
        encoding: ascii
        terminator: 1
      - id: unused_zero
        type: u1
