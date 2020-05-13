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
		charSelected.magicalAttack(enemySelected)
		self.kill(enemySelected)
		teamTurn.nextTeam()
		self.nextRound()
	}
	
	method executeTurnPhysical() {
		charSelected.physicalAttack(enemySelected)
		self.kill(enemySelected)
		teamTurn.nextTeam()
		self.nextRound()
	}
	
	method nextRound() {
		if(teamTurn.ownChars().size() == 0) {
			self.gameOver()
		} cursor.changeTeam(teamTurn)
	}
	
	method gameOver() {
		game.say(knight,"gameOver")
	}
	
	method kill(objective) {
		if (objective.hp() == 0) {
			teamLight.kill(objective)
			teamDarkness.kill(objective)
		}
	}
	
	method selectAttacker() {
		charSelected = teamTurn.charSelected()
		teamTurn.nextChar()
	}
	
	method selectEnemy() {
		enemySelected = teamTurn.charSelected()
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