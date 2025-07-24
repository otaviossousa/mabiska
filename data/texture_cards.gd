extends Node

const TEXTURES = {
	# bases
	"fire": preload("res://assets/cards-assets/base_cards/20_Element_Fire.png"),
	"water": preload("res://assets/cards-assets/base_cards/23_Element_Water.png"),
	"earth": preload("res://assets/cards-assets/base_cards/25_Element_Earth.png"),
	"air": preload("res://assets/cards-assets/base_cards/22_Element_Air.png"),
	
	# secondary
	"sand": preload("res://assets/cards-assets/secondary_cards/Element_Sand.png"),
	"lightning": preload("res://assets/cards-assets/secondary_cards/Element_Lightning.png"),
	"mist": preload("res://assets/cards-assets/secondary_cards/Element_Mist.png"),
	"magma": preload("res://assets/cards-assets/secondary_cards/Element_Magma.png"),
	"clay": preload("res://assets/cards-assets/secondary_cards/Element_Clay.png"),
	"steam": preload("res://assets/cards-assets/secondary_cards/Element_Steam.png"),
	
	#third
	"ash": preload("res://assets/cards-assets/terciary_cards/Element_Ash.png"),
	"basalt": preload("res://assets/cards-assets/terciary_cards/Element_Basalt.png"),
	"brick": preload("res://assets/cards-assets/terciary_cards/Element_Brick.png"),
	"charged mist": preload("res://assets/cards-assets/terciary_cards/Element_ChargedMist.png"),
	"engine": preload("res://assets/cards-assets/terciary_cards/Element_Engine.png"),
	"frosted glass": preload("res://assets/cards-assets/terciary_cards/Element_FrostedGlass.png"),
	"geyser": preload("res://assets/cards-assets/terciary_cards/Element_Geyser.png"),
	"glass": preload("res://assets/cards-assets/terciary_cards/Element_Glass.png"),
	"golem": preload("res://assets/cards-assets/terciary_cards/Element_Golem.png"),
	"magnetite": preload("res://assets/cards-assets/terciary_cards/Element_Magnetite.png"),
	"mud": preload("res://assets/cards-assets/terciary_cards/Element_Mud.png"),
	"obsidian": preload("res://assets/cards-assets/terciary_cards/Element_Obsidian.png"),
	"radiance": preload("res://assets/cards-assets/terciary_cards/Element_Radiance.png"),
	"smoke": preload("res://assets/cards-assets/terciary_cards/Element_Smoke.png"),
	"swamp": preload("res://assets/cards-assets/terciary_cards/Element_Swamp.png"),
	
	#fourth
	"blade": preload("res://assets/cards-assets/quartenary_cards/Element_Blade.png"),
	"ceramic": preload("res://assets/cards-assets/quartenary_cards/Element_Ceramic.png"),
	"cinder": preload("res://assets/cards-assets/quartenary_cards/Element_Cinder.png"),
	"cloud": preload("res://assets/cards-assets/quartenary_cards/Element_Cloud.png"),
	"crystal": preload("res://assets/cards-assets/quartenary_cards/Element_Crystal.png"),
	"dark mirror": preload("res://assets/cards-assets/quartenary_cards/Element_DarkMirror.png"),
	"fog": preload("res://assets/cards-assets/quartenary_cards/Element_Fog.png"),
	"frost": preload("res://assets/cards-assets/quartenary_cards/Element_Frost.png"),
	"furnace": preload("res://assets/cards-assets/quartenary_cards/Element_Furnace.png"),
	"guardian": preload("res://assets/cards-assets/quartenary_cards/Element_Guardian.png"),
	"halo": preload("res://assets/cards-assets/quartenary_cards/Element_Halo.png"),
	"idol": preload("res://assets/cards-assets/quartenary_cards/Element_Idol.png"),
	"mill": preload("res://assets/cards-assets/quartenary_cards/Element_Mill.png"),
	"mirror": preload("res://assets/cards-assets/quartenary_cards/Element_Mirror.png"),
	"prism": preload("res://assets/cards-assets/quartenary_cards/Element_Prism.png"),
	"shard": preload("res://assets/cards-assets/quartenary_cards/Element_shard.png"),
	"solar flame": preload("res://assets/cards-assets/quartenary_cards/Element_SolarFlame.png"),
	"spirit golem": preload("res://assets/cards-assets/quartenary_cards/Element_SpiritGolem.png"),
	"stained glass": preload("res://assets/cards-assets/quartenary_cards/Element_Stained Glass.png"),
	"storm stone": preload("res://assets/cards-assets/quartenary_cards/Element_Stormstone.png"),
	"tears": preload("res://assets/cards-assets/quartenary_cards/Element_Tears.png"),
	"basalt dust": preload("res://assets/cards-assets/quartenary_cards/Element_BasaltDust.png"),
	"thunder": preload("res://assets/cards-assets/quartenary_cards/Element_Thunder.png"),
	"velarim": preload("res://assets/cards-assets/quartenary_cards/Element_Velarim.png"),
	"aureol": preload("res://assets/cards-assets/quartenary_cards/Element_Aureolo.png"),
	"silhain": preload("res://assets/cards-assets/quartenary_cards/Element_Silhain.png"),
	
	"philo": preload("res://assets/cards-assets/quartenary_cards/Element_Philo.png")
}

static func get_texture(element: String) -> Texture2D:
	if TEXTURES.has(element):
		return TEXTURES[element]
	return null
