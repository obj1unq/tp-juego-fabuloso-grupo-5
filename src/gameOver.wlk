import wollok.game.*
import fightingSystem.*
import teams.*

object gameOver {
	
	method end() {
		if(lightDefenders.champions().size() == 0 && darkDefenders.champions().size() != 0) {
			game.onTick(5000, "Derrota", {game.stop()})
			game.say(warSystem.teamTurn().nextTeam().champions().head(), "Victoria de la oscuridad")
		}
		else if(lightDefenders.champions().size() == 0 && darkDefenders.champions().size() == 0) {
			game.onTick(5000, "Empate", {game.stop()})
			game.say(warSystem.selectedAttacker(), "Empate")
		}
		else if(lightDefenders.champions().size() != 0 && darkDefenders.champions().size() == 0) {
			   game.onTick(5000, "Victoria", {game.stop()})
			   game.say(warSystem.teamTurn().nextTeam().champions().head(), "Victoria de la luz")
		}
	}
	
}
