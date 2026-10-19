meta:
  id: mafia_format_cache
  file-extension: bin
  endian: le

seq:
  - id: file_signature
    contents: [0xF4, 0x01]
  - id: file_size
    type: u4
  - id: version
    contents: [0x01, 0x00, 0x00, 0x00]
  - id: objects
    type: object_t
    repeat: eos

types:
  object_t:
    seq:
      - id: signature   # 0x(D0 07)
        type: u2
      - id: object_size
        type: u4
      - id: object_name_size
        type: u4
      - id: object_name
        type: str
        encoding: ASCII
        size: object_name_size
      - id: unknown
        type: u1
        repeat: expr
        repeat-expr: 0x4C
      - id: instances
        type: instances_t
        size: object_size - object_name_size - 86 # 86 is size of ^

  instances_t:
    seq:
      - id: instances
        type: instance_t
        repeat: eos

  instance_t:
    seq:
      - id: signature # 0x(E8 03)
        type: u2
      - id: instance_size
        type: u4
      - id: model_name_size
        type: u4
      - id: model_name
        type: str
        encoding: ASCII
        size: model_name_size
      - id: position
        type: vector3_float_t
      - id: rotation
        type: quaternion_t
      - id: scale
        type: vector3_float_t
      - id: unknown
        type: u4
      - id: scale2 # sometimes used
        type: vector3_float_t

  vector3_float_t:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

  quaternion_t:
    seq:
      - id: re_w
        type: f4
      - id: im_x
        type: f4
      - id: im_y
        type: f4
      - id: im_z
        type: f4
