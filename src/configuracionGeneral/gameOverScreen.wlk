import wollok.game.*
import fightingSystem.*
import starting.*
import configuracionCampeones.teams.*
import configuracionCampeones.champions.*
import players.*

object gameOver {
	
const property position = game.origin()
var image
	
	method image() {
		return image 
	}
	
	method win(actualTurn) {
		if (!actualTurn.team().champions().isEmpty()) {
			image = self.winner().name() + "gameOver.png" 
			game.schedule(1000, {self.clear()
						         game.addVisual(self)})
		}
		else { game.say(self, "Empate, ¡se deberá jugar de nuevo!")
			   image = "empate.png"
			   game.schedule(1000, {self.clear()
						            game.addVisual(self)})
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
		keyboard.backspace().onPressDo({game.stop()})
	}
	
	method validateEnd() {
		if(warSystem.actualTurn().team().isDefeated() || warSystem.actualTurn().team().nextTeam().isDefeated()) {
			game.say(self, "Gana el jugador " + self.winner().number())
		}
	}
	
	method winner() {
		if(warSystem.actualTurn().team().isDefeated()) {
			return warSystem.actualTurn().nextPlayer()
		}
		else { return warSystem.actualTurn() }
	}
	
}
