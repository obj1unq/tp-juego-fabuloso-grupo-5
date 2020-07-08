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