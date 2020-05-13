import wollok.game.*
import teams.*
import enemies.*
import heroes.*
import equipement.*
import cursor.*

object fightingSystem {
	var property charSelected = null
	var property enemySelected = null
	var property teamTurn = teamLight
	
	method executeTurnMagic() {
		charSelected.magicalAttack(enemySelected, darkBlast)
		self.kill(enemySelected)
		teamTurn = teamTurn.nextTeam()
	}
	
	method executeTurnPhysical() {
		charSelected.physicalAttack(enemySelected, sword)
		self.kill(enemySelected)
		teamTurn = teamTurn.nextTeam()
	}
	
	method kill(objective) {
		if (objective.hp() == 0) {
			teamLight.kill(objective)
			teamDarkness.kill(objective)
		}
	}
	
	method selectAttacker() {
		charSelected = teamTurn.charSelected()
		cursor.changeTeam()
	}
	
	method selectEnemy() {
		enemySelected = teamTurn.enemySelected()
	}
	
	method selectChar() {
		if (cursor.stage() == "attacker") {
			self.selectAttacker()
			cursor.nextStage()
		} else { 
			self.selectEnemy()
			cursor.nextStage()			
		}
	}
}