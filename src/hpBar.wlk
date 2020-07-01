import wollok.game.*
import champions.*

class HPBar {
	var character 
	
	method position() {
		return character.position().left(1)
	} 
	
	method image() {
		return "HP-" +  (character.hpPercent() * 0.1).truncate(0).min(9).toString() + ".png"	
	}
}