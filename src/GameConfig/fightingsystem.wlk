import wollok.game.*
import teams.*

object fightingSystem {
	var property charSelected = null
	var property teamTurn = teamLight
	
	method executeTurnMagic() {
		teamTurn.charSelected().magicalAttack
			(teamTurn.enemySelected(), charSelected.spell())
		self.kill(teamTurn.enemySelected())
		teamTurn = teamTurn.nextTeam()
	}
	
	method executeTurnPhysical() {
		teamTurn.charSelected().physicalAttack
			(teamTurn.enemySelected(), charSelected.weapon())
		self.kill(teamTurn.enemySelected())
		teamTurn = teamTurn.nextTeam()
	}
	
	method kill(objective) {
		if (objective.hp() == 0) {
			teamLight.kill(objective)
			teamDarkness.kill(objective)
		} 
	}
}

object cursor {
	var property position = null
	
	method image() { return "allyCursor.png"}
}

object enemyCursor {
	var property position = null
	
	method image() { return "enemyCursor.png"}
}

