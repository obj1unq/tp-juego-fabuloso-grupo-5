import wollok.game.*
import dice.*
import players.*
import configuracionCampeones.teams.*
import configuracionCampeones.champions.*
import fightingSystem.*
import cursor.*


class Screen {
	
const property position = game.origin()

	method show() {
		game.clear()
		game.addVisual(self)
	}
	
}


object startScreen inherits Screen {
	
const property image = "1.png"

	override method show() {
		super()
		keyboard.enter().onPressDo({rules.show()})
		keyboard.backspace().onPressDo({game.stop()})
	}
	
}


object rules inherits Screen {
	
const property image = "2.png"

	override method show() {
		super()
		keyboard.enter().onPressDo({teamSelector.show()})
		keyboard.backspace().onPressDo({startScreen.show()})
	}	
	
}


object teamSelector inherits Screen {
	
var property image = "3.png"
	
var dice1 = new Dice(position=game.at(4,5))
var dice2 = new Dice(position=game.at(24,5))	
	
	override method show() {
		super()
		game.say(self, "Tira el dado el jugador 1")
		keyboard.s().onPressDo({self.rollDice()})
		keyboard.backspace().onPressDo({rules.show()})
	}
	
	method rollDice() {
		if (playerSelector.turn() == 1 && !self.thrownDices()) {
			dice1.roll()
			game.addVisual(dice1)
			playerSelector.turn(2)
			game.say(self, "Tira el dado el jugador 2")
		}
		else if (playerSelector.turn() == 2 && !self.thrownDices()) { 
			dice2.roll()
			game.addVisual(dice2)
			self.winSet()
		}
	}
	
	method thrownDices() {
		return game.hasVisual(dice1) && game.hasVisual(dice2)
	}
	
	method winSet() {
		       if(dice1.isGreater(dice2)) { playerSelector.turn(1) 
		       								game.say(self, "El jugador 1 elige")
		       								game.onTick(500, "team Selection", { teamSelection.show() })
		       }
		  else if(dice2.isGreater(dice1)) { playerSelector.turn(2)
		  								    playerSelector.firstSelector(player2)
		  									playerSelector.secondSelector(player1)
		  									game.say(self, "El jugador 2 elige")
		  									game.onTick(500, "team Selection", { teamSelection.show() })
		  }
		  else { game.say(self, "Un justo empate, otro intento...")
		  		 game.onTick(1000, "empate", {playerSelector.turn(1) 
		  		 							  self.show()})
		  }
	}
	
	method clear() {
		dice1 = new Dice(position=game.at(4,5))
    	dice2 = new Dice(position=game.at(24,5))	
	}
	
	method winnerSelectorNumber() {
		return if (dice1.isGreater(dice2)) { 1 } else { 2 }
	}
	
}



object teamSelection inherits Screen {	
	
	method image() {
		return "selectTeam" + teamSelector.winnerSelectorNumber().toString() + ".png"
	}
	
