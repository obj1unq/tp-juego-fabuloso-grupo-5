import wollok.game.*
import champions.*
import buffs.*
import teams.*
import configuracionGeneral.fightingSystem.*

class Spell {
	
	method effect(attacker, objective)
	
	method validate(attacker, objective) {
		if (attacker.isOfSameTeam(objective)) {
 			warSystem.executeSpellCast()
 		} else { game.say(attacker, "No debo ayudar a un enemigo") }
	}
}

object destructiveWave inherits Spell {
	override method effect(attacker, objective) {
 		objective.takeDamage(attacker.wisdom() * 4)
 		attacker.wisdom( (attacker.wisdom() / 2) )
 	}
 	
 	override method validate(attacker, objective) {
 		if (!attacker.isOfSameTeam(objective)) {
 			warSystem.executeSpellCast()
 		} else { game.say(attacker, "No debo atacar a mi amigo") }
 	}
}
 
object healingWave inherits Spell {
 	override method effect(attacker, objective) {
 		objective.hp( (objective.hp() + (attacker.wisdom() * 4)).min(objective.maxHP()) )
 	}
}
 
object invigoratingWave inherits Spell {
	
var property invigoratedChamp
	
	method position() {
		return if(invigoratedChamp.team().isLight()) {
			game.at(0, invigoratedChamp.yCoordinateForAttack() + 1)
		}
		else { game.at(28, invigoratedChamp.yCoordinateForAttack() + 1) }
	}

	method image() {
		return invigoratedChamp.team().name() + "Buff.png"
	}	
	
 	override method effect(attacker, objective) {
 		invigoratedChamp = objective
 		//game.addVisual(self) 										Modificado
 		if (attacker.team().isLight()) {
 		    invigoratedChamp.buff(illumination)				//Modificado
 		    //game.addVisual(illumination)					//Modificado
 		    illumination.appear(invigoratedChamp)
 		}
 		else { 
 			invigoratedChamp.buff(gloom)
 			//game.addVisual(buffs.gloom())
 			gloom.appear(invigoratedChamp)
 		}
 		game.say(invigoratedChamp, "¡El próximo ataque será mas fuerte!")
 		attacker.wisdom( attacker.wisdom() / 2 )
 	} 
 	
 	method removeVisual() {
 		if(game.hasVisual(self)) {
 			game.removeVisual(self)
 		}
 	}

}

object lastBreath inherits Spell {
	
	override method effect(attacker, objective) {
 		objective.takeDamage(attacker.wisdom() * 4 + attacker.hp() * 1.5)
 		attacker.wisdom(0) 
 		attacker.hp(1)
 	}
 	
 	override method validate(attacker, objective) {
 		if (!attacker.isOfSameTeam(objective)) {
 			warSystem.executeSpellCast()
 		} else { game.say(attacker, "No debo atacar a mi amigo") }
 	}
	
}