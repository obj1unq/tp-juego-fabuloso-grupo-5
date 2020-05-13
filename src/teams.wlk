import gameConfig.fightingsystem.*
import enemies.*
import heroes.*
import gameConfig.cursor.*
import enemies.*

object teamLight {
	var property chars = [wizard, knight]
	var property charsEnemy = [ogre, darkElf]
	var property charSelected = null
	var property enemySelected = null
		
	method nextAlly() { 
		chars.add(chars.head())
		chars = chars.drop(1)
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method nextEnemy() {
		charsEnemy.add(charsEnemy.head())
		charsEnemy = charsEnemy.drop(1)
		enemySelected = charsEnemy.head()
		cursor.position(enemySelected.position())
	}
	
	method nextChar() {
		if (cursor.stage() == "attacker") {
			self.nextAlly()
		} else {
			self.nextEnemy()
		}
	}
	
	method nextTeam() {
		return teamDarkness
	}
	
	method kill(objective) {
		chars.remove(objective)
		charsEnemy.remove(objective)
	}
}

object teamDarkness {
	var property chars = [ogre, darkElf]
	var property charsEnemy = [wizard, knight]
	var property charSelected = null
	var property enemySelected = null
		
	method nextAlly() {
		chars.add(chars.head())
		chars = chars.drop(1)
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method nextEnemy() {
		charsEnemy.add(charsEnemy.head())
		charsEnemy = charsEnemy.drop(1)
		enemySelected = charsEnemy.head()
		cursor.position(enemySelected.position())
	}
	
	method nextChar() {
		if (cursor.stage() == "attacker") {
			self.nextAlly()
		} else {
			self.nextEnemy()
		}
	}
	
	method nextTeam() {
		return teamLight
	}
	
	method kill(objective) {
		chars.remove(objective)
		charsEnemy.remove(objective)
	}
}
