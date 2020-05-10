import wollok.game.*
import teams.*

object fightingSystem {
	var property charSelected = null
	var property teamTurn = teamLight
	
	method executeTurnMagic() {
		teamTurn.charSelected().magicalAttack
			(teamTurn.enemySelected(), charSelected.spell())
		teamTurn = teamTurn.nextTeam()
	}
	
	method executeTurnPhysical() {
		teamTurn.charSelected().physicalAttack
			(teamTurn.enemySelected(), charSelected.weapon())
		teamTurn = teamTurn.nextTeam()
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

