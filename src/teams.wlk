import wollok.game.*
import heroes.*
import enemies.*
import cursor.*
import gameOver.*
import fightingSystem.*

object lightDefenders {
	
const property characters = [knight, ogre, darkWizard, wizard]
const property champions = [knight, wizard]
var property positionOfCursor = 1
var property selectedChar = knight

	method nextTeam() {
		return darkDefenders
	}
	
	method isFromTeam(char) {
		return ( champions.contains(char) )
	}
	
	method nextChar() {
		if ( positionOfCursor < (characters.size() - 1) && characters.size() != 0 ) {
			positionOfCursor += 1
			selectedChar = characters.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == (characters.size() -1) && characters.size() != 0 ) { 
				positionOfCursor = 0
				selectedChar = characters.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else { 
			gameOver.end()
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
			gameOver.end()
		}
	}
	
	method kill(char) {
		if(champions.contains(char)) {
			champions.remove(char)
		}
		characters.remove(char)
	}
	
	
}


object darkDefenders {
	
const property characters = [knight, ogre, darkWizard, wizard ]
const property champions = [ogre, darkWizard]
var property positionOfCursor = 2
var property selectedChar = ogre

	method nextTeam() {
		return lightDefenders
	}
	
	method isFromTeam(char) {
		return ( champions.contains(char) )
	}
	
	method nextChar() {
		if ( positionOfCursor < (characters.size() - 1) && characters.size() != 0 ) {
			positionOfCursor += 1
			selectedChar = characters.get(positionOfCursor)
			cursor.position(selectedChar.position())
		}
		else if ( positionOfCursor == (characters.size() - 1) && characters.size() != 0 ) { 
				positionOfCursor = 0
				selectedChar = characters.get(positionOfCursor)
			    cursor.position(selectedChar.position())
		}
		else { 
			game.say(selectedChar, "Maldición, fue un empate...")
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
			game.say(selectedChar, "Maldición, fue un empate...")
		}
	}
	
	method kill(char) {
		if(champions.contains(char)) {
			champions.remove(char)
		}
		characters.remove(char)
	}
	
}