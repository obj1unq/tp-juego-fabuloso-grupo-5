import wollok.game.*
import teams.*

object fightingSystem {
	var property charSelected = null
	var property teamTurn = teamLight
	
	method executeTurn() {
		teamTurn.charSelected().attack(teamTurn.enemySelected())
	}
	
}

object cursor {
	var property position = null
	
	method image() { return "cursor.png"}
}

object cursorEnemy {
	var property position = null
	
	method image() { return "cursorEnemy.png"}
}

