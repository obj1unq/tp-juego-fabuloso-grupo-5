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
 	override method effect(attacker, objective) {
 		objective.buff(buffs.illumination())
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