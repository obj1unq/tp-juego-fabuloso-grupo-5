import teams.*
import heroes.*
import cursor.*
import fightingsystem.*

object cursor {
	var property position = wizard.position()
	var property stage = "attacker"
	var property teamTurn = fightingSystem.teamTurn()
	
	method image() { return self.cursorType("allyCursor.png", "enemyCursor.png") }
	
	method nextStage() {
		if (stage == "attacker") {
			stage = "enemy"
		} else {
			stage = "attacker"
		}
	}
	
	method cursorType(img1, img2) {
		return if (stage == "attacker") { img1 } else { img2 }
	}
	
	method changeTeam() {
		teamTurn.nextChar()
	}
}