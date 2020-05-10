import wollok.game.*
//import equipement.*


object ogre {
	//Stats
	var maxHP = (-1).randomUpTo(-50).truncate(0)
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
	method position(){
		return game.at(3,6)
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
