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
		cursor.initializeForBattle()
		game.addVisual(flag)
		player1.showBanner()
		player2.showBanner()
		//game.addVisual(new Banner(player = player1))
		//game.addVisual(new Banner(player = player2))
		
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
		
		keyboard.h().onPressDo({self.showHP()})
		keyboard.p().onPressDo({self.showPhysicalDmg()})
		keyboard.m().onPressDo({self.showMagicDmg()})
		keyboard.w().onPressDo({self.showWisdom()})
	}
	
	method showHP() {
		if(cursor.isInGame()) {
			cursor.collider().sayHP()
		}
	}
	method showPhysicalDmg() {
		if(cursor.isInGame()) {
			cursor.collider().sayPhysicalDmg()
		}
	}
	method showMagicDmg() {
		if(cursor.isInGame()) {
			cursor.collider().sayMagicDmg()
		}
	}
	method showWisdom() {
		if(cursor.isInGame()) {
			cursor.collider().sayWisdom()
		}
	}
	method validateSelectCursor() {
		if (cursor.isInGame()) {
			self.selectCharB()
		}
	}

	//selectedAttacker.atacar(selectedEnemy)
	
	method executeAttack(type) {
		if (self.areInitialized()) { 
			selectedAttacker.attack(type, selectedEnemy)
			selectedAttacker.deleteBuffs()
			self.finishTurn()		
		}
	}
	
	method executeSpellCast() {
		if (self.areInitialized()) {
			selectedAttacker.spellCast(selectedEnemy)
			self.finishTurn() }
	}
	
	method areInitialized() {
		return selectedAttacker != null && selectedEnemy != null
	}
	
	method resetTurn() {
		selectedAttacker = null
        selectedEnemy = null
        cursor.initializeForBattle()
        //cursor.addVisual()
        //cursor.adjustAfterSelection(actualTurn.team().champions())
        //cursor.attackStage(false)
        attackerSelector.removeVisual()
        attackedSelector.removeVisual()
        attackSystem.remove()
        spellsSystem.remove()
    }
	
	method kill(objective) {
		if (!objective.isAlive()) {
			 objective.die()
			 actualTurn.team().kill(objective)
		}
		else { 
			objective.setAfterAttack()
		}
		game.removeTickEvent("finishTurn")
		self.checkWinner()
	}
	
	method finishTurn() {
		const enemy = selectedEnemy
		
		game.removeTickEvent(selectedEnemy.name())
		selectedEnemy.image(selectedEnemy.name() + selectedAttacker.team().name() + ".png")
		selectedAttacker = null
		selectedEnemy = null
		
		game.onTick(150, "finishTurn", {
			self.kill(enemy)
			actualTurn = actualTurn.nextPlayer()
			//gameOver.end()
			cursor.initializeForBattle()
			attackerSelector.removeVisual()
			attackedSelector.removeVisual()
			spellsSystem.remove()
			attackSystem.remove()
		})
	}
	
	method thereIsAWinner() {
		return actualTurn.team().isDefeated() || actualTurn.team().nextTeam().isDefeated()
	}
	
	method checkWinner() { 
		if(actualTurn.team().nextTeam().isDefeated()) {
			gameOver.win(actualTurn)
		} 
	}

	method validateSpellCast() {
		if (self.areInitialized() && selectedAttacker.knowsSorcery() && !game.hasVisual(spellsSystem)) {
			spellsSystem.show(selectedAttacker)
		}
		else if(self.areInitialized() && !game.hasVisual(spellsSystem)){
			game.say(selectedAttacker, "Lamentablemente no sé de hechicería...")
		}
	}
	
	method castSpell(num) {
		if(self.areInitialized() && selectedAttacker.knowsSorcery() && selectedAttacker.hasMoreSpells(num)) {
			selectedAttacker.getSpell(num)
			selectedAttacker.validateSpell(selectedEnemy)
		}
		else if(self.areInitialized() && selectedAttacker.knowsSorcery() && !selectedAttacker.hasMoreSpells(num)) {
			game.say(selectedAttacker, "¡Sólo sé un hechizo!")
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
        	self.selectEnemy()
            attackedSelector.show(selectedEnemy)
            attackSystem.show(selectedAttacker)
            cursor.removeVisual()
            cursor.setAfterSelection()
        } else if (!cursor.attackStage() && selectedAttacker != cursor.collider()) {
   			self.selectAttacker()
   			attackerSelector.show(selectedAttacker)
            cursor.setAfterSelection()
        }
    }
    
    method selectEnemy() {
    	selectedEnemy = cursor.collider()
    }
    
    method selectAttacker() {
    	selectedAttacker = cursor.collider()
    }
    
}

class Selector {
	
var property champion

	method image() {
		return "select" + champion.team().name() + ".png"
	}
	
	method position() {
		return if (champion.team().isLight()) { champion.position().left(1) }
		   else { champion.position().right(2) }
	}
	
	method show(champ) {
		if(!game.hasVisual(self)) {
			champion = champ	
			game.addVisual(self)
		}

	}
	
	method removeVisual() {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
	
}

object attackerSelector inherits Selector {
	
}

object attackedSelector inherits Selector {
	
}