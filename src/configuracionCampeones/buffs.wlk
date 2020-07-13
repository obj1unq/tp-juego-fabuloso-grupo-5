import wollok.game.*

class Buff {
	var property physicalGains = 30
	var property magicGains = 30
	var property cost = 50
	
	method appear(champ) {
		game.addVisualIn(self, champ.positionBuff())
	}
	
	method remove() {
		game.removeVisual(self)
	}
	
	method image()
}

object noBuff {
	const property physicalGains = 0
	const property magicGains = 0
	const property cost = 0
}

class Illumination inherits Buff {	
	override method image() {
		return "lightnessBuff.png"
	}
}

class Gloom inherits Buff {	
	override method image() {
		return "darknessBuff.png"
	}
}
