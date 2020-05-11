import wollok.game.*
import equipement.*


object ogre {
	//Visuals
	var property position = game.at(3,6)
	//Visuals
	//Stats
	var maxHP = (-25).randomUpTo(-50).truncate(0)
	var actualHP = maxHP
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
		if (actualHP<0)
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
	method hp() {
		return actualHP.abs()
	}
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHP().toString()
	}
	//Stats
	//Actions
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method physicalAttack(objective, _weapon){
		objective.takeDamage(-(_weapon.damage()+self.strenght()+buff.physicalGains()))
	}
	method magicalAttack(objective, _spell){
		objective.takeMagicalDamage(-(_spell.damage()+self.sabidury()+buff.magicGains()))
	}
	method takeDamage(damage){
		actualHP = (actualHP + (damage-armor.pR())).min(0)
	}
	method takeMagicalDamage(damage){
		actualHP = (actualHP + (damage-armor.mR())).min(0)
	}
	//Actions
}

object darkElf {
	//Visuals
	var property position = game.at(4,5)
	//Visuals
	//Stats
	var maxHP = (-10).randomUpTo(-25).truncate(0)
	var actualHP = maxHP
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
		if (actualHP<0)
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
	method hp() {
		return actualHP.abs()
	}
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHP().toString()
	}
	//Stats
	//Actions
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
	method physicalAttack(objective, _weapon){
		objective.takeDamage(-(_weapon.damage()+self.strenght()+buff.physicalGains()))
	}
	method magicalAttack(objective, _spell){
		objective.takeMagicalDamage(-(_spell.damage()+self.sabidury()+buff.magicGains()))
	}
	method takeDamage(damage){
		actualHP = (actualHP + (damage-armor.pR())).min(0)
	}
	method takeMagicalDamage(damage){
		actualHP = (actualHP + (damage-armor.mR())).min(0)
	}
	//Actions
}
