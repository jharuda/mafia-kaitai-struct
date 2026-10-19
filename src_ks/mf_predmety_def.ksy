meta:
  id: mafia_format_predmety
  file-extension: def
  endian: le

seq:
  - id: guns
    type: gun_t
    repeat: eos

types:
  gun_t:
    seq:
      - id: gun_name
        type: str
        encoding: ascii
        size: 32
      - id: gun_size # pistol is small and Thompson is big
        type: u1
        enum: gun_size_e
      - id: has_optical_sight
        type: u1
        enum: has_optical_sight_e
      - id: unknown
        type: u2
      - id: model_filename # it includes .4ds part in the name
        type: str
        encoding: ascii
        size: 32
      - id: parameters
        type: parameters_t

  parameters_t:
    seq:
      - id: unknown
        type: u4
        repeat: expr
        repeat-expr: 4
      - id: sound
        type: u4
        enum: shot_sound_e
      - id: unknown2
        type: u4
      - id: holding_style
        type: u4
        enum: holding_style_e
      - id: ammo_loaded_max
        type: u4
      - id: ammo_in_magazines_max
        type: u4
      - id: unknown3
        type: u4
      - id: unknown4
        type: u4
      - id: unknown5
        type: u4
      - id: firing_range
        type: f4
      - id: damage
        type: f4
      - id: unknown6
        type: u4
      - id: unknown7
        type: u4
      - id: recoil
        type: f4   # max 0.9
      - id: unknown8
        type: u4
      - id: unknown9
        type: u4
      - id: rate_of_fire
        type: u4
      - id: unknown10
        type: u4
      - id: realoding_time
        type: u4
      - id: param2
        type: u4
        repeat: expr
        repeat-expr: 8

enums:
  gun_size_e:
    0x00:
      id: hidden_items_and_thinks_you_cant_hide # examples: bucket, keys...
    0x01:
      id: unknown
    0x04:
      id: thinks_you_can_hide # knife
    0x22:
      id: big_gun
    0x20:
      id: small_gun
    0xA0:
      id: throwing

  has_optical_sight_e:
    0x00:
      id: no_hasnt
    0x01:
      id: hidden_items # like documents, keys,..
    0x20:
      id: other_close_range_weapons # like baseball bat
    0x40:
      id: yes_has
      
  shot_sound_e:
    0x00:
      id: no_sound
    0x3f:
      id: knuckle_duster
    0x41:
      id: knife
    0x42:
      id: bit
    0x43:
      id: saw_ds
    0x44:
      id: saw_magnum27
    0x45:
      id: saw_model10
    0x46:
      id: colt1911
    0x47:
      id: thompson
    0x48:
      id: shotgun
    0x49:
      id: sawed_off_shotgun
    0x4A:
      id: springfield_m1903
    0xBD:
      id: mosin_naganth
  
  holding_style_e:
    0x00:
      id: hidden_item
    0x01:
      id: one_hand_pistol
    0x02:
      id: rifles
    0x03:
      id: thompson_and_shotguns
    0x04:
      id: throwing_weapons
    0x05:
      id: on_the_fist # knuckle duster
    0x06:
      id: knife
    0x07:
      id: both_hands_close_range_fight # baseball bat
  
      