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
	
	override method validate(attacker, objective) {
		if (attacker.isOfSameTeam(objective) && not objective.isBuffed()) {
 			warSystem.executeSpellCast()
 		} else if (attacker.isOfSameTeam(objective)) {
 			game.say(attacker, "No debo ayudar a un enemigo")
 		} else {
 			game.say(attacker, "El " + objective.name() + " ya está buffeado")
 		}
	}
	
 	override method effect(attacker, objective) {
 		if (attacker.team().isLight() && not objective.isBuffed()) {
 			const illumination = new Illumination()
 		    objective.buff(illumination)
 		    illumination.appear(objective)
 		    game.say(objective, "¡El próximo ataque será mas fuerte!")
 		}
 		else if (not objective.isBuffed()) {
 			const gloom = new Gloom() 
 			objective.buff(gloom)
 			gloom.appear(objective)
 			game.say(objective, "¡El próximo ataque será mas fuerte!")
 		} else {
 			game.say(attacker, "El " + objective.name() + " ya está buffeado")
 		}
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