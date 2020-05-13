import heroes.*
import porcentaje.*
import enemies.*

object hpBarAlly {
	
var property pj = knight
var property position = pj.position().left(1)
	
	method image() {
		return
		if ( porcentaje.es100(pj.hp(), pj.maxHP()) ) {
			"HPfull.png"
		}
		else if ( porcentaje.es90(pj.hp(), pj.maxHP()) ) {
			"HP-1.png"
		}
		else if ( porcentaje.es90(pj.hp(), pj.maxHP()) ) {
			"HP-2.png"
		}
		else if ( porcentaje.es70(pj.hp(), pj.maxHP()) ) {
			"HP-3.png"
		}
		else if ( porcentaje.es60(pj.hp(), pj.maxHP()) ) {
			"HP-4.png"
		}
		else if ( porcentaje.es50(pj.hp(), pj.maxHP()) ) {
			"HP-5.png"
		}
		else if ( porcentaje.es40(pj.hp(), pj.maxHP()) ) {
			"HP-6.png"
		}
		else if ( porcentaje.es30(pj.hp(), pj.maxHP()) ) {
			"HP-7.png"
		}
		else if ( porcentaje.es20(pj.hp(), pj.maxHP()) ) {
			"HP-8.png"
		}
		else if ( porcentaje.es10(pj.hp(), pj.maxHP()) ) {
			"HP-9.png"
		}
		else { "HPempty.png" }
	}
	
}


object hpBarEnemy {
	
var property pj = ogre
var property position = pj.position().right(1)

	method image() {
		return
		if ( porcentaje.es100(pj.hp(), pj.maxHP()) ) {
			"HPfull2.png"
		}
		else if ( porcentaje.es90(pj.hp(), pj.maxHP()) ) {
			"HP2-1.png"
		}
		else if ( porcentaje.es90(pj.hp(), pj.maxHP()) ) {
			"HP2-2.png"
		}
		else if ( porcentaje.es70(pj.hp(), pj.maxHP()) ) {
			"HP2-3.png"
		}
		else if ( porcentaje.es60(pj.hp(), pj.maxHP()) ) {
			"HP2-4.png"
		}
		else if ( porcentaje.es50(pj.hp(), pj.maxHP()) ) {
			"HP2-5.png"
		}
		else if ( porcentaje.es40(pj.hp(), pj.maxHP()) ) {
			"HP2-6.png"
		}
		else if ( porcentaje.es30(pj.hp(), pj.maxHP()) ) {
			"HP2-7.png"
		}
		else if ( porcentaje.es20(pj.hp(), pj.maxHP()) ) {
			"HP2-8.png"
		}
		else if ( porcentaje.es10(pj.hp(), pj.maxHP()) ) {
			"HP2-9.png"
		}
		else { "HP2empty.png" }
		}
	
}