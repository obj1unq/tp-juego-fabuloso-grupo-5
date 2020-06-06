import wollok.game.*
import dice.*
import players.*
import teams.*
import champions.*
import fightingSystem.*
import cursor.*


//PRINCIPAL MENU
object startScreen {
	
var property image = "1.png"
var property position = game.origin()
	
	method start() {
		game.clear()
		game.addVisual(self)
		keyboard.enter().onPressDo({rules.show()})
		keyboard.backspace().onPressDo({game.stop()})
	}
	
}


//SECONDARY MENU
object rules {
	
var property image = "2.png"
var property position = game.origin()
	
	method show() {
		game.clear()
		game.addVisual(self)
		keyboard.enter().onPressDo({teamSelector.rollDiceScreen()})
		keyboard.backspace().onPressDo({startScreen.start()})
	}
	
}


//THIRD MENU
object teamSelector {
	
var property image = "3.png"
var property position = game.origin()
	
const dice1 = new Dice(position=game.at(4,5))
const dice2 = new Dice(position=game.at(24,5))	
	
	method rollDiceScreen() {
		game.clear()
		game.addVisual(self)
		game.say(self, "Tira el dado el jugador 1")
		keyboard.s().onPressDo({self.rollDice()})
		keyboard.backspace().onPressDo({rules.show()})
	}
	
	method rollDice() {
		if (playerSelector.turn() == 1) {
			dice1.roll()
			game.addVisual(dice1)
			playerSelector.turn(2)
			game.say(self, "Tira el dado el jugador 2")
		}
		else { 
			dice2.roll()
			game.addVisual(dice2)
			self.winSet()
		}
	}
	
	method winSet() {
		       if(dice1.number() > dice2.number()) { playerSelector.turn(1) 
		       										 game.say(self, "El jugador 1 elige")
		       										 game.onTick(1500, "team Selection", { teamSelection.show() })
		       }
		  else if(dice2.number() > dice1.number()) { playerSelector.turn(2)
		  											 playerSelector.firstSelector(player2)
		  											 playerSelector.secondSelector(player1)
		  											 game.say(self, "El jugador 2 elige")
		  											 game.onTick(1500, "team Selection", { teamSelection.show() })
		  }
		  else { game.say(self, "Un justo empate, otro intento...")
		  		 game.onTick(1500, "empate", {playerSelector.turn(1) 
		  		 							  self.rollDiceScreen()})
		  }
	}
	
	
}


//FOURTH MENU
object teamSelection {	

const property position = game.origin()

	method image() {
		return "selectTeam" + playerSelector.turn().toString() + ".png"
	}	
	
	method show() {
		game.clear()
		game.addVisual(self)
		game.addVisual(lightness)
		game.addVisual(darkness)
		cursor.position(lightness.position())
		game.addVisual(cursor)
		keyboard.right().onPressDo({cursor.position(cursor.collider().nextTeam().position())})
		keyboard.left().onPressDo({cursor.position(cursor.collider().nextTeam().position())})
		keyboard.s().onPressDo({ playerSelector.firstSelector().team(cursor.collider())
								 playerSelector.secondSelector().team(cursor.collider().nextTeam())
								 champsSelection.show() })
	}
	
}


//FIFTH MENU
object champsSelection {
	
const property position = game.origin()
const property image = "selectPJ.png"
var property actualTurn = playerSelector.firstSelector()

	
	
	method initialCharS() {
		return actualTurn.team().leader()
	}
	
	method actualTeamOfTurn() {
		return if (actualTurn.team().isLight()) { allChampions.lightTeam() }
			   else { allChampions.darkTeam() }
	}


	method show() {
		game.clear()
		game.addVisual(self)
		self.addCharactersVisual()
		game.say(self, "Elige 3 campeones el jugador " + playerSelector.turn().toString())
		cursor.position(self.initialCharS().position())
		game.addVisual(cursor)
		game.addVisual(selectorChampIndicator)
		keyboard.right().onPressDo({cursor.nextChar(self.actualTeamOfTurn())})
		keyboard.left().onPressDo({cursor.previousChar(self.actualTeamOfTurn())})
		keyboard.s().onPressDo({self.selectChar()})
		keyboard.i().onPressDo({self.showInfo()})
		keyboard.backspace().onPressDo({self.back()})
		keyboard.space().onPressDo({self.toBattle()})
	}
	
	method toBattle() {
		if(self.ready()) { warSystem.start() }
	}

	//Queda agregar stats para luego mostrarlos como valores fijos en los primeros 5 pj de cada equipo.
	method showInfo() {
		if(!game.hasVisual(info)) {
			game.addVisual(info)
		}
	}

	method back() {
		if(game.hasVisual(info)) {
		   game.removeVisual(info)
		}
	}
	//Queda agregar stats para luego mostrarlos como valores fijos en los primeros 5 pj de cada equipo.
	
	
	method addCharactersVisual() {
		game.addVisual(allChampions.paladin())
		game.addVisual(allChampions.berserker())
		game.addVisual(allChampions.archer())
		game.addVisual(allChampions.mage())
		game.addVisual(allChampions.doomGuy())
		game.addVisual(allChampions.knight())
		game.addVisual(allChampions.dracula())
		game.addVisual(allChampions.darkBerserker())
		game.addVisual(allChampions.goblin())
		game.addVisual(allChampions.wizard())
		game.addVisual(allChampions.pinkyDemon())
		game.addVisual(allChampions.spellCaster())
	}

	method selectChar() {
		if(!self.ready()) {
			self.actualChamp().image(self.actualChamp().name() + "S.png")
			actualTurn.team().addChampion(self.actualChamp())
			cursor.removeActual(self.actualTeamOfTurn())
			cursor.adjustAfterSelection(self.actualTeamOfTurn())
			self.changeTurn()
			}
			else { game.removeVisual(cursor)
		   	 	   game.say(self, "¡QUE COMIENCE LA BATALLA!") }
	}	
	
	method changeTurn() {
		if(actualTurn.team().fullTeam() && not self.ready()) {
			actualTurn = playerSelector.secondSelector()
			playerSelector.turn(actualTurn.number())
			game.say(self, "Elige 3 campeones el jugador" + playerSelector.turn().toString())
			cursor.adjustAfterSelection(self.actualTeamOfTurn())
		}
	}	
	
	method actualChamp() {
		return cursor.collider()
	}
	
	method ready() {
		return playerSelector.firstSelector().team().fullTeam() and playerSelector.secondSelector().team().fullTeam()
	}
	
}


object selectorChampIndicator {
	
	method position() {
		if(champsSelection.ready()) {
			return game.at(10,6)
		}
		else { return game.at(13,6) }
	}
	
	method image() {
		if(champsSelection.ready()) {
			return "enterArena.png"
		}
		else { return champsSelection.actualTurn().team().name() + "Select.png" }
		}
	
}


object info {
	
const property position = game.origin()

	method image() {
		return cursor.collider().name().toString() + "I.png"
	}
	
}
