menu.add_player_feature("Send To Island", "toggle", 0, function(feat, pid)
if feat.on then
system.wait(2)
script.trigger_script_event(0x4d8b1e65, pid, {1300962917})
end
return HANDLER_CONTINUE
end)