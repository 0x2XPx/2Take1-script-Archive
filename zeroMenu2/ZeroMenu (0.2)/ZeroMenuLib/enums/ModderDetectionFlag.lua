local eModderDetectionFlags = {
MDF_MANUAL          = 1 << 0x00,
  MDF_PLAYER_MODEL      = 1 << 0x01,
  MDF_SCID_0          = 1 << 0x02,
  MDF_SCID_SPOOF        = 1 << 0x03,
  MDF_INVALID_OBJECT_CRASH  = 1 << 0x04,
  MDF_INVALID_PED_CRASH   = 1 << 0x05,
  MDF_CLONE_SPAWN       = 1 << 0x06,
  MDF_MODEL_CHANGE_CRASH    = 1 << 0x07,
  MDF_PLAYER_MODEL_CHANGE   = 1 << 0x08,
  MDF_RAC           = 1 << 0x09,
  MDF_MONEY_DROP        = 1 << 0x0A,
  MDF_SEP           = 1 << 0x0B,
  MDF_ATTACH_OBJECT     = 1 << 0x0C,
  MDF_ATTACH_PED        = 1 << 0x0D,

  MDF_ENDS          = 1 << 0x0E
}

return eModderDetectionFlags;