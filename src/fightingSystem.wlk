import wollok.game.*
import starting.*
import players.*
import teams.*
import cursor.*
import champions.*

object warSystem {
	
var property image 
const property position = game.origin()

var property actualTurn = playerSelector.firstSelector()
var property selectedAttacker
var property selectedEnemy

	//selectedAttacker.atacar(selectedEnemy)
	
	method start() {
		game.clear()
		game.addVisual(self)
		lightness.configForBattle()
		darkness.configForBattle()
		cursor.position(actualTurn.team().champions().head().position())
		game.addVisual(cursor)
		keyboard.up().onPressDo({cursor.previousChar(self.possibleCurrentMove())})
		keyboard.down().onPressDo({cursor.nextChar(self.possibleCurrentMove())})
		keyboard.s().onPressDo({self.selectCharB()})
	}
	
	
	method possibleCurrentMove() {
		return if(cursor.attackStage()) {
			actualTurn.team().nextTeam().listAfterSelection()
		}
		else { actualTurn.team().champions() }
	}
	

	method selectCharB() {
		cursor.attackStage(true)
		selectedAttacker = game.uniqueCollider(cursor)
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
