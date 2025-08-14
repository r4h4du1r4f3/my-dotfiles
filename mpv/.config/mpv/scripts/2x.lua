-- Speed toggle script for MPV
-- Toggles playback speed between 1x and 2x

-- Initialize a variable to keep track of the current state
local speed_toggled = false

-- Function to toggle the speed
function toggle_speed()
    if speed_toggled then
        -- If currently at 2x, set back to 1x
        mp.set_property("speed", 1.0)
        mp.osd_message("Speed: 1x")
    else
        -- If currently at 1x, set to 2x
        mp.set_property("speed", 2.0)
        mp.osd_message("Speed: 2x")
    end
    -- Toggle the state
    speed_toggled = not speed_toggled
end

-- Bind the toggle_speed function to the 's' key
mp.add_key_binding("/", "toggle_speed", toggle_speed)
