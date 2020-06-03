import wollok.game.*
import starting.*
import cursor.*
import battle.*

object lightness {
	
const property position = game.at(2,6)
const property image = "light.png"	
const property champions = []
const property characters = []
var property positionOfCursor = 1
var property selectedChar = "nobody"


	method nextTeam() {
		return darkness
	}
	
	method leader() {
		return champsSelection.paladin()
	}
	
	method fullTeam() {
		return champions.size() == 3
	}
	
	method isFromTeam(char) {
		return champions.contains(char)
	}
	
	//MOVIMIENTO DEL CURSOR ENTRE CAMPEONES DEL EQUIPO ACTUAL
	method nextChamp() {
		if ( positionOfCursor < (champions.size() - 1) && champions.size() != 0 ) {
			positionOfCursor += 1
			selectedChar = champions.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == (champions.size() -1) && champions.size() != 0 ) { 
				positionOfCursor = 0
				selectedChar = champions.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else { 
			game.say(battle, "Pierde el equipo" + self.toString())
		}
	}
	
	method previousChamp() {
		if ( positionOfCursor > 0 && champions.size() != 0) {
			positionOfCursor -= 1
			selectedChar = champions.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == 0 && champions.size() != 0 ) {
				positionOfCursor = (champions.size() - 1)
				selectedChar = champions.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else {
			game.say(battle, "Pierde el equipo" + self.toString())
		}
	}
	
	
	//MOVIMIENTO DEL CURSOR ENTRE TODOS LOS CAMPEONES
	method nextChar() {
		if ( positionOfCursor < (champions.size() - 1) && champions.size() != 0 ) {
			positionOfCursor += 1
			selectedChar = champions.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == (champions.size() -1) && champions.size() != 0 ) { 
				positionOfCursor = 0
				selectedChar = champions.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else { 
			game.say(battle, "Pierde el equipo" + self.toString())
		}
	}
	
	method previousChar() {
		if ( positionOfCursor > 0 && characters.size() != 0) {
			positionOfCursor -= 1
			selectedChar = characters.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == 0 && characters.size() != 0 ) {
				positionOfCursor = (characters.size() - 1)
				selectedChar = characters.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else {
			game.say(battle, "Pierde el equipo" + self.toString())
		}
	}
	
	
	
	method kill(char) {
		if(champions.contains(char)) {
			champions.remove(char)
		}
		characters.remove(char)
	}
	
}


object darkness {
	
const property position = game.at(24,6)
const property image = "dark.png"
const property champions = []
const property characters = []
var property positionOfCursor = 1
var property selectedChar = "nobody"

	
	method nextTeam() {
		return lightness
	}
	
	method leader() {
		return champsSelection.dracula()
	}
	
	method fullTeam() {
		return champions.size() == 3
	}
	
	method isFromTeam(char) {
		return champions.contains(char)
	}
	
	//MOVIMIENTO DEL CURSOR ENTRE CAMPEONES DEL EQUIPO ACTUAL
	method nextChamp() {
		if ( positionOfCursor < (champions.size() - 1) && champions.size() != 0 ) {
			positionOfCursor += 1
			selectedChar = champions.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == (champions.size() -1) && champions.size() != 0 ) { 
				positionOfCursor = 0
				selectedChar = champions.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else { 
			game.say(battle, "Pierde el equipo" + self.toString())
		}
	}
	
	method previousChamp() {
		if ( positionOfCursor > 0 && champions.size() != 0) {
			positionOfCursor -= 1
			selectedChar = champions.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == 0 && champions.size() != 0 ) {
				positionOfCursor = (champions.size() - 1)
				selectedChar = champions.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else {
			game.say(battle, "Pierde el equipo" + self.toString())
		}
	}
	
	
	//MOVIMIENTO DEL CURSOR ENTRE TODOS LOS CAMPEONES
	method nextChar() {
		if ( positionOfCursor < (champions.size() - 1) && champions.size() != 0 ) {
			positionOfCursor += 1
			selectedChar = champions.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == (champions.size() -1) && champions.size() != 0 ) { 
				positionOfCursor = 0
				selectedChar = champions.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else { 
			game.say(battle, "Pierde el equipo" + self.toString())
		}
	}
	
	method previousChar() {
		if ( positionOfCursor > 0 && characters.size() != 0) {
			positionOfCursor -= 1
			selectedChar = characters.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == 0 && characters.size() != 0 ) {
				positionOfCursor = (characters.size() - 1)
				selectedChar = characters.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else {
			game.say(battle, "Pierde el equipo" + self.toString())
		}
	}
	
	method kill(char) {
		if(champions.contains(char)) {
			champions.remove(char)
		}
		characters.remove(char)
	}

}	