	override method show() {
		super()
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



object champsSelection inherits Screen {
	
const property image = "SelectPJ.png"
var property actualTurn

	method initializeActualTurn() {
		actualTurn = playerSelector.firstSelector()
	}
	
	method initialCharS() {
		return actualTurn.team().leader()
	}
	
	method actualTeamOfTurn() {
		return if (actualTurn.team().isLight()) { championsToSelect.lightTeam() }
			   else { championsToSelect.darkTeam() }
	}


	override method show() {
		super()
		self.initializeActualTurn()
		self.addCharactersVisual()
		game.say(self, "Elige 3 campeones el jugador " + playerSelector.turn().toString())
		cursor.position(self.initialCharS().position())
		game.addVisual(cursor)
		game.addVisual(selectorChampIndicator)
		keyboard.right().onPressDo({self.nextChar()})
		keyboard.left().onPressDo({self.previousChar()})
		keyboard.s().onPressDo({self.selectChar()})
		keyboard.i().onPressDo({self.showInfo()})
		keyboard.c().onPressDo({self.showActualTip()})
		keyboard.backspace().onPressDo({self.back()})
	}

	method showInfo() {
		info.addVisual()
	}

	method back() {
		if(info.isInGame() && !self.ready()) {
		   game.removeVisual(info)
		}
	}
	
	method showActualTip() {
		if(info.isInGame() && !self.ready()) {
			info.sayTip(self.actualChamp())
		}
	}
	
	
	method addCharactersVisual() {
		championsToSelect.addVisuals()
	}
	
	method nextChar() {
		if(!info.isInGame()) {
			cursor.nextChar(self.actualTeamOfTurn())
		}
	}
	
	method previousChar() {
		if(!info.isInGame()) {
			cursor.previousChar(self.actualTeamOfTurn())
		}
	}

	method selectChar() {
			if(!self.ready()) {
				self.actualChamp().image(self.actualChamp().name() + "S.png")
				actualTurn.team().addChampion(self.actualChampSelect())
				cursor.removeActual(self.actualTeamOfTurn())
				cursor.adjustAfterSelection(self.actualTeamOfTurn())
				self.changeTurn()
				self.validateEndSelection()
			}
	}
	
	method changeTurn() {
		if(actualTurn.team().fullTeam() && not self.ready()) {
			actualTurn = playerSelector.secondSelector()
			playerSelector.turn(actualTurn.number())
			game.say(self, "Elige 3 campeones el jugador" + playerSelector.turn().toString())
			cursor.adjustAfterSelection(self.actualTeamOfTurn())
		}
	}	 
	
	method validateEndSelection() {
		if (self.ready()) {
			game.removeVisual(cursor)
			game.say(self, "¡Concluyen las elecciones!")
			game.schedule(1200, {selectorArenaIndicator.show()})
			lightness.configChampionsImmutable()
			darkness.configChampionsImmutable()
		}
	}

	method actualChamp() {
		return cursor.collider()
	}

	method actualChampSelect() {
		return championsInBattle.find(cursor.collider(), actualTurn.team())
	}
	
	method ready() {
		return playerSelector.firstSelector().team().fullTeam() and playerSelector.secondSelector().team().fullTeam()
	}
	
}


object selectorChampIndicator {
	
	method position() {
		return game.at(13,6)
	}
	
	method image() {
		return champsSelection.actualTurn().team().name() + "Select.png"
	}
	
}

object selectorArenaIndicator inherits Screen {
	
const property arena1 = new Arena1()
const property arena2 = new Arena2()
const property arena3 = new Arena3()
const property arena4 = new Arena4()
const property arena5 = new Arena5()
const property arena6 = new Arena6()
const property arena7 = new Arena7()
const property arena8 = new Arena8()

const property arenas = [arena1, arena2, arena3, arena4, arena5, arena6, arena7, arena8]
var property arenaSelected

const property image = "backgroundSelectArena.png"

	method image() {
		return "backGroundSelectArena" + teamSelector.winnerSelectorNumber().toString() + ".png"
	}

	override method show() {
		super()
		cursor.position(arena1.position())
		cursor.initialPosition(0)
		game.addVisual(arena1)
		game.addVisual(arena2)
		game.addVisual(arena3)
		game.addVisual(arena4)
		game.addVisual(arena5)
		game.addVisual(arena6)
		game.addVisual(arena7)
		game.addVisual(arena8)
		game.addVisual(cursor)
		keyboard.right().onPressDo({self.nextCharA()})
		keyboard.left().onPressDo({self.previousCharA()})
		keyboard.s().onPressDo({ self.selectArena() })
	}
	
	method selectArena() {
		if(game.hasVisual(cursor)) { 
			cursor.collider().isSelected(true)
			arenaSelected = cursor.collider()
			game.say(self, "¡Empieza la batalla!")
			warSystem.image("arena" + cursor.collider().number().toString() + "SS.png")
			game.removeVisual(cursor)
			game.schedule(600, {controlsReminder.show()})
		}
	}	
	
	method nextCharA() {
		if(game.hasVisual(cursor)) { cursor.nextChar(arenas) }
	}
	
	method previousCharA() {
		if(game.hasVisual(cursor)) { cursor.previousChar(arenas) }
	}
	
	method reset() {
		arenaSelected.isSelected(false)
	}
	
}

object controlsReminder inherits Screen {
	
const property image = "4.png"
	
	override method show() {
		super()
		keyboard.enter().onPressDo({ warSystem.start() })
	}
	
}



object info {
	
const property position = game.origin()

	method image() {
		return champsSelection.actualChamp().name() + "I.png"
	}
	
	method isInGame() {
		return game.hasVisual(self)
	}
	
	method sayTip(champ) {
		game.say(self, champ.tip())
	}
	
	method addVisual() {
		if(!self.isInGame() && !champsSelection.ready()) {
			game.addVisual(self)
		}
	}
	
}


class Arena1 {
	
var property isSelected = false	
	
	method number() { return 1 }
	method image() { return if (isSelected) { "arena" + self.number().toString() + "S.png" }
					else {"arena" + self.number().toString() + ".png"} }
	method position() { return game.at(7,8) }
}
class Arena2 inherits Arena1{
	override method number() { return 2 }
	override method position() { return game.at(11,8) }
}
class Arena3 inherits Arena1{
	override method number() { return 3 }
	override method position() { return game.at(15,8) }
}
class Arena4 inherits Arena1{
	override method number() { return 4 }
	override method position() { return game.at(19,8) }
}
class Arena5 inherits Arena1{
	override method number() { return 5 }
	override method position() { return game.at(7,6) }
}
class Arena6 inherits Arena1{
	override method number() { return 6 }
	override method position() { return game.at(11,6) }
}
class Arena7 inherits Arena1{
	override method number() { return 7 }
	override method position() { return game.at(15,6) }
}
class Arena8 inherits Arena1{
	override method number() { return 8 }
	override method position() { return game.at(19,6) }
}










