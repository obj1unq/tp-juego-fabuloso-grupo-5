import fightingsystem.*

object teamLight {
	var property chars = []
	var property charsEnemy = []
	var property charSelected = null
	var property enemySelected = null
		
	method nextChar() { 
		chars.add(chars.head())
		chars = chars.drop(1)
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method previousChar() {
		chars = chars.last() + chars
		chars.remove(chars.last())
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method nextEnemy() {
		charsEnemy.add(charsEnemy.head())
		charsEnemy = charsEnemy.drop(1)
		enemySelected = charsEnemy.head()
		enemyCursor.position(enemySelected.position())
	}
	
	method previousEnemy() {
		charsEnemy = charsEnemy.last() + charsEnemy
		charsEnemy.remove(charsEnemy.last())
		enemySelected = charsEnemy.head()
		enemyCursor.position(enemySelected.position())
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
	var property chars = []
	var property charsEnemy = []
	var property charSelected = null
	var property enemySelected = null
		
	method nextChar() {
		chars.add(chars.head())
		chars = chars.drop(1)
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method previousChar() {
		chars = chars.last() + chars
		chars.remove(chars.last())
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method nextEnemy() {
		charsEnemy.add(charsEnemy.head())
		charsEnemy = charsEnemy.drop(1)
		enemySelected = charsEnemy.head()
		enemyCursor.position(enemySelected.position())
	}
	
	method previousEnemy() {
		charsEnemy = charsEnemy.last() + charsEnemy
		charsEnemy.remove(charsEnemy.last())
		enemySelected = charsEnemy.head()
		enemyCursor.position(enemySelected.position())
	}
	
	method nextTeam() {
		return teamLight
	}
	
	method kill(objective) {
		chars.remove(objective)
		charsEnemy.remove(objective)
	}
}
