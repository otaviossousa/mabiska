extends Node

const FUSION_TABLE = {
	# Básico + Básico = Secundário
	["air", "earth"]: "sand",
	["earth", "air"]: "sand",

	["fire", "air"]: "lightning",
	["air", "fire"]: "lightning",

	["water", "air"]: "mist",
	["air", "water"]: "mist",

	["fire", "earth"]: "magma",
	["earth", "fire"]: "magma",

	["water", "earth"]: "clay",
	["earth", "water"]: "clay",

	["water", "fire"]: "steam",
	["fire", "water"]: "steam",

	# Básico + Secundário = Terciário
	["magma", "air"]: "glass",
	["magma", "water"]: "basalt",
	["magma", "earth"]: "obsidian",
	["magma", "fire"]: "ceramic",

	["lightning", "earth"]: "magnetite",
	["lightning", "water"]: "charged mist",
	["lightning", "fire"]: "stormstone",

	["sand", "water"]: "mud",
	["sand", "fire"]: "ash",
	["sand", "air"]: "stained glass",
	["sand", "earth"]: "frost",

	["mist", "earth"]: "swamp",
	["mist", "fire"]: "steam",
	["mist", "air"]: "cloud",
	["mist", "water"]: "fog",

	["clay", "fire"]: "brick",
	["clay", "air"]: "guardian",
	["clay", "earth"]: "idol",
	["clay", "water"]: "mill",

	["steam", "earth"]: "geyser",
	["steam", "air"]: "smoke",
	["steam", "fire"]: "furnace",
	["steam", "water"]: "mirror",

	# Secundário + Secundário = Terciário
	["glass", "lightning"]: "radiance",
	["magnetite", "mist"]: "engine",
	["magma", "mist"]: "halo",
	["clay", "lightning"]: "golem",
	["obsidian", "mist"]: "blade",
	["glass", "smoke"]: "dark mirror",
	["magma", "clay"]: "ceramic",
	["mist", "sand"]: "velarim",
	["steam", "sand"]: "silhain",

	# Terciário + Básico = Quaternário
	["radiance", "earth"]: "crystal",
	["radiance", "water"]: "prism",
	["radiance", "air"]: "halo",
	["radiance", "fire"]: "solar flame",
	["obsidian", "water"]: "shard",
	["obsidian", "air"]: "blade",
	["engine", "fire"]: "furnace",
	["engine", "water"]: "mill",
	["golem", "air"]: "spirit golem",
	["golem", "earth"]: "guardian",
	["frost", "fire"]: "tears",
	["basalt", "air"]: "basalt dust",
	["charged mist","earth"]: "thunder",
	["geyser","air"]: "aureol"
}

static func get_fusion_result(e1: String, e2: String) -> String:
	var pair = [e1, e2]
	pair.sort() # garante que sempre usa a mesma ordem
	return FUSION_TABLE.get(pair, "")
