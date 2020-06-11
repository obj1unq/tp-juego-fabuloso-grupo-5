import wollok.game.*
import starting.*
import players.*
import teams.*
import cursor.*
import champions.*

object warSystem {
	
var property image = "arena.png"
const property position = game.origin()

var property actualTurn = playerSelector.firstSelector()
	
	method start() {
		game.clear()
		game.addVisual(self)
		lightness.configForBattle()
		darkness.configForBattle()
		cursor.position(playerSelector.firstSelector().team().champions().head().position())
		game.addVisual(cursor)
		keyboard.up().onPressDo({cursor.previousChar(self.possibleCurrentMove())})
		keyboard.down().onPressDo({cursor.nextChar(self.possibleCurrentMove())})
		keyboard.s().onPressDo({self.selectCharB()})
	}
	
	
	method possibleCurrentMove() {
		return if(cursor.attackStage()) {
			actualTurn.team().characters()
		}
		else { actualTurn.team().champions() }
	}
	
	// Imagen 3 sería la "posición de ataque"
	// pero al seleccionar este pj de nuevo, rompe ya que no detecta el evento removido.
	method selectCharB() {
		cursor.attackStage(true)
		game.removeTickEvent(cursor.collider().name())
		cursor.collider().image(cursor.collider().name() +"3.png")
		cursor.adjustAfterSelectionBattle(actualTurn.team())
			
	}
	
}
