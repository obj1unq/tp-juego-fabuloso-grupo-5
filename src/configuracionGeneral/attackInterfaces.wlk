import wollok.game.*
import configuracionCampeones.teams.*
import fightingSystem.*
import configuracionCampeones.champions.*


/* 
object attackSystem {
	
	method position() {
		return
		if (lightness.isFromTeam(warSystem.selectedAttacker())) {
 			warSystem.selectedAttacker().position().left(5).down(1)}
 		else { warSystem.selectedAttacker().position().right(2).down(1) }
  }
	
	method image() {
		return if (warSystem.selectedAttacker().knowsSorcery() && lightness.isFromTeam(warSystem.selectedAttacker())) {
		"lightSpells2.png"
		}
		else if ( warSystem.selectedAttacker().knowsSorcery() && lightness.isFromTeam(warSystem.selectedAttacker())) { "darkSpells2.png" }
		else { "attackSystemNoSorcery.png" } 
		}
	
}
*/

class AttackTabs {
	
var property actualChamp

	method position() {
		return if(actualChamp.team().isLight()) {
			game.at(4, actualChamp.yCoordinateForAttack())
		}
		else { game.at(21, actualChamp.yCoordinateForAttack()) }
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
			actualChamp.team().name().toString() + "AttackInterfaceS.png"
		}
		else {
			actualChamp.team().name().toString() + "AttackInterface.png"
		}
	}
	
}


object spellsSystem inherits AttackTabs {
	
	method image() {
		return
		if(actualChamp.spells().size() == 3) {
			actualChamp.team().name().toString() + "Spells.png"
		}
		else { actualChamp.team().name().toString() + "lastBreath.png" }
	}
	
}
