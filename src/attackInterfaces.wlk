import wollok.game.*
import teams.*
import fightingSystem.*

object attackSystem {
	
	method position() {
		return
		if (lightDefenders.isFromTeam(warSystem.selectedAttacker())) {
 			warSystem.selectedAttacker().position().left(5).down(1)}
 		else { warSystem.selectedAttacker().position().right(2).down(1) }
  }
	
	method image() {
		return if (warSystem.selectedAttacker().knowsSorcery() && lightDefenders.isFromTeam(warSystem.selectedAttacker())) {
		"lightSpells2.png" //mago
		}
		else if ( warSystem.selectedAttacker().knowsSorcery() && darkDefenders.isFromTeam(warSystem.selectedAttacker())) { "darkSpells2.png" } //mago oscuro
		else { "attackSystemNoSorcery.png" } //caballero y ogro 
		}
	
}