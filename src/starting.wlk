import wollok.game.*
import dice.*
import players2.*
import teams2.*
import champions.*
import battle.*

//PRINCIPAL MENU
object startScreen {
	
var property image = "1.png"
var property position = game.origin()
	
}

//SECONDARY MENU
object rules {
	
	method show() {
		game.clear()
		startScreen.image("2.png")
		game.addVisual(startScreen)
		keyboard.enter().onPressDo({teamSelector.rollDiceScreen()})
	}
	
}


//THIRD MENU
object teamSelector {
	
const dice1 = new Dice(position=game.at(4,5))
const dice2 = new Dice(position=game.at(24,5))	
	
	method rollDiceScreen() {
		game.clear()
		startScreen.image("3.png")
		game.addVisual(startScreen)
		keyboard.s().onPressDo({self.rollDice()})
	}
	
	method rollDice() {
		if (playerSelector.turn() == 1) {
			dice1.roll()
			game.addVisual(dice1)
			playerSelector.turn(2)
		}
		else { 
			dice2.roll()
			game.addVisual(dice2)
			self.winner()
		}
	}
	
	method winner() {
		       if(dice1.number() > dice2.number()) { playerSelector.turn(1) 
		       										 game.say(startScreen, "El jugador 1 elige")
		       										 game.onTick(2000, "team Selection", { teamSelection.show() })
		       }
		  else if(dice2.number() > dice1.number()) { playerSelector.turn(2)
		  											 game.say(startScreen, "El jugador 2 elige")
		  											 game.onTick(2000, "team Selection", { teamSelection.show() })
		  }
		  else { game.say(startScreen, "Un justo empate, otro intento...")
		  		 game.onTick(2000, "empate", {playerSelector.turn(1) 
		  		 							  self.rollDiceScreen()})
		  }
	}
	
	method winnerPlayer() {
		return if(dice1.number() > dice2.number()) { player1 } else { player2 }
	}
	method loserPlayer() {
		return if(dice1.number() > dice2.number()) { player2 } else { player1 }
	}
	
	
}


//FOURTH MENU
object teamSelection {	
	
	method show() {
		game.clear()
		startScreen.image("selectTeam" + playerSelector.turn().toString() + ".png")
		game.addVisual(startScreen)
		game.addVisual(initialLightness)
		game.addVisual(initialDarkness)
		game.addVisual(initialCursor)
		keyboard.right().onPressDo({initialCursor.position(initialCursor.actualTeam().nextTeam().position())})
		keyboard.left().onPressDo({initialCursor.position(initialCursor.actualTeam().nextTeam().position())})
		keyboard.s().onPressDo({ teamSelector.winnerPlayer().team(initialCursor.actualComplexTeam())
								 teamSelector.loserPlayer().team(initialCursor.actualTeam().nextComplexTeam())
								 champsSelection.show() 
								 })
	}
	
}


