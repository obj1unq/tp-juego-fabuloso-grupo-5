import wollok.game.*
import champions.*
import teams.*

class HPBar {
	var character 
	
	method position() {
		return if (character.team().isLight()) {character.position().left(1)}
			   else {character.position().right(2)}
	} 
	
	method image() {
		return if(character.team().isLight()) {
			   "HP-" +  (character.hpPercent() * 0.1).truncate(0).min(10).toString() + ".png" }
			   else { "HPD-" +  (character.hpPercent() * 0.1).truncate(0).min(10).toString() + ".png" }
	}
}