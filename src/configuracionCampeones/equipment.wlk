import champions.*

//Armor

class Weapon {
	
const property physicalDmg
const property magicDmg
	
}

class Armor {
	
const property physicalRes
const property magicRes
	
}

object equipments {

const property sword = new Weapon(physicalDmg=15, magicDmg=5)
const property axe = new Weapon(physicalDmg=20, magicDmg=0)
const property bow = new Weapon(physicalDmg=10, magicDmg=5)
const property wand = new Weapon(physicalDmg=15, magicDmg=5)
const property rifle = new Weapon(physicalDmg=25, magicDmg=0)
const property weapons = #{sword, axe, bow, wand, rifle}
	
const property leatherArmor= new Armor(physicalRes=10, magicRes=5)
const property steelArmor= new Armor(physicalRes=17, magicRes=8)
const property silverArmor= new Armor(physicalRes=20, magicRes=10)
const property magicArmor=new Armor(physicalRes=6, magicRes=20)	
const property goldArmor= new Armor(physicalRes=30, magicRes=15)
const property armors = #{leatherArmor, steelArmor, silverArmor, magicArmor, goldArmor}	
	
}

