import wollok.game.*
import knight.*
import randomizer.*

object wizard {
	
	
const maxHP = (1).randomUpTo(35).truncate(0)
var property hp = maxHP
var property bAtk = 20
var property weapon = simpleWand
var property armour = leatherArmour
var property buff = cure // or anger


	method image() = "wizard.png"
	
	method attack(obj) {
		obj.takeDamage(self)
	}
	
	method takeDamage(obj) {
		hp -= (obj.physicalDmg() - armour.PR())
					 + 
					 (obj.magicDmg() - armour.MR())
	}
	
	method enchaint(ally) {
		buff.giveEffect(ally)
	}
	
}

/////////////////////////////////////////////BUFFS

object cure {
	
	method giveEffect(obj) {
		obj.currentHP(obj.currentHP() + 40)
	}
	
	method physicalGains() {
		return 0
	}
	
	method magicGains() {
		return 0
	}
	
}

object anger {
	
	method giveEffect(obj) {
		obj.add(self)
	}
	
	method physicalGains() {
		return 20
	}
	
	method magicGains() {
		return 0
	}
	
}

//////////////////////////////ARMADURAS

object leatherArmour {
	
	method MR() {
		return 10
	}
	
	method PR() {
		return 30
	}
	
}

object ironArmour {
	
	method MR() {
		return 20
	}
	
	method PR() {
		return 50
	}
	
}

object diamondArmour {
	
	method MR() {
		return 40
	}
	
	method PR() {
		return 80
	}
	
}

//////////////////////////ARMAS

object sword {
	
	method MD() { //Magic dmg
		return 0
	}
	
	method PD() { //Physical dmg
		return 2
	}
	
}

object simpleWand {
	
	method MD() {
		return 2
	}
	
	method PD() {
		return 0
	}
	
}

//para el caballero
object hammer {
	
	method MD() {
		return 0
	}
	
	method PD() {
		return 4
	}
	
}

//para el mago
object talisman {
	
	method MD() {
		return 4
	}
	
	method PD() {
		return 0
	}
	
}