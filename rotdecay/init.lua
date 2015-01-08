
-- Controls overall decay amount - higher numbers = slower decay
rotdecaymax = 12

-- Function registers an ABM for the node, takes arguments:
-- Node name of the block to rot, node name it becomes (can be air),
-- Interval to run, chance to run inverted (abn args)
-- Based on the stoneage mod.
-- 
function register_rot(nodename, becomes, intrvl, chnce)
	minetest.register_abm({
	nodenames = {nodename},
	interval = intrvl,
	chance = chnce,

	action = function(pos, node)
                local meta = minetest.env:get_meta(pos)
                local decay = meta:get_int("rot_decay")
                if not decay then
                        meta:set_int("rot_decay", 1)
                        return
                end
                if decay >= rotdecaymax then
			-- Debugging:
			minetest.chat_send_all(node.name .. " decayed to " .. becomes)
			node.name = becomes
			minetest.env:add_node(pos, node)
			meta:set_int("rot_decay", 0)
			return
		end
                decay = decay + 1
		-- Debugging:
		-- minetest.chat_send_all(node.name .. " decay " .. decay)
                meta:set_int("rot_decay", decay)
	end
	})
end


-- Entries for each item start here

register_rot("default:junglewood", "air", 16, 40)
register_rot("stairs:stair_junglewood", "air", 16, 40)
register_rot("stairs:slab_junglewood", "air", 16, 40)

register_rot("default:wood", "air", 16, 32)
register_rot("stairs:stair_wood", "air", 16, 32)
register_rot("stairs:slab_wood", "air", 16, 32)

register_rot("default:cobble", "default:gravel", 64, 256)
register_rot("stairs:stair_cobble", "default:gravel", 64, 256)
register_rot("stairs:slab_cobble", "air", 64, 256)

register_rot("default:glass", "air", 8, 64)
register_rot("default:sandstone", "default:sand", 16, 128)

-- TODO wool - use for loop from default:wool mod?

