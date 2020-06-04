import wollok.game.*
import teams2.*
import starting.*
import champions.*
import battle.*
import cursor.*
import attackInterfaces.*
import attack.*


object warSystem {
	
var property selectedAttacker = null
var property selectedEnemy = null
var property teamTurn = teamSelector.winnerPlayer().team()
	
	
	method resetAttack() {
		selectedAttacker = teamTurn.champions().head()
		selectedEnemy = teamTurn.champions().head()
		if (game.hasVisual(attackSystem)) { 
		    game.removeVisual(attackSystem) }
			cursor.stage("attacker")
	}
	
	method executeTurnMagic() {
		game.removeVisual(attackSystem)
		selectedAttacker.magicAttackTo(selectedEnemy)
		self.kill(selectedEnemy)
		teamTurn.nextTeam()
		self.nextRound()
		cursor.nextStage()
	}
	
	method executeTurnPhysical() {
		game.removeVisual(attackSystem)
		selectedAttacker.physicalAttackTo(selectedEnemy)
		self.kill(selectedEnemy)
		teamTurn.nextTeam()
		self.nextRound()
		cursor.nextStage()
	}
	 
	method executeSpellCast() {
		game.removeVisual(attackSystem)
		if (selectedAttacker.knowsSorcery()) {
			selectedAttacker.castSpell(selectedEnemy)
			self.kill(selectedEnemy)
			teamTurn.nextTeam()
			self.nextRound()
			cursor.nextStage()
		}
		else { game.say(selectedAttacker, "No sé lanzar conjuros, pero me gustaría aprender, ¿sabes?")
			   self.resetAttack()
		}
	}

	method nextRound() {
		if(teamTurn.champions().size() == 0 || teamTurn.nextTeam().champions().size() == 0) {
			game.say(battle, "GAME OVER")
		} cursor.changeTeam(teamTurn.nextTeam())
	}
	
	method kill(objective) {
		if (objective.hp() == 0) {
			teamTurn.nextTeam().kill(objective)
			teamTurn.kill(objective)
		}
	}
	
	method selectAttacker() {
		selectedAttacker = teamTurn.selectedChar()
	}
	
	method selectEnemy() {
		selectedEnemy = teamTurn.selectedChar()
	}
	
	method selectChar() {
		if (cursor.stage() == "attacker") {
			self.selectAttacker()
			cursor.nextStage()
			keyboard.down().onPressDo({ self.teamTurn().nextChar() })
			keyboard.up().onPressDo({ self.teamTurn().previousChar() })
		} else { 
			keyboard.down().onPressDo({ self.teamTurn().nextChar() })
			keyboard.up().onPressDo({ self.teamTurn().previousChar() })
			self.selectEnemy()
			game.addVisual(attackSystem)			
		}
	} 
	
}



