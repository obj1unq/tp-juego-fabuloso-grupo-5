import wollok.game.*
import heroes.*
import enemies.*
import equipment.*
import buffs.*

object physicalAttack {
	
var property attacker = null
var property attacked = null

	method executePhysicalAttack() {
		attacked.takeDamage( ((attacker.strength() + attacker.weapon().pD() + attacker.buff().physicalGains()) - (attacked.armor().mR())).max(0) )
		attacker.takeDamage( attacker.buff().cost() ) 
		attacker.buff(noBuff)
		//Los buffs durarían solo 1 ataque.
	}
	
}



object magicAttack {
	
var property attacker = null
var property attacked = null

	method executeMagicAttack() {
		attacked.takeDamage( ((attacker.wisdom() + attacker.weapon().mD() + attacker.buff().magicGains()) - (attacked.armor().mR())).max(0) )
		attacker.takeDamage( attacker.buff().cost() )
		attacker.buff(noBuff)
		//Los buffs durarían solo 1 ataque.
	}
	
}