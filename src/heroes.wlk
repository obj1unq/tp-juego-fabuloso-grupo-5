import wollok.game.*
import equipement.*
import enemies.*
import gameConfig.hpBarKnight.*
import gameConfig.hpBarWizard.*

object knight {
	
var property position = game.at(4,5)
	
var property maxHP = (25).randomUpTo(50).truncate(0)
var property hp = maxHP
var property strength = 5
var property sabidury = 1
var property status = "alive"
var property weapon = sword
var property armor = heavyArmor 
var property buff = noBuff 
var property spell = shieldHit

	method hpBar() {
		game.addVisual(hpBarKnight)
	}
	

	method image() {
		if (hp > 0)
		return "pjDerAt.png"
		else status = "dead"
			 return "pjDeadDer.png"			  		 
	}
	
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHP().toString()
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method physicalAttack(objective){
		objective.takeDamage((weapon.damage()+self.strength()+buff.physicalGains()))
	}
	method magicalAttack(objective){ //REVISAR
		objective.takeMagicalDamage((spell.damage()+self.sabidury()+buff.magicGains()))
	}
	method takeDamage(damage){
		hp = (hp -(damage.abs()-armor.pR())).max(0)
	}
	method takeMagicalDamage(damage){
		hp = (hp - (damage.abs()-armor.mR())).max(0)
	}
	
}


object wizard {
	
	var property position = game.at(3,4)
	
	var property maxHP = (10).randomUpTo(25).truncate(0)
	var property hp = maxHP
	var property strength = 1
	var property sabidury = 5
	var property status = "alive"
	var property weapon = wand
	var property armor = leatherArmor 
	var property buff = illumination
	var property spell = lightBlast

	method hpBar() {
		game.addVisual(hpBarWizard)
	}

	method image() {
		if (hp > 0)
		return "wizard.png"
		else status = "dead"
			 return "dead-wizard.png"			  		 
	}	
	
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHP().toString()
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method physicalAttack(objective){
		objective.takeDamage((weapon.damage()+self.strength()+buff.physicalGains()))
	}
	method magicalAttack(objective){
		objective.takeMagicalDamage((spell.damage()+self.sabidury()+buff.magicGains()))
	}
	method takeDamage(damage){
		hp = (hp -(damage.abs()-armor.pR())).max(0)
	}
	method takeMagicalDamage(damage){
		hp = (hp - (damage.abs()-armor.mR())).max(0)
	}
	
	
}