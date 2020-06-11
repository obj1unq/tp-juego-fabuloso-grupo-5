import wollok.game.*
import wizard.*
import randomizer.*

object knight {
	
	
const maxHp = (1).randomUpTo(50).truncate(0)
var property hp = maxHp
var property bAtk = 5
var property weapon = sword 
var property armour = leatherArmour 
var property buff = null


	method image() {
		return "knight.png"
	}
	
	method attack(obj) {
		obj.takeDamage(self)
	}
	
	method takeDamage(obj) {
		hp -= (obj.physicalDmg() - armour.PR())
			   + 
			  (obj.magicDmg() - armour.MR())
	}
	
	method physicalDmg() {
		return bAtk * weapon.PD().max(1) + buff.physicalGains()
	}
	
	method magicDmg() {
		return bAtk * weapon.PM().max(1) + buff.magicGains()
	}
	
}






