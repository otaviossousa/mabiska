extends Node

const DESCRIPTIONS = {
	# === CARTAS BÁSICAS ===
	"fire": {
		"name": "Fogo",
		"type": "Elemento Básico",
		"description": "O elemento primordial da paixão e transformação. Representa a energia ardente do amor verdadeiro que pode derreter qualquer maldição.",
		"lore": "A chama que arde no coração do príncipe, mesmo em sua forma de sapo."
	},
	"water": {
		"name": "Água",
		"type": "Elemento Básico", 
		"description": "O elemento da purificação e renovação. Suas águas cristalinas podem lavar as impurezas mais profundas da alma.",
		"lore": "As lágrimas de amor derramadas pela princesa ao ver seu amado transformado."
	},
	"earth": {
		"name": "Terra",
		"type": "Elemento Básico",
		"description": "O elemento da estabilidade e crescimento. Fornece a base sólida necessária para construir novos caminhos.",
		"lore": "O solo fértil onde florescerá a esperança de uma nova vida juntos."
	},
	"air": {
		"name": "Ar",
		"type": "Elemento Básico",
		"description": "O elemento da liberdade e mudança. Carrega consigo os sussurros dos ventos que trazem novas possibilidades.",
		"lore": "O sopro de vida que pode quebrar até os feitiços mais poderosos."
	},

	# === CARTAS SECUNDÁRIAS ===
	"sand": {
		"name": "Areia",
		"type": "Elemento Secundário",
		"description": "Fusão de Ar + Terra. Grãos finos que marcam a passagem do tempo e a persistência do amor.",
		"lore": "Como areia em uma ampulheta, cada grão conta na jornada de volta à forma humana."
	},
	"lightning": {
		"name": "Raio",
		"type": "Elemento Secundário",
		"description": "Fusão de Ar + Fogo. A centelha divina que pode iluminar até as trevas mais profundas.",
		"lore": "O primeiro sinal de esperança - a luz que surgiu quando o amor verdadeiro se manifestou."
	},
	"mist": {
		"name": "Névoa",
		"type": "Elemento Secundário",
		"description": "Fusão de Ar + Água. Uma bruma etérea que oculta mistérios e revela verdades ocultas.",
		"lore": "A névoa que encobre os segredos da magia ancestral."
	},
	"magma": {
		"name": "Magma",
		"type": "Elemento Secundário",
		"description": "Fusão de Terra + Fogo. O núcleo ardente da determinação que derrete qualquer obstáculo.",
		"lore": "A força interior que permanece incandescente mesmo nas provações mais difíceis."
	},
	"clay": {
		"name": "Argila",
		"type": "Elemento Secundário",
		"description": "Fusão de Terra + Água. Material moldável que representa a capacidade de transformação e adaptação.",
		"lore": "Como um oleiro habilidoso, o amor pode remodelar qualquer destino."
	},
	"steam": {
		"name": "Vapor",
		"type": "Elemento Secundário",
		"description": "Fusão de Fogo + Água. A união harmoniosa de opostos que gera poder transformador.",
		"lore": "Quando elementos contrários se unem em harmonia, milagres podem acontecer."
	},

	# === CARTAS TERCIÁRIAS ===
	"glass": {
		"name": "Vidro",
		"type": "Elemento Terciário",
		"description": "Fusão de Ar + Magma. Material transparente que permite ver a verdade com clareza.",
		"lore": "Como um espelho mágico, revela a beleza interior que permanece inalterada."
	},
	"magnetite": {
		"name": "Magnetita",
		"type": "Elemento Terciário",
		"description": "Fusão de Terra + Raio. Pedra magnética que atrai elementos essenciais para a transformação final.",
		"lore": "O penúltimo passo - uma pedra que atrai a solução para todos os problemas."
	},
	"obsidian": {
		"name": "Obsidiana",
		"type": "Elemento Terciário",
		"description": "Fusão de Terra + Magma. Vidro vulcânico negro, forjado nas profundezas da terra.",
		"lore": "Nascida do fogo e da terra, representa a força que emerge das maiores pressões."
	},
	"basalt": {
		"name": "Basalto",
		"type": "Elemento Terciário",
		"description": "Fusão de Magma + Água. Rocha vulcânica que simboliza a solidificação de sonhos ardentes.",
		"lore": "Quando a paixão encontra a serenidade, estruturas duradouras são formadas."
	},

	# === CARTAS QUATERNÁRIAS ===
	"crystal": {
		"name": "Cristal",
		"type": "Elemento Quaternário",
		"description": "Fusão de Terra + Radiância. Estrutura perfeita que amplifica energias mágicas.",
		"lore": "Cada faceta reflete uma memória preciosa do tempo quando eram apenas príncipe e princesa."
	},
	"prism": {
		"name": "Prisma",
		"type": "Elemento Quaternário",
		"description": "Fusão de Radiância + Água. Divide a luz em todas as cores do arco-íris.",
		"lore": "Assim como o prisma revela as cores ocultas da luz, o amor revela as belezas ocultas da alma."
	},
	"phoenix": {
		"name": "Fênix",
		"type": "Elemento Quaternário",
		"description": "Fusão de Guardião + Fogo. Ave mítica que renasce das próprias cinzas.",
		"lore": "Símbolo da renovação - assim como a fênix, o amor verdadeiro sempre encontra um caminho para renascer."
	},
	"guardian": {
		"name": "Guardião",
		"type": "Elemento Quaternário",
		"description": "Fusão de Argila + Ar. Protetor etéreo moldado pela devoção e amor incondicional.",
		"lore": "O protetor silencioso que vigia cada passo da jornada de volta à humanidade."
	},

	# === CARTA ESPECIAL ===
	"philo": {
		"name": "Pedra Filosofal",
		"type": "Artefato Lendário",
		"description": "Fusão de Magnetita + Água. O objetivo final - capaz de reverter qualquer transformação mágica.",
		"lore": "A Pedra Filosofal! O artefato lendário que pode desfazer até os feitiços mais poderosos. Com ela, o príncipe pode voltar à sua forma humana e viver feliz para sempre com sua amada."
	},

	# === OUTRAS CARTAS IMPORTANTES ===
	"mirror": {
		"name": "Espelho",
		"type": "Elemento Quaternário",
		"description": "Fusão de Vapor + ?. Reflete não apenas a aparência, mas a essência verdadeira.",
		"lore": "Mostra não o sapo, mas o príncipe que ainda vive dentro da transformação."
	},
	"blade": {
		"name": "Lâmina",
		"type": "Elemento Quaternário",
		"description": "Fusão de Névoa + Obsidiana. Corta através das ilusões e falsas aparências.",
		"lore": "A espada da verdade que pode cortar até os laços mágicos mais resistentes."
	},
	"halo": {
		"name": "Auréola",
		"type": "Elemento Quaternário",
		"description": "Círculo de luz divina que abençoa aqueles tocados pelo amor verdadeiro.",
		"lore": "A coroa de luz que adornará novamente a cabeça do príncipe quando a maldição for quebrada."
	},
	"ceramic": {
		"name": "Cerâmica",
		"type": "Elemento Quaternário", 
		"description": "Fusão de Argila + Fogo. Material moldado e cozido, transformado pela experiência.",
		"lore": "Como a cerâmica no forno, o amor se fortalece através das provações."
	},
	"cloud": {
		"name": "Nuvem",
		"type": "Elemento Quaternário",
		"description": "Fusão de Ar + Névoa. Formação etérea que flutua entre o céu e a terra.",
		"lore": "Carrega consigo as lágrimas e esperanças de quem ama verdadeiramente."
	},
	"fog": {
		"name": "Neblina", 
		"type": "Elemento Quaternário",
		"description": "Fusão de Névoa + Água. Véu misterioso que oculta e revela simultaneamente.",
		"lore": "Na neblina do amanhecer, às vezes é possível ver glimpses do futuro."
	},
	"frost": {
		"name": "Geada",
		"type": "Elemento Quaternário",
		"description": "Fusão de Areia + ?. Cristais de gelo que preservam a beleza em sua forma mais pura.",
		"lore": "Mesmo no inverno mais rigoroso, o amor verdadeiro mantém o coração aquecido."
	},
	"furnace": {
		"name": "Fornalha",
		"type": "Elemento Quaternário",
		"description": "Fusão de Vapor + Fogo. Fonte de calor intenso que forja os metais mais resistentes.",
		"lore": "Na fornalha do destino, até os corações mais duros podem ser moldados pelo amor."
	},
	"idol": {
		"name": "Ídolo",
		"type": "Elemento Quaternário",
		"description": "Fusão de Argila + Terra. Estátua sagrada que representa devoção eterna.",
		"lore": "Símbolo de adoração inabalável - assim como a princesa ama seu príncipe sapo."
	},
	"mill": {
		"name": "Moinho",
		"type": "Elemento Quaternário",
		"description": "Fusão de Argila + Água. Transforma grãos em farinha, o bruto em refinado.",
		"lore": "Como o moinho mói o trigo, o tempo mói as dificuldades até que se tornem sabedoria."
	},
	"cinder": {
		"name": "Cinzas",
		"type": "Elemento Quaternário",
		"description": "Restos do que foi queimado, mas que ainda guardam o calor da transformação.",
		"lore": "Das cinzas do passado, um novo futuro pode sempre renascer."
	},
	"shard": {
		"name": "Fragmento",
		"type": "Elemento Quaternário",
		"description": "Fusão de Obsidiana + Água. Pedaço de algo maior que foi quebrado.",
		"lore": "Cada fragmento guarda uma memória preciosa dos tempos de felicidade."
	},
	"ash": {
		"name": "Cinza",
		"type": "Elemento Terciário",
		"description": "Fusão de Fogo + Areia. O que resta após a purificação pelo fogo.",
		"lore": "Das cinzas do desespero, a esperança sempre pode renascer."
	},
	"brick": {
		"name": "Tijolo",
		"type": "Elemento Terciário",
		"description": "Fusão de Argila + Fogo. Material de construção forte e duradouro.",
		"lore": "Tijolo por tijolo, o amor reconstrói o que foi quebrado pela maldição."
	},
	"charged mist": {
		"name": "Névoa Carregada",
		"type": "Elemento Terciário",
		"description": "Fusão de Raio + Água. Névoa eletrificada que pulsa com energia mágica.",
		"lore": "Carrega a eletricidade da paixão em cada gota de sua essência."
	},
	"engine": {
		"name": "Motor",
		"type": "Elemento Terciário",
		"description": "Fusão de Magnetita + Névoa. Mecanismo que converte energia em movimento.",
		"lore": "O motor que impulsiona a jornada em direção à redenção."
	},
	"geyser": {
		"name": "Gêiser",
		"type": "Elemento Terciário",
		"description": "Fusão de Terra + Vapor. Erupção de água quente das profundezas da terra.",
		"lore": "Como um gêiser, o amor verdadeiro irrompe com força inesperada."
	},
	"golem": {
		"name": "Golem",
		"type": "Elemento Terciário",
		"description": "Fusão de Argila + Raio. Guardião de argila animado por energia mágica.",
		"lore": "Protetor incansável moldado pela devoção e animado pelo amor."
	},
	"mud": {
		"name": "Lama",
		"type": "Elemento Terciário",
		"description": "Fusão de Areia + Água. Mistura terrosa que pode ser moldada em novas formas.",
		"lore": "Da lama mais humilde podem crescer as flores mais belas."
	},
	"radiance": {
		"name": "Radiância", 
		"type": "Elemento Terciário",
		"description": "Fusão de Vidro + Raio. Luz pura que irradia em todas as direções.",
		"lore": "A radiância do amor verdadeiro que ilumina até os caminhos mais sombrios."
	},
	"smoke": {
		"name": "Fumaça",
		"type": "Elemento Terciário",
		"description": "Fusão de Ar + Vapor. Nuvens escuras que se elevam das chamas da transformação.",
		"lore": "Onde há fumaça, há fogo - e onde há fogo, há possibilidade de renovação."
	},
	"swamp": {
		"name": "Pântano",
		"type": "Elemento Terciário",
		"description": "Fusão de Terra + Névoa. Terreno alagado onde mistérios antigos repousam.",
		"lore": "No pântano da adversidade, às vezes encontramos os tesouros mais preciosos."
	},
	
	# === CARTAS QUATERNÁRIAS ADICIONAIS ===
	"dark mirror": {
		"name": "Espelho Sombrio",
		"type": "Elemento Quaternário",
		"description": "Fusão de Vidro + Fumaça. Reflete não a beleza, mas as verdades ocultas.",
		"lore": "Mostra o que precisa ser enfrentado antes da redenção chegar."
	},
	"spirit golem": {
		"name": "Golem Espiritual",
		"type": "Elemento Quaternário",
		"description": "Fusão de Ar + Golem. Guardião etéreo animado por forças sobrenaturais.",
		"lore": "Protetor espiritual que vigia os corações puros em sua jornada."
	},
	"stained glass": {
		"name": "Vitral",
		"type": "Elemento Quaternário",
		"description": "Fusão de Ar + Areia. Vidro colorido que conta histórias através da luz.",
		"lore": "Cada cor conta um capítulo da história de amor eterna."
	},
	"solar flame": {
		"name": "Chama Solar",
		"type": "Elemento Quaternário",
		"description": "Fusão de Fogo + Radiância. Fogo divino que nunca se extingue.",
		"lore": "A chama eterna do amor que brilha mais forte que o próprio sol."
	},
	"storm stone": {
		"name": "Pedra da Tempestade",
		"type": "Elemento Quaternário",
		"description": "Fusão de Fogo + Raio. Pedra que contém o poder das tempestades.",
		"lore": "Forjada na fúria dos elementos, simboliza a superação das adversidades."
	},
	"tears": {
		"name": "Lágrimas",
		"type": "Elemento Quaternário",
		"description": "Fusão de Fogo + Geada. Gotas cristalinas nascidas da emoção pura.",
		"lore": "Cada lágrima derramada por amor verdadeiro tem poder de cura."
	},
	"basalt dust": {
		"name": "Pó de Basalto",
		"type": "Elemento Quaternário",
		"description": "Fusão de Ar + Basalto. Partículas vulcânicas que carregam memórias antigas.",
		"lore": "Do pó das montanhas sagradas, onde antigas magias ainda ecoam."
	},
	"thunder": {
		"name": "Trovão",
		"type": "Elemento Quaternário",
		"description": "Fusão de Névoa Carregada + Terra. Som divino que ecoa através dos reinos.",
		"lore": "O rugido dos céus anunciando que grandes mudanças estão por vir."
	},
	"velarim": {
		"name": "Velarim",
		"type": "Elemento Quaternário",
		"description": "Fusão de Névoa + Areia. Véu misterioso que separa mundos.",
		"lore": "O véu entre o mundo mágico e o mundo real, onde transformações acontecem."
	},
	"aureol": {
		"name": "Auréola",
		"type": "Elemento Quaternário",
		"description": "Fusão de Ar + Gêiser. Círculo de luz que abençoa os verdadeiros de coração.",
		"lore": "A coroa luminosa que espera por aqueles que completam jornadas impossíveis."
	},
	"silhain": {
		"name": "Silhain",
		"type": "Elemento Quaternário",
		"description": "Fusão de Areia + Vapor. Essência cristalina que purifica energias negativas.",
		"lore": "Cristal de purificação que dissolve as maldições mais persistentes."
	},
	"swamp fire": {
		"name": "Fogo do Pântano",
		"type": "Elemento Quaternário",
		"description": "Fusão de Fogo + Pântano. Chamas verdes que dançam sobre águas paradas.",
		"lore": "Fogo místico que queima apenas ilusões, deixando a verdade intacta."
	},
	"vulcan": {
		"name": "Vulcão",
		"type": "Elemento Quaternário",
		"description": "Fusão de Terra + Fumaça. Montanha ardente que forja novos começos.",
		"lore": "Do ventre da terra nasce o poder de remodelar qualquer destino."
	},
	"slime": {
		"name": "Limo",
		"type": "Elemento Quaternário",
		"description": "Fusão de Vidro + Água. Substância adaptável que toma qualquer forma.",
		"lore": "Maleável como o amor verdadeiro, que se adapta a qualquer circunstância."
	}
}

# Função para obter descrição completa da carta
static func get_card_info(element: String) -> Dictionary:
	if DESCRIPTIONS.has(element):
		return DESCRIPTIONS[element]
	else:
		return {
			"name": element.capitalize(),
			"type": "Elemento Desconhecido",
			"description": "Um elemento misterioso cujos segredos ainda não foram desvendados pela alquimia.",
			"lore": "Nem todos os elementos revelaram seus mistérios para os alquimistas."
		}

# Função para obter apenas a descrição
static func get_description(element: String) -> String:
	var info = get_card_info(element)
	return info["description"]

# Função para obter o nome formatado
static func get_card_name(element: String) -> String:
	var info = get_card_info(element)
	return info["name"]

# Função para obter o tipo
static func get_card_type(element: String) -> String:
	var info = get_card_info(element)
	return info["type"]

# Função para obter o lore
static func get_card_lore(element: String) -> String:
	var info = get_card_info(element)
	return info["lore"]
