import wollok.game.*
//import equipement.*


object ogre {
	//Visuals
	var property position = game.at(3,6)
	//Visuals
	//Stats
	var maxHP = (-25).randomUpTo(-50).truncate(0)
	var hp= maxHP
	var property armor = 15.randomUpTo(20).truncate(0)
	var property magicalResistance = 5.randomUpTo(10).truncate(0)
	var property status = "alive"
	var property buff = 0
	var property magicalBuff= 0
	var property strenght = 5
	var property sabidury = 1
	//Stats
	//Equipment
	var property meleeWeapon = null //pendiente
	var property rangedWeapon = bow
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
		objective.takeDamage(-(weapon.damage()+self.strenght()+self.buff()))
		actualTurn.nextTurn()
	}
	method magicalAttack(objective, spell){
		objective.takeMagicalDamage(-(spell.damage()+self.sabidury()+self.magicalBuff()))
		actualTurn.nextTurn()
	}
	method takeDamage(damage){
		hp = (hp + (damage-self.armor())).min(0)
	}
	method takeMagicalDamage(damage){
		hp = (hp + (damage-self.magicalResistance())).min(0)
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
	var property armor = 5.randomUpTo(10).truncate(0)
	var property magicalResistance = 10.randomUpTo(20).truncate(0)
	var property status = "alive"
	var property buff = 0
	var property magicalBuff= 0
	var property strenght = 2
	var property sabidury = 5
	//Stats
	//Equipment
	var property meleeWeapon = null //pendiente
	var property rangedWeapon = bow
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
		objective.takeDamage(-(weapon.damage()+self.strenght()+self.buff()))
		actualTurn.nextTurn()
	}
	method magicalAttack(objective, spell){
		objective.takeMagicalDamage(-(spell.damage()+self.sabidury()+self.magicalBuff()))
		actualTurn.nextTurn()
	}
	method takeDamage(damage){
		hp = (hp + (damage-self.armor())).min(0)
	}
	method takeMagicalDamage(damage){
		hp = (hp + (damage-self.magicalResistance())).min(0)
	}
	//Actions
}