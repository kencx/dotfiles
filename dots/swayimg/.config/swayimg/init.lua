local _g = swayimg.gallery
local _i = swayimg.imagelist
local _s = swayimg.slideshow
local _v = swayimg.viewer

swayimg.set_mode("viewer")
swayimg.enable_decoration(false)

-- image list
_i.set_order("alpha")
_i.enable_reverse(false)
_i.enable_recursive(false)
_i.enable_adjacent(false)
-- si.enable_fsmon(true)

-- text
swayimg.text.hide()
swayimg.text.set_font("monospace")
swayimg.text.set_size(14)
swayimg.text.set_foreground(0xffcccccc)
swayimg.text.set_background(0x00000000)
swayimg.text.set_shadow(0x0d000000)

-- viewer
_v.set_default_scale("optimal")
_v.set_default_position("center")
-- _v.set_window_background("#00000000")
_v.enable_loop(true)
_v.limit_preload(1)
-- _v.limit_history(1)

local bind_g = function(key, action)
	_g.on_key(key, function()
		action(_g)
	end)
end
local bind_s = function(key, action)
	_s.on_key(key, function()
		action(_s)
	end)
end
local bind_v = function(key, action)
	_v.on_key(key, function()
		action(_v)
	end)
end
local bind_gs = function(key, action)
	bind_g(key, action)
	bind_s(key, action)
end
local bind_gv = function(key, action)
	bind_g(key, action)
	bind_v(key, action)
end
local bind_sv = function(key, action)
	bind_s(key, action)
	bind_v(key, action)
end

local bind = function(key, action)
	bind_g(key, function()
		action(_g)
	end)
	bind_s(key, function()
		action(_s)
	end)
	bind_v(key, function()
		action(_v)
	end)
end

bind("q", function()
	swayimg.exit()
end)
bind("Escape", function()
	swayimg.exit()
end)

bind_v("Left", function()
	_v.switch_image("prev")
end)
bind_v("Right", function()
	_v.switch_image("next")
end)
bind_v("j", function()
	_v.switch_image("prev")
end)
bind_v("k", function()
	_v.switch_image("next")
end)

bind_v("Return", function()
	swayimg.set_mode("gallery")
end)

-- slideshow
swayimg.slideshow.set_timeout(3)
swayimg.slideshow.set_default_scale("fit")
swayimg.slideshow.set_window_background("auto")

-- gallery
swayimg.gallery.set_aspect("fill")
swayimg.gallery.set_thumb_size(200)
swayimg.gallery.set_padding_size(5)
swayimg.gallery.set_border_size(5)
swayimg.gallery.limit_cache(100)
swayimg.gallery.enable_preload(false)
swayimg.gallery.enable_pstore(false)
swayimg.gallery.set_border_color(0xffaaaaaa)
swayimg.gallery.set_selected_scale(1.15)
swayimg.gallery.set_selected_color(0xff404040)
swayimg.gallery.set_unselected_color(0xff202020)
swayimg.gallery.set_selected_scale(1.15)
