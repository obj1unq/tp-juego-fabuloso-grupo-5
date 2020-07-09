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
		game.addVisual(cursor)
		game.addVisual(flag)
		game.addVisual(new Banner(player = player1))
		game.addVisual(new Banner(player = player2))
		
		keyboard.up().onPressDo({cursor.previousChar(self.possibleCurrentMove())})
		keyboard.down().onPressDo({cursor.nextChar(self.possibleCurrentMove())})
		keyboard.s().onPressDo({self.selectCharB()})
		
		keyboard.x().onPressDo({ self.executeAttack(physical) })
		keyboard.z().onPressDo({ self.executeAttack(magic) })
		keyboard.c().onPressDo({ self.validateSpellCast() })
		keyboard.r().onPressDo({ self.resetTurn() })
		keyboard.num1().onPressDo({ self.validateSorcery(0) })
		keyboard.num2().onPressDo({ self.validateSorcery(1) })
		keyboard.num3().onPressDo({ self.validateSorcery(2) })
	}

	//selectedAttacker.atacar(selectedEnemy)
	
	method areSameTeams(c1, c2) {
		return (c1.team().isLight() == c2.team().isLight())
	}
	
	method executeAttack(type) {
		selectedAttacker.attack(type, selectedEnemy)
		self.finishTurn()
	}
	
	method executeSpellCast() {
		selectedAttacker.spellCast(selectedEnemy)
		self.finishTurn()
	}
	
	method resetTurn() {
		selectedAttacker = null
        selectedEnemy = null
        cursor.attackStage(false)
    }
	
	method kill(objective) {
		if (objective.hp() == 0) {
			game.removeTickEvent(objective.name())
			objective.image(objective.name().toString() + "4.png")
			objective.alive(false)
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
        if (cursor.attackStage()) {
            selectedEnemy = cursor.collider()
   			cursor.nextStage()
        } else {
   			selectedAttacker = cursor.collider()
            cursor.nextStage()
        }
        actualSelector.champion(selectedAttacker)
		actualSelector.addVisual()
		cursor.adjustAfterSelectionBattle(actualTurn.team())
    }	
}

object actualSelector {
	
var property champion

method image() {
	return if (champion.team().isLight()) { "selectL.png" }
		   else { "selectD.png" }
}

method position() {
	return if (champion.team().isLight()) { champion.position().left(1) }
		   else { champion.position().right(2) }
}

method addVisual() {
	if(!game.hasVisual(self)) { game.addVisual(self) }
}
	
}
