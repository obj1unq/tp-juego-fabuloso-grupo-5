import wollok.game.*
import champions.*
import teams.*

class HPBar {
	var property character 
	var property position
	
	method image() {
		return if(character.team().isLight()) {
			   "HPL-" +  (character.hpPercent() * 0.1).truncate(0).min(10).toString() + ".png" }
			   else { "HPD-" +  (character.hpPercent() * 0.1).truncate(0).min(10).toString() + ".png" }
	}
}

class HPinterface {
	
var property champ
var property y

	method image() {
		return champ.name() + "HPInterface.png"
	}	
	
	method position() {
		return if(champ.team().isLight()) { game.at(0, y) }
			   else { game.at(25, y) }
	}
	
	method showHPbar() {
		game.addVisual( new HPBar(character = champ, position = self.positionOfHPbar()) )
	}
	
	method positionOfHPbar() {
		return if(champ.team().isLight()) {game.at(self.position().x() + 2, self.position().y() + 1)}
			   else {game.at(self.position().x(), self.position().y() + 1)}
	}
	
}