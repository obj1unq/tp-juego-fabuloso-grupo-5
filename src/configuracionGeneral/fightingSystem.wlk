import wollok.game.*
import starting.*
import players.*
import configuracionCampeones.teams.*
import cursor.*
import configuracionCampeones.champions.*
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
		keyboard.num1().onPressDo({ self.validateSorcery(0) })
		keyboard.num2().onPressDo({ self.validateSorcery(1) })
		keyboard.num3().onPressDo({ self.validateSorcery(2) })
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
		if (selectedEnemy != null) { 
			selectedAttacker.attack(type, selectedEnemy)
			self.finishTurn() }
	}
	
	method executeSpellCast() {
		if (selectedEnemy != null) {
		selectedAttacker.spellCast(selectedEnemy)
		self.finishTurn() }
	}
	
	method resetTurn() {
		selectedAttacker = null
        selectedEnemy = null
        self.addCursor()
        cursor.adjustAfterSelection(actualTurn.team().champions())
        cursor.attackStage(false)
        actualAllySelector.removeVisual()
        actualEnemySelector.removeVisual()
    }
    
    method addCursor() {
    	if (!game.hasVisual(cursor)) {
    		game.addVisual(cursor)
    	}
    }
	
	method kill(objective) {
		if (objective.hp() == 0) {
			game.removeTickEvent(objective.name())
			objective.die()
			actualTurn.team().champions().remove(objective)
			actualTurn.team().characters().remove(objective)
			actualTurn.team().nextTeam().champions().remove(objective)
			actualTurn.team().nextTeam().characters().remove(objective)
		}
		self.checkTeams()
	}
	
	method finishTurn() {
		self.kill(selectedEnemy)
		selectedAttacker = null
		selectedEnemy = null
		actualTurn = actualTurn.nextPlayer()
		self.positionActualTurn()
		game.addVisual(cursor)
		cursor.initialPosition(0)
		game.removeVisual(actualAllySelector)
		game.removeVisual(actualEnemySelector)
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
			selectedAttacker.spellSelected().validate(selectedAttacker, selectedEnemy)
		}
	}
	
	method validateSorcery(num) {
		if (selectedAttacker.knowsSorcery()) {
			selectedAttacker.getSpell(num)
		}
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
   			actualEnemySelector.champion(selectedEnemy)
            actualEnemySelector.addVisual()
            cursor.nextStage()
            game.removeVisual(cursor)
            cursor.adjustAfterSelectionBattle(actualTurn.team())
        } else if (!cursor.attackStage() && selectedAttacker != cursor.collider()) {
   			selectedAttacker = cursor.collider()
            
            actualAllySelector.champion(selectedAttacker)
            actualAllySelector.addVisual()
            cursor.nextStage()
            cursor.adjustAfterSelectionBattle(actualTurn.team())
        }
    }
    
}

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
