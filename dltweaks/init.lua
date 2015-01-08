
-- stone recipe creates 2 (sand)stonebrick from 4 (sand)stone (was 1:4)
minetest.register_craft({
	output = 'default:stonebrick 2',
	recipe = {
		{'default:stone', 'default:stone'},
		{'default:stone', 'default:stone'},
	}
})
minetest.register_craft({
        output = 'default:sandstonebrick 2',
        recipe = {
                {'default:sandstone', 'default:sandstone'},
                {'default:sandstone', 'default:sandstone'},
        }
})

-- Craft clay from dirt
minetest.register_craft({
	output = 'default:clay_lump',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:dirt'},
		{'default:dirt', 'default:dirt', 'default:dirt'},
	}
})

-- Smelt (char)coal from a tree or jungletree
minetest.register_craft({
        type = "cooking",
        output = "default:coal_lump",
	recipe = "group:tree",
})

-- Func for modifying already registered tools/etc taken from CasimirKaPazi's
-- Stoneage mod, which is more realistic and difficult then regular minetest
-- Get it from https://github.com/CasimirKaPazi/stoneage
local entity
local registered = function(case,name)
        local params = {}
        local list
        if case == "item" then list = minetest.registered_items end
        if case == "node" then list = minetest.registered_nodes end
        if case == "craftitem" then list = minetest.registered_craftitems end
        if case == "tool" then list = minetest.registered_tools end
        if case == "entity" then list = minetest.registered_entities end
        if list then
                for k,v in pairs(list[name]) do
                        params[k] = v
                end
        end
        return params
end

-- Trees fall down when chopped - also for cacti/papyrus?
-- FIXME TODO: Make this optional with a config
entity = registered("node","default:tree")
entity.groups = {tree=1,falling_node=1,choppy=2,oddly_breakable_by_hand=1,flammable=2}
minetest.register_node(":default:tree", entity)

entity = registered("node","default:jungletree")
entity.groups = {tree=1,falling_node=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
minetest.register_node(":default:jungletree", entity)

-- Axes more effective
entity = registered("tool","default:axe_stone")
entity.tool_capabilities = {
                full_punch_interval = 1.2,
                max_drop_level=0,
                groupcaps={
                        choppy={times={[1]=1.50, [2]=1.00, [3]=0.75}, uses=20, maxlevel=1},
                },
                damage_groups = {fleshy=3},
}
minetest.register_tool(":default:axe_stone", entity)
-- FIXME TODO other axes

-- Modify: Wooden axe/pickaxe less effective and break quicker
entity = registered("tool","default:axe_wood")
entity.tool_capabilities = {
	full_punch_interval = 1.5,
	max_drop_level=0,
	groupcaps={
		choppy = {times={[2]=3.00, [3]=2.00}, uses=2, maxlevel=1},
	},
	damage_groups = {fleshy=2},
}
minetest.register_tool(":default:axe_wood", entity)

entity = registered("tool","default:pick_wood")
entity.tool_capabilities = {
	full_punch_interval = 2.4,
	max_drop_level=0,
	groupcaps={
		cracky = {times={[3]=1.60}, uses=1, maxlevel=1},
	},
	damage_groups = {fleshy=2},
}
minetest.register_tool(":default:pick_wood", entity)

-- Lava sounds TODO: may be buggy?
minetest.register_abm({
        nodenames = {"default:lava_source"},
        interval = 12,
        chance = 128,
        action = function(pos, node, active_object_count, active_object_count_wider)
                minetest.sound_play("fire_small", {pos = pos, gain = 0.05, max_hear_distance = 20})
end})

-- More items as fuel
minetest.register_craft({
        type = "fuel",
        recipe = "group:flower",
        burntime = 1,
})
minetest.register_craft({
        type = "fuel",
        recipe = "default:stick",
        burntime = 2,
})
minetest.register_craft({
        type = "fuel",
        recipe = "doors:door_wood",
        burntime = 10,
})
minetest.register_craft({
        type = "fuel",
        recipe = "default:ladder",
        burntime = 7,
})
minetest.register_craft({
        type = "fuel",
        recipe = "default:fence_wood",
        burntime = 4,
})
minetest.register_craft({
        type = "fuel",
        recipe = "default:bookshelf",
        burntime = 30,
})

