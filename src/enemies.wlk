


object ogre {
	//Stats
	var maxHP = (-1).randomUpTo(-50).truncate(0)
	var hp= maxHP
	var property armor = 15.randomUpTo(20).truncate(0)
	var property magicalResistance = 5.randomUpTo(10).truncate(0)
	//Stats
	//Equipment
	var property meleeWeapon = null //pendiente
	var property rangedWeapon = bow
	//Equipment
	
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
}