//FIFTH MENU
object champsSelection {
	
//LIGHTNESS
const property paladin = new Champion(position=game.at(10,11), image="paladin.png", team=lightness, name="paladin")
const property berserker = new Champion(position=game.at(12,11), image="berserker.png", team=lightness, name="berserker")
const property archer = new Champion(position=game.at(14,11), image="archer.png", team=lightness, name="archer")
const property mage = new Champion(position=game.at(16,11), image="mage.png", team=lightness, name="mage")
const property doomGuy = new Champion(position=game.at(18,11), image="doomGuy.png", team=lightness, name="doomGuy")
const property knight = new Champion(position=game.at(20,11), image="knight.png", team=lightness, name="knight")
//DARKNESS
const property dracula = new Champion(position=game.at(10,2), image="dracula.png", team=darkness, name="dracula")
const property darkBerserker = new Champion(position=game.at(12,2), image="darkBerserker.png", team=darkness, name="darkBerserker")
const property goblin = new Champion(position=game.at(14,2), image="goblin.png", team=darkness, name="goblin")
const property wizard = new Champion(position=game.at(16,2), image="wizard.png", team=darkness, name="wizard")
const property pinkyDemon = new Champion(position=game.at(18,2), image="pinkyDemon.png", team=darkness, name="pinkyDemon")
const property spellCaster = new Champion(position=game.at(20,2), image="spellCaster.png", team=darkness, name="spellCaster")
//TEAMS
const property lightTeam = [paladin,berserker,archer,mage,doomGuy,knight]
const property darkTeam = [dracula,darkBerserker,goblin,wizard,pinkyDemon,spellCaster]
var property initialPosition= 0
var property turn = teamSelector.winnerPlayer()
var property actualChar = teamSelector.winnerPlayer().team().leader()

	
	method show() {
		game.clear()
		startScreen.image("selectPJ.png")
		game.addVisual(startScreen)
		self.addCharactersVisual()
		game.say(startScreen, "Elige 3 campeones el jugador " + playerSelector.turn().toString())
		initialCursor.position(actualChar.position())
		game.addVisual(initialCursor)
		keyboard.right().onPressDo({self.nextChar()})
		keyboard.left().onPressDo({self.previousChar()})
		keyboard.s().onPressDo({self.selectChar()})
	}
	
	
	method addCharactersVisual() {
		game.addVisual(paladin)
		game.addVisual(berserker)
		game.addVisual(archer)
		game.addVisual(mage)
		game.addVisual(doomGuy)
		game.addVisual(knight)
		game.addVisual(dracula)
		game.addVisual(darkBerserker)
		game.addVisual(goblin)
		game.addVisual(wizard)
		game.addVisual(pinkyDemon)
		game.addVisual(spellCaster)
	}

	
	method nextChar() {
		if (initialPosition < 5) {
			initialPosition += 1
			initialCursor.position(initialCursor.position().right(2))
		}
	}
	
	method previousChar() {
		if (initialPosition > 0) {
			initialPosition -= 1 
			initialCursor.position(initialCursor.position().left(2))
		}
	}
	
	method selectChar() {
		self.champActual().image(self.champActual().name() + "S.png")
		turn.team().champions().add(self.champActual())
		self.changeTurn()
		self.endSelection()
	}	
	
	method changeTurn() {
		if(turn.team().fullTeam() and not self.ready()) {
			turn = teamSelector.loserPlayer()
			actualChar = teamSelector.loserPlayer().team().leader()
			initialPosition = 0
			game.say(startScreen, "Elige 3 campeones el jugador" + playerSelector.turn().toString())
			initialCursor.position(self.actualChar().position())
		}
	}	
	
	method endSelection() {
		if(self.ready()) 
		   { game.removeVisual(initialCursor)
		   	 game.say(startScreen, "FINALIZAN LAS ELECCIONES")
		   	 game.addVisual(enterArena)
		   	 keyboard.space().onPressDo({battle.start()})
		   }
	}
	
	method champActual() {
		return game.uniqueCollider(initialCursor)
	}
	
	method ready() {
		return teamSelector.loserPlayer().team().fullTeam() and teamSelector.loserPlayer().team().fullTeam()
	}
	
}


object enterArena {
	
var property position = game.at(10,5)
var property image = "enterToArena.png"	
	
}



object initialCursor {
	
var property position = initialLightness.position()
var property image = "initialCursor.png"	
	
	method actualTeam() {
		return game.uniqueCollider(self)
	}	
	
	method actualComplexTeam() {
		if ( self.actualTeam().isLight() ) { return lightness }
		else { return darkness }
	}	
	
}


object initialLightness {
const property position = game.at(2,6)
const property image = "light.png"
	method nextTeam() { return initialDarkness }
	method nextComplexTeam() { return darkness }
	method isLight() { return true }		
}

object initialDarkness {
const property position = game.at(24,6)
const property image = "dark.png"
	method nextTeam() { return initialLightness }
	method nextComplexTeam() { return lightness }
	method isLight() { return false }
}



