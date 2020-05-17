import wollok.game.*
import heroes.*
import enemies.*
import attack.*
import buffs.*
import teams.*

//LIGHT SPELLS
 object destructiveLightWave {
 	method effect(attacker, objective) {
 		objective.takeDamage(attacker.wisdom() * 2)
 		attacker.wisdom( (attacker.wisdom() - 2).max(0) )
 	}
 }
 
 object healingLightWave {
 	method effect(attacker, objective) {
 		if (lightDefenders.isFromTeam( objective )) {
 		objective.hp( (objective.hp() + (attacker.wisdom() * 4)).min(objective.maxHP()) )
 		}
 		else { game.say(attacker, "¡No debo curar a mi enemigo!") }
 	}
 }
 
 object invigoratingLightWave {
 	method effect(attacker, objective) {
 		objective.buff(illumination)
 	}
 }
 
 
//DARK SPELLS
object destructiveDarkWave {
	method effect(attacker, objective) {
 		objective.takeDamage(attacker.wisdom() * 3)
 		attacker.wisdom( (attacker.wisdom() - 4).max(0) )
 	}
 }
 
 object healingDarkWave {
 	method effect(attacker, objective) {
 		if (darkDefenders.isFromTeam( objective )) {
 		objective.hp( (objective.hp() - (attacker.wisdom() * 3)).min(objective.maxHP()) )
 		}
 		else { game.say(attacker, "¡No debo curar a mi enemigo!") }
 	}
 }
 
 object invigoratingDarkWave {
 	method effect(attacker, objective) {
 		objective.buff(darkness)
 	}
 }
