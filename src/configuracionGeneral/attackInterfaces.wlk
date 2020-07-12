import wollok.game.*
import configuracionCampeones.teams.*
import fightingSystem.*
import configuracionCampeones.champions.*


class AttackTabs {
	
var property actualChamp

	method position() {
		return if(actualChamp.team().isLight()) {
			game.at(4, actualChamp.yCoordinateForAttack())
		}
		else { game.at(21, actualChamp.yCoordinateForAttack()) }
	}	
	
	method show(attacker) {
		actualChamp=attacker
		game.addVisual(self)
	}
	
	method remove() {
		if(game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
	
}

object attackSystem inherits AttackTabs {
	
	method image() {
		return 
		if(actualChamp.knowsSorcery())	{
			actualChamp.team().name() + "AttackInterfaceS.png"
		}
		else {
			actualChamp.team().name() + "AttackInterface.png"
		}
	}
	
}


object spellsSystem inherits AttackTabs {
	
	method image() {
		return
		if(actualChamp.spells().size() == 3) {
			actualChamp.team().name() + "Spells.png"
		}
		else { actualChamp.team().name() + "lastBreath.png" }
	}
	
}
