import wollok.game.*
import starting.*

object lightness {
	
const property position = game.at(2,6)
const property image = "light.png"	
const property champions = []


	method nextTeam() {
		return darkness
	}
	
	method leader() {
		return champsSelection.paladin()
	}
	
	method fullTeam() {
		return champions.size() == 3
	}
	
}

object darkness {
	
const property position = game.at(24,6)
const property image = "dark.png"
const property champions = []

	
	method nextTeam() {
		return lightness
	}
	
	method leader() {
		return champsSelection.dracula()
	}
	
	method fullTeam() {
		return champions.size() == 3
	}

}	