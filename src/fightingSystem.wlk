import wollok.game.*
import teams.*
import enemies.*
import heroes.*
import equipment.*
import cursor.*
import attack.*
import spellCast.*
import attackInterfaces.*
import gameOver.*

object warSystem {
	
	//PARA PROGRAMAR DE 1 SOLO JUGADOR
	//var property objectivesNow = [knight, wizard, ogre, darkWizard]
	//var property objectivesToLater = [knight, wizard, ogre, darkWizard]
	//const property totalAttacks = [{self.executeTurnMagic()}, {self.executeTurnPhysical()}, {self.executeSpellCast()} ]
	
var property selectedAttacker = knight
var property selectedEnemy = ogre
var property teamTurn = lightDefenders
	
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
	//	self.enemyTurn()
	}
	
	method executeTurnPhysical() {
		game.removeVisual(attackSystem)
		selectedAttacker.physicalAttackTo(selectedEnemy)
		self.kill(selectedEnemy)
		teamTurn.nextTeam()
		self.nextRound()
		cursor.nextStage()
	//	self.enemyTurn()
	}
	 
	method executeSpellCast() {
		game.removeVisual(attackSystem)
		if (selectedAttacker.knowsSorcery()) {
			selectedAttacker.castSpell(selectedEnemy)
			self.kill(selectedEnemy)
			teamTurn.nextTeam()
			self.nextRound()
			cursor.nextStage()
	//		self.enemyTurn()
		}
		else { game.say(selectedAttacker, "No sé lanzar conjuros, pero me gustaría aprender, ¿sabes?")
			   self.resetAttack()
		}
	}

	method nextRound() {
		if(teamTurn.champions().size() == 0 || teamTurn.nextTeam().champions().size() == 0) {
			gameOver.end()
		} cursor.changeTeam(teamTurn)
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
		} else { 
			self.selectEnemy()
			game.addVisual(attackSystem)
	//		cursor.nextStage()			
		}
	} 
	
	//method enemyTurn() {
		//if ( selectedChar.team() != teamTurn ) {
			//game.say(teamTurn.champions().anyOne(), "Ahora es nuestro turno")
			//game.onTick(5000, "ataque del enemigo", {self.attackOfEnemy()})
	//	}
//	}
	
	//PARA PROGRAMAR DE 1 SOLO JUGADOR
	//La idea era que el enemigo ejecute un ataque random al terminar el turno de un jugador.
	//method attackOfEnemy() {
		//selectedChar = teamTurn.champions().anyOne()
		//objectivesNow = objectivesNow.copyWithout(selectedChar)
		//selectedEnemy = objectivesNow.anyOne()
		//totalAttacks.anyOne()
		//objectivesNow = objectivesToLater
		//game.removeTickEvent("ataque del enemigo")
	//}
	
}
