import gameConfig.fightingsystem.*
import enemies.*
import heroes.*
import gameConfig.cursor.*
import enemies.*

object teamLight {
	var property chars = [wizard, knight, ogre, darkElf]
	var property ownChars = [wizard, knight]
	var property charSelected = null
	var property enemySelected = null
		
	method nextChar() { 
		chars.add(chars.head())
		chars = chars.drop(1)
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method nextTeam() {
		return teamDarkness
	}
	
	method kill(objective) {
		chars.remove(objective)
	}
}

object teamDarkness {
	var property chars = [wizard, knight, ogre, darkElf]
	var property ownChars = [ogre, darkElf]
	var property charSelected = null
	var property enemySelected = null
	
	method nextChar() { 
		chars.add(chars.head())
		chars = chars.drop(1)
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method nextTeam() {
		return teamLight
	}
	
	method kill(objective) {
		chars.remove(objective)
	}
}
