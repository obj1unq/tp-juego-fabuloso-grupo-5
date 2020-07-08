import wollok.game.*
import hpBar.*
import teams.*
import champions.*

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
