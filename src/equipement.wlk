//Armor
object leatherArmor{
	method pR(){
		return 1
	}
	method mR(){
		return 5
	}
}

object heavyArmor{
	method pR(){
		return 5
	}
	method mR(){
		return 2
	}
}
//Armor

//Buffs
object noBuff{
	method physicalGains(){
		return 0
	}
	method magicGains(){
		return 0
	}
}

//Buffs

//Spells
object acidSpit{
	method damage(){
		return 5.randomUpTo(15).truncate(0)
	}
}

object darkBlast{
	method damage(){
		return 5.randomUpTo(10).truncate(0)
	}
}
//Spells

//Weapons
object axe {
	method damage(){
		return 2.randomUpTo(12).truncate(0)	
	}
}
 object bow {
 	method damage(){
 		return 1.randomUpTo(5).truncate(0)
 	}
 }