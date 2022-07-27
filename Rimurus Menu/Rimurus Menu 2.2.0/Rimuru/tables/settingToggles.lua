local states = {}

-- player states
states["typing"] = true
states["paused"] = false
states["vip"] = false

-- net events
states["REQUEST_PICKUP_EVENT"] = false
states["ALTER_WANTED_LEVEL_EVENT"] = false
states["KICK_VOTES_EVENT"] = false

-- menu settings
states["embedScripts"] = true
states["controllerSupport"] = false

return states