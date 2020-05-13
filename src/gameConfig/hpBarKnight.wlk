import wollok.game.*
import heroes.*
import porcentaje.*
import enemies.*

object hpBarKnight {
	
var property position = knight.position().left(1)
	
	method image() {
		return
		if ( porcentaje.es100(knight.hp(), knight.maxHP()) ) {
			"HPfull.png"
		}
		else if ( porcentaje.es90(knight.hp(), knight.maxHP()) ) {
			"HP-1.png"
		}
		else if ( porcentaje.es90(knight.hp(), knight.maxHP()) ) {
			"HP-2.png"
		}
		else if ( porcentaje.es70(knight.hp(), knight.maxHP()) ) {
			"HP-3.png"
		}
		else if ( porcentaje.es60(knight.hp(), knight.maxHP()) ) {
			"HP-4.png"
		}
		else if ( porcentaje.es50(knight.hp(), knight.maxHP()) ) {
			"HP-5.png"
		}
		else if ( porcentaje.es40(knight.hp(), knight.maxHP()) ) {
			"HP-6.png"
		}
		else if ( porcentaje.es30(knight.hp(), knight.maxHP()) ) {
			"HP-7.png"
		}
		else if ( porcentaje.es20(knight.hp(), knight.maxHP()) ) {
			"HP-8.png"
		}
		else if ( porcentaje.es10(knight.hp(), knight.maxHP()) ) {
			"HP-9.png"
		}
		else { "HPempty.png" }
	}
	
}