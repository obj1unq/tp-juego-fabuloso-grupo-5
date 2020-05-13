import wollok.game.*
import teams.*
import enemies.*
import heroes.*
import equipement.*

object fightingSystem {
	var property charSelected = null
	var property teamTurn = teamLight
	
	method executeTurnMagic() {
		teamTurn.charSelected().magicalAttack(teamTurn.enemySelected(), darkBlast)
		self.kill(teamTurn.enemySelected())
		teamTurn = teamTurn.nextTeam()
		self.changeCursors()
	}
	
	method executeTurnPhysical() {
		teamTurn.charSelected().physicalAttack(teamTurn.enemySelected(), sword)
		self.kill(teamTurn.enemySelected())
		teamTurn = teamTurn.nextTeam()
		self.changeCursors()
	}
	
	method kill(objective) {
		if (objective.hp() == 0) {
			teamLight.kill(objective)
			teamDarkness.kill(objective)
		}
	}
	
	method changeCursors() {
		teamTurn.nextChar()
		teamTurn.nextEnemy()
	}
}

object cursor {
	var property position = wizard.position()
	
	method image() { return "allyCursor.png"}
}

object enemyCursor {
	var property position = ogre.position()
	
	method image() { return "enemyCursor.png" }
}