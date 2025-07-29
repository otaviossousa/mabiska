extends Node

# Sistema de mensagens para fusões de cartas
const FUSION_MESSAGES = {
	# Fusões para conseguir Lightning (primeiro passo)
	["air", "fire"]: "As chamas dançam com o vento... Uma centelha de esperança surge!",
	["fire", "air"]: "O fogo encontra o ar... A primeira luz da salvação brilha!",
	
	# Fusões para conseguir Magnetite (segundo passo)  
	["earth", "lightning"]: "A terra abraça a luz divina... A magnetita surge com poder magnético!",
	["lightning", "earth"]: "O raio toca o solo sagrado... Magnetita, a pedra que atrai o destino!",
	
	# Fusão final para Pedra Filosofal
	["magnetite", "water"]: "*** MILAGRE! *** A magnetita se purifica nas águas sagradas... A PEDRA FILOSOFAL nasce!",
	["water", "magnetite"]: "*** MILAGRE! *** As águas da vida tocam a magnetita... A lendária PEDRA FILOSOFAL surge!",
	
	# Fusões básicas especiais
	["fire", "water"]: "Elementos opostos se encontram... Vapor surge da união harmoniosa!",
	["earth", "air"]: "Solo e vento se misturam... Areia dourada como o tempo flui!",
	["earth", "water"]: "Terra e água se unem... Argila moldável para novos caminhos!",
	["earth", "fire"]: "Fogo derrete a terra... Magma incandescente surge das profundezas!",
	["air", "water"]: "Brisa aquática se forma... Névoa mística envolve a esperança!",
	
	# Mensagens especiais para cartas importantes
	["glass", "lightning"]: "Vidro e luz se combinam... Radiância pura ilumina o caminho!",
	["clay", "fire"]: "Argila no fogo se transforma... Cerâmica resistente nasce da fornalha!",
	["steam", "air"]: "Vapor encontra o vento... Fumaça sobe aos céus carregando preces!",
	["obsidian", "water"]: "Vidro vulcânico toca a água... Fragmentos de memórias se cristalizam!",
	
	# Mensagem padrão para fusões não especificadas
	"default": "Os elementos se fundem em harmonia mágica..."
}

# Mensagens baseadas no progresso da história
const PROGRESS_MESSAGES = {
	0: "Que a magia dos elementos guie nossa jornada rumo à Pedra Filosofal!",
	1: "Excelente! A primeira luz surgiu. Agora precisamos trazê-la à Terra...",
	2: "Magnetita criada! Estamos muito próximos... Só falta purificá-la com água!",
	3: "VITÓRIA! A Pedra Filosofal foi forjada! O príncipe pode voltar à forma humana!",
	7: "Essa combinação não nos aproxima da Pedra Filosofal... Mas toda experiência ensina algo!"
}

static func get_fusion_message(element1: String, element2: String) -> String:
	var pair = [element1, element2]
	pair.sort()
	
	if FUSION_MESSAGES.has(pair):
		return FUSION_MESSAGES[pair]
	else:
		return FUSION_MESSAGES["default"]

static func get_progress_message(step: int) -> String:
	if PROGRESS_MESSAGES.has(step):
		return PROGRESS_MESSAGES[step]
	else:
		return "A jornada continua..."

# Função para criar mensagem completa de fusão
static func create_fusion_announcement(element1: String, element2: String, result: String, step: int) -> String:
	var fusion_msg = get_fusion_message(element1, element2)
	var progress_msg = get_progress_message(step)
	
	var announcement = ""
	announcement += fusion_msg + "\n\n"
	announcement += "*** Resultado: " + result + " ***\n\n"
	announcement += progress_msg
	
	return announcement
