extends Node

const FUSION_TABLE = {
	# Básico + Básico = Secundário
	["air", "earth"]: "sand",
	["air", "fire"]: "lightning",
	["air", "water"]: "mist",
	["earth", "fire"]: "magma",
	["earth", "water"]: "clay",
	["fire", "water"]: "steam",

	# Básico + Secundário = Terciário
	["air", "magma"]: "glass",
	["magma", "water"]: "basalt",
	["earth", "magma"]: "obsidian",
	["fire", "magma"]: "ceramic",

	["earth", "lightning"]: "magnetite",
	["lightning", "water"]: "charged mist",
	["fire", "lightning"]: "stormstone",

	["sand", "water"]: "mud",
	["fire", "sand"]: "ash",
	["air", "sand"]: "stained glass",
	["earth", "sand"]: "frost",

	["earth", "mist"]: "swamp",
	["fire", "mist"]: "steam",
	["air", "mist"]: "cloud",
	["mist", "water"]: "fog",

	["clay", "fire"]: "brick",
	["air", "clay"]: "guardian",
	["clay", "earth"]: "idol",
	["clay", "water"]: "mill",

	["earth", "steam"]: "geyser",
	["air", "steam"]: "smoke",
	["fire", "steam"]: "furnace",
	["steam", "water"]: "mirror",

	# Secundário + Secundário = quaternário
	["glass", "lightning"]: "radiance",
	["magnetite", "mist"]: "engine",
	["magma", "mist"]: "halo",
	["clay", "lightning"]: "golem",
	["mist", "obsidian"]: "blade",
	["glass", "smoke"]: "dark mirror",
	["clay", "magma"]: "ceramic",
	["mist", "sand"]: "velarim",
	["sand", "steam"]: "silhain",

	# Terciário + Básico = Quaternário
	["earth", "radiance"]: "crystal",
	["radiance", "water"]: "prism",
	["air", "radiance"]: "halo",
	["fire", "radiance"]: "solar flame",
	["obsidian", "water"]: "shard",
	["air", "obsidian"]: "blade",
	["fire", "engine"]: "furnace",
	["engine", "water"]: "mill",
	["air", "golem"]: "spirit golem",
	["earth", "golem"]: "guardian",
	["fire", "frost"]: "tears",
	["air", "basalt"]: "basalt dust",
	["charged mist","earth"]: "thunder",
	["air","geyser"]: "aureol",
	
	["magnetite","water"]: "philo"
}

static func get_fusion_result(e1: String, e2: String) -> String:
	var pair = [e1, e2]
	pair.sort() # garante que sempre usa a mesma ordem
	return FUSION_TABLE.get(pair, "")
