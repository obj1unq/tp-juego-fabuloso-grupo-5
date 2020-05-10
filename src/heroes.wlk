import wollok.game.*
import wizard.*
import randomizer.*
import equipement.*
import enemies.*

object knight {
	
var property position = game.at(1,6)
	
var property maxHp = (25).randomUpTo(50).truncate(0)
var property hp = maxHp
var property strength = 5
var property sabidury = 1
var property status = "alive"
var property weapon = sword 
var property armor = heavyArmor 
var property buff = noBuff 
var property spell = shieldHit


	method image() {
		if (hp > 0)
		return "pjDerAt"
		else status = "dead"
			 return "pjDeadDer.png"			  		 
	}
	
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHp().toString()
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method attack(obj){
		obj.takeDamage((weapon.damage()+self.strength()+buff.physicalGains()))
	}
	method magicalAttack(objective){
		objective.takeMagicalDamage((spell.damage()+self.sabidury()+buff.magicGains()))
	}
	method takeDamage(damage){
		hp = (hp -(damage.abs()-armor.PR())).max(0)
	}
	method takeMagicalDamage(damage){
		hp = (hp - (damage.abs()-armor.MR())).max(0)
	}
	
}


object wizard {
	
var property position = game.at(1,5)
	
var property maxHp = (10).randomUpTo(25).truncate(0)
var property hp = maxHp
var property strength = 1
var property sabidury = 5
var property status = "alive"
var property weapon = wand
var property armor = leatherArmour 
var property buff = illumination
var property spell = lightBlast


	method image() {
		if (hp > 0)
		return "wizard.png"
		else status = "dead"
			 return "dead-wizard.png"			  		 
	}	
	
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHp().toString()
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method attack(obj){
		obj.takeDamage((weapon.damage()+self.strength()+buff.physicalGains()))
	}
	method magicalAttack(objective){
		objective.takeMagicalDamage((spell.damage()+self.sabidury()+buff.magicGains()))
	}
	method takeDamage(damage){
		hp = (hp -(damage.abs()-armor.PR())).max(0)
	}
	method takeMagicalDamage(damage){
		hp = (hp - (damage.abs()-armor.MR())).max(0)
	}
	
	
}






