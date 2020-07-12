import wollok.game.*
import starting.*
import players.*
import configuracionCampeones.teams.*
import cursor.*
import configuracionCampeones.champions.*
import attackInterfaces.*
import gameOverScreen.*

object warSystem {
	
var property image 
const property position = game.origin()

var property actualTurn = playerSelector.firstSelector()
var property selectedAttacker
var property selectedEnemy

	method start() {
		game.clear()
		game.addVisual(self)
		lightness.configForBattle()
		darkness.configForBattle()
		cursor.position(actualTurn.team().champions().head().position())
		cursor.initialPosition(0)
		game.addVisual(cursor)
		game.addVisual(flag)
		game.addVisual(new Banner(player = player1))
		game.addVisual(new Banner(player = player2))
		
		keyboard.up().onPressDo({cursor.previousChar(self.possibleCurrentMove())})
		keyboard.down().onPressDo({cursor.nextChar(self.possibleCurrentMove())})
		keyboard.s().onPressDo({self.validateSelectCursor()}) //self.selectCharB()})
		
		keyboard.x().onPressDo({ self.executeAttack(physical) })
		keyboard.z().onPressDo({ self.executeAttack(magic) })
		keyboard.c().onPressDo({ self.validateSpellCast() })
		keyboard.r().onPressDo({ self.resetTurn() })
		keyboard.num1().onPressDo({ self.castSpell(0) })
		keyboard.num2().onPressDo({ self.castSpell(1) })
		keyboard.num3().onPressDo({ self.castSpell(2) })
	}
	
	method validateSelectCursor() {
		if (game.hasVisual(cursor)) {
			self.selectCharB()
		}
	}

	//selectedAttacker.atacar(selectedEnemy)
	
	method areSameTeams(c1, c2) {
		return (c1.team().isLight() == c2.team().isLight())
	}
	
	method executeAttack(type) {
		if (selectedAttacker != null && selectedEnemy != null) { 
			selectedAttacker.attack(type, selectedEnemy)
			self.finishTurn() }
	}
	
	method executeSpellCast() {
		if (selectedAttacker != null && selectedEnemy != null) {
			selectedAttacker.spellCast(selectedEnemy)
			self.finishTurn() }
	}
	
	method resetTurn() {
		selectedAttacker = null
        selectedEnemy = null
        self.addCursor()
        cursor.adjustAfterSelection(actualTurn.team().champions())
        cursor.attackStage(false)
        attackerSelector.removeVisual()
        attackedSelector.removeVisual()
        attackSystem.remove()
        spellsSystem.remove()
    }
    
    method addCursor() {
    	if (!game.hasVisual(cursor)) {
    		game.addVisual(cursor)
    	}
    }
	
	method kill(objective) {
		if (objective.hp() == 0) {
			 objective.die()
			 actualTurn.team().champions().remove(objective)
			 actualTurn.team().characters().remove(objective)
			 actualTurn.team().nextTeam().champions().remove(objective)
			 actualTurn.team().nextTeam().characters().remove(objective)
		}
		else { 
			objective.image(objective.name() + "1.png")
			game.onTick(150, objective.name(), {championsInBattle.battlePose(objective)})
		}
		game.removeTickEvent("finishTurn")
		self.checkTeams()
	}
	
	method finishTurn() {
		game.removeTickEvent(selectedEnemy.name())
		selectedEnemy.image(selectedEnemy.name() + selectedAttacker.team().name() + ".png")
		game.onTick(500, "finishTurn", {
			self.kill(selectedEnemy)
			actualTurn = actualTurn.nextPlayer()
			self.positionActualTurn()
			self.addCursor()
			cursor.initialPosition(0)
			attackerSelector.removeVisual()
			attackedSelector.removeVisual()
			spellsSystem.remove()
			attackSystem.remove()
			selectedAttacker = null
			selectedEnemy = null
		})
	}
	
	method positionActualTurn() {
		if(!actualTurn.team().champions().isEmpty()) {
			cursor.position(actualTurn.team().champions().head().position())
		}
	}
	
	method checkTeams() { 
		if(actualTurn.team().nextTeam().champions().isEmpty()) {
			gameOver.win(actualTurn)
		} 
	}

	method validateSpellCast() {
		if (selectedAttacker.knowsSorcery()) {
			spellsSystem.actualChamp(selectedAttacker)
			game.addVisual(spellsSystem)
		}
		else {
			game.say(selectedAttacker, "Lamentablemente no sé de hechicería...")
		}
	}
	
	method castSpell(num) {
		if(num < selectedAttacker.spells().size()) {
			selectedAttacker.getSpell(num)
			selectedAttacker.spellSelected().validate(selectedAttacker, selectedEnemy)
		}
		else { game.say(selectedAttacker, "¡Sólo sé un hechizo!") }
	}
	
	method possibleCurrentMove() {
		return if(cursor.attackStage()) {
			actualTurn.team().nextTeam().listAfterSelection()
		}
		else { actualTurn.team().champions() }
	}	
    
    method selectCharB() {
        if (cursor.attackStage() && selectedAttacker != cursor.collider()) {
            selectedEnemy = cursor.collider()
   			attackedSelector.champion(selectedEnemy)
            attackedSelector.addVisual()
            attackSystem.actualChamp(selectedAttacker)
            game.addVisual(attackSystem)
            cursor.nextStage()
            game.removeVisual(cursor)
            cursor.adjustAfterSelectionBattle(actualTurn.team())
        } else if (!cursor.attackStage() && selectedAttacker != cursor.collider()) {
   			selectedAttacker = cursor.collider()
            attackerSelector.champion(selectedAttacker)
            attackerSelector.addVisual()
            cursor.nextStage()
            cursor.adjustAfterSelectionBattle(actualTurn.team())
            
        }
    }
    
}

/* 
class Selector {
	var property champion
	
	method image() {
		return if (champion.team().isLight()) { "select" + self.side() + "L.png" }
		   else { "select" + self.side() + "D.png" }
	}
	
	method side()
	
	method position() {
		return if (champion.team().isLight()) { champion.position().left(1) }
		   else { champion.position().right(2) }
	}
	
	method addVisual() {
		if(!game.hasVisual(self)) { game.addVisual(self) }
	}
	
	method removeVisual() {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
}

object actualAllySelector inherits Selector {
	override method side() { return "Ally" }
}

object actualEnemySelector inherits Selector {
	override method side() { return "Enemy" }
}
*/

class SelectorDos {
	
var property champion

	method image() {
		return "select" + champion.team().name() + ".png"
	}
	
	method position() {
		return if (champion.team().isLight()) { champion.position().left(1) }
		   else { champion.position().right(2) }
	}
	
	method addVisual() {
		if(!game.hasVisual(self)) { game.addVisual(self) }
	}
	
	method removeVisual() {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
	
}

object attackerSelector inherits SelectorDos {
	
}

object attackedSelector inherits SelectorDos {
	
}