class Buff {
var property physicalGains
var property magicGains
var property cost
}

object buffs {
	
const property noBuff = new Buff(physicalGains=0, magicGains=0, cost=0)	
const property illumination = new Buff(physicalGains=0, magicGains=0, cost=0)	
const property gloom = new Buff(physicalGains=0, magicGains=0, cost=0)	
	
}

/* 
object noBuff {
	method physicalGains() { return 0 }
	method magicGains() { return 0 }
	method cost() { return 0 }
}

object illumination {
	method physicalGains() { return 15 }
	method magicGains() { return 15 }
	method cost() { return 5 }
}

object darker {
	method physicalGains() { return 23 }
	method magicGains() { return 23 }
	method cost() { return 15 }
}

object sacrifice {
	method physicalGains() { return 30 }
	method magicGains() { return 30 }
	method cost() { return 20 }
}
*/