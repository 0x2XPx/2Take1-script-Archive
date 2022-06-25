function show_alert_screen(alert_scaleform, seconds, title_text, warning_text, prompt, show_background, alert_type, error_text)
    graphics.begin_scaleform_movie_method(alert_scaleform, "SHOW_POPUP_WARNING")
    graphics.scaleform_movie_method_add_param_float(seconds)
    graphics.scaleform_movie_method_add_param_texture_name_string(title_text)
    graphics.scaleform_movie_method_add_param_texture_name_string(warning_text)
    graphics.scaleform_movie_method_add_param_texture_name_string(prompt)
    graphics.scaleform_movie_method_add_param_bool(show_background)
    graphics.scaleform_movie_method_add_param_int(alert_type)
    graphics.scaleform_movie_method_add_param_texture_name_string(error_text)
    graphics.end_scaleform_movie_method(alert_scaleform)
end

function show_wasted_screen(wasted_scaleform, title_text, small_text, id, unk0, darken_background)
    graphics.begin_scaleform_movie_method(wasted_scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    graphics.draw_scaleform_movie_fullscreen(wasted_scaleform, 255, 255, 255, 255, 0)
    graphics.scaleform_movie_method_add_param_texture_name_string(title_text)
    graphics.scaleform_movie_method_add_param_texture_name_string(small_text)
    graphics.scaleform_movie_method_add_param_int(id)
    graphics.scaleform_movie_method_add_param_bool(unk0)
    graphics.scaleform_movie_method_add_param_bool(darken_background)
    graphics.end_scaleform_movie_method(wasted_scaleform)
end

function show_sniper_scope(scope_scaleform, zoom_level, wind_value, direction_is_right)
    graphics.begin_scaleform_movie_method(scope_scaleform, "SET_ZOOM_LEVEL")
    graphics.draw_scaleform_movie_fullscreen(scope_scaleform, 255, 255, 255, 255, 0)
    graphics.scaleform_movie_method_add_param_int(zoom_level)

    graphics.begin_scaleform_movie_method(scope_scaleform, "SET_WIND")
    graphics.scaleform_movie_method_add_param_int(wind_value)
    graphics.scaleform_movie_method_add_param_bool(direction_is_right)

    graphics.begin_scaleform_movie_method(scope_scaleform, "update")
    graphics.end_scaleform_movie_method(scope_scaleform)
end

function show_yacht_name(yacht_scaleform, yacht_text, is_text_white, country_text)
    graphics.begin_scaleform_movie_method(yacht_scaleform, "SET_YACHT_NAME")
    graphics.draw_scaleform_movie(yacht_scaleform, 500, 500, 1.0, 1.0, 255, 255, 255, 255, 0)
    graphics.scaleform_movie_method_add_param_texture_name_string(yacht_text)
    graphics.scaleform_movie_method_add_param_bool(is_text_white)
    graphics.scaleform_movie_method_add_param_texture_name_string(country_text)
    graphics.end_scaleform_movie_method(yacht_scaleform)
end

function show_instructional_buttons(button_scaleform)
    graphics.begin_scaleform_movie_method(button_scaleform, "SET_DISPLAY_CONFIG")
    graphics.draw_scaleform_movie_fullscreen(button_scaleform, 255, 255, 255, 255, 0)
    graphics.scaleform_movie_method_add_param_int(graphics.get_screen_width())
    graphics.scaleform_movie_method_add_param_int(graphics.get_screen_height())

    graphics.scaleform_movie_method_add_param_int(5)
    graphics.scaleform_movie_method_add_param_int(5)
    graphics.scaleform_movie_method_add_param_int(5)
    graphics.scaleform_movie_method_add_param_int(5)

    graphics.scaleform_movie_method_add_param_bool(true)
    graphics.scaleform_movie_method_add_param_bool(false)
    graphics.scaleform_movie_method_add_param_bool(false)

    graphics.scaleform_movie_method_add_param_int(graphics.get_screen_width())
    graphics.scaleform_movie_method_add_param_int(graphics.get_screen_height())
end