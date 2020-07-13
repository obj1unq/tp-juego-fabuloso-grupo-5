import wollok.game.*
import fightingSystem.*
import starting.*
import configuracionCampeones.teams.*
import configuracionCampeones.champions.*
import players.*

object gameOver {
	
const property position = game.at(14,8)
	
	method image() {
		return "dice6.png"
	}
	
	method win(actualTurn) {
		if (!actualTurn.team().champions().isEmpty()) {
			game.addVisual(self)
			game.say(self, "Gana el jugador " + actualTurn.number().toString())
			//game.schedule(2000, {game.stop()})
			game.schedule(1000, {self.clear()})
			//TODO restart game
		}
		else { game.say(self, "Empate")
			   game.schedule(2000, {game.stop()})
		}
	}
	
	method clear() {
		game.clear()
		selectorArenaIndicator.reset()
		playerSelector.reset()
		teamSelector.clear()
		lightness.clear()
		darkness.clear()
		championsToSelect.clear()
		championsInBattle.reset()
		keyboard.r().onPressDo({teamSelector.show()})
	}
	
	method validateEnd() {
		if(warSystem.actualTurn().team().isDefeated() || warSystem.actualTurn().team().nextTeam().isDefeated()) {
			game.say(self, "Gana el jugador " + self.winner())
		}
	}
	
	method winner() {
		if(warSystem.actualTurn().team().isDefeated()) {
			return warSystem.actualTurn().nextPlayer().number()
		}
		else { return warSystem.actualTurn().number() }
	}
	
}
