import wollok.game.*

class Buff {
var property physicalGains
var property magicGains
var property cost
var property image
var property position
}

object buffs {
	
/*const property noBuff = new Buff(physicalGains=0, magicGains=0, cost=0, image="", position=)	
const property illumination = new Buff(physicalGains=0, magicGains=0, cost=0, image="")	
const property gloom = new Buff(physicalGains=0, magicGains=0, cost=0, image="")	
	*/
}

object noBuff {
	method physicalGains() { return 0 }
	method magicGains() { return 0 }
	method cost() { return 0 }
	
	method remove() {
		game.removeVisual(self)
	}
	
	method image() {
		return "algo.png"
	}
	
}

object illumination {	
	method physicalGains() { return 15 }
	method magicGains() { return 15 }
	method cost() { return 5 }
	
	method appear(champ) {
		game.addVisualIn(self, champ.positionBuff())
	}
	
	method image() {
		return "algo.png"
	}
}

object gloom {	
	method physicalGains() { return 15 }
	method magicGains() { return 15 }
	method cost() { return 5 }
	
	method appear(champ) {
		game.addVisualIn(self, champ.positionBuff())
	}
	
	method remove() {
		game.removeVisual(self)
	}
	
	method image() {
		return "algo.png"
	}
}

/*object darker {
	method physicalGains() { return 23 }
	method magicGains() { return 23 }
	method cost() { return 15 }
}

object sacrifice {
	method physicalGains() { return 30 }
	method magicGains() { return 30 }
	method cost() { return 20 }
}*/
