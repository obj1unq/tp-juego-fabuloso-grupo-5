import wollok.game.*

object gameOver {
	
const property position = game.at(14,8)
	
	method image() {
		return "dice6.png"
	}
	
	method win(actualTurn) {
		if (!actualTurn.team().champions().isEmpty()) {
			game.addVisual(self)
			game.say(self, "Gana el jugador" + actualTurn.number().toString())
			game.schedule(2000, {game.stop()})
		}
		else { game.say(self, "Empate")
			   game.schedule(2000, {game.stop()})
		}
	}
	
}
