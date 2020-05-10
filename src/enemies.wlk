import wollok.game.*
import equipement.*


object ogre {
	//Visuals
	var property position = game.at(3,6)
	//Visuals
	//Stats
	var maxHP = (-25).randomUpTo(-50).truncate(0)
	var hp= maxHP
	var property status = "alive"
	var property buff = noBuff
	var property strenght = 5
	var property sabidury = 1
	//Stats
	//Equipment
	var property weapon = axe
	var property armor = heavyArmor
	var property spell = acidSpit
	//Equipment
	
	//Visuals
	method image(){
		if (hp<0)
			return "ogre.png"
		else{
			status= "dead"
			return "ogre-dead.png"
		}
	}
	//Visuals
	//Stats
	method maxHP() {
		return maxHP.abs()
	}
	method actualHP() {
		return hp.abs()
	}
	method totalHP() {
		return self.actualHP().toString() + "/" + self.maxHP().toString()
	}
	//Stats
	//Actions
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method attack(objective, weapon){
		objective.takeDamage(-(weapon.damage()+self.strenght()+buff.physicalGains()))
	}
	method magicalAttack(objective, spell){
		objective.takeMagicalDamage(-(spell.damage()+self.sabidury()+buff.magicGains()))
	}
	method takeDamage(damage){
		hp = (hp + (damage-armor.PR())).min(0)
	}
	method takeMagicalDamage(damage){
		hp = (hp + (damage-armor.MR())).min(0)
	}
	//Actions
}

object darkElf {
	//Visuals
	var property position = game.at(4,5)
	//Visuals
	//Stats
	var maxHP = (-10).randomUpTo(-25).truncate(0)
	var hp= maxHP
	var property status = "alive"
	var property buff = noBuff
	var property strenght = 2
	var property sabidury = 5
	//Stats
	//Equipment
	var property armor = leatherArmor
	var property weapon = bow
	var property spell = darkBlast
	//Equipment
	
	//Visuals
	method image(){
		if (hp<0)
			return "darkElf.png"
		else{
			status= "dead"
			return "darkElf-dead.png"
		}
	}
	//Visuals
	//Stats
	method maxHP() {
		return maxHP.abs()
	}
	method actualHP() {
		return hp.abs()
	}
	method totalHP() {
		return self.actualHP().toString() + "/" + self.maxHP().toString()
	}
	//Stats
	//Actions
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method attack(objective, weapon){
		objective.takeDamage(-(weapon.damage()+self.strenght()+buff.physicalGains()))
	}
	method magicalAttack(objective, spell){
		objective.takeMagicalDamage(-(spell.damage()+self.sabidury()+buff.magicGains()))
	}
	method takeDamage(damage){
		hp = (hp + (damage-armor.PR())).min(0)
	}
	method takeMagicalDamage(damage){
		hp = (hp + (damage-armor.MR())).min(0)
	}
	//Actions
}