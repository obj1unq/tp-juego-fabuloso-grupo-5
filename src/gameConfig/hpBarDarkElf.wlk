import wollok.game.*
import heroes.*
import porcentaje.*
import enemies.*

object hpBarDarkElf {
	
var property position = darkElf.position().right(1)
	
	method image() {
		return
		if ( porcentaje.es100(darkElf.hp(), darkElf.maxHP()) ) {
			"HPfull2.png"
		}
		else if ( porcentaje.es90(darkElf.hp(), darkElf.maxHP()) ) {
			"HP2-1.png"
		}
		else if ( porcentaje.es90(darkElf.hp(), darkElf.maxHP()) ) {
			"HP2-2.png"
		}
		else if ( porcentaje.es70(darkElf.hp(), darkElf.maxHP()) ) {
			"HP2-3.png"
		}
		else if ( porcentaje.es60(darkElf.hp(), darkElf.maxHP()) ) {
			"HP2-4.png"
		}
		else if ( porcentaje.es50(darkElf.hp(), darkElf.maxHP()) ) {
			"HP2-5.png"
		}
		else if ( porcentaje.es40(darkElf.hp(), darkElf.maxHP()) ) {
			"HP2-6.png"
		}
		else if ( porcentaje.es30(darkElf.hp(), darkElf.maxHP()) ) {
			"HP2-7.png"
		}
		else if ( porcentaje.es20(darkElf.hp(), darkElf.maxHP()) ) {
			"HP2-8.png"
		}
		else if ( porcentaje.es10(ogre.hp(), ogre.maxHP()) ) {
			"HP2-9.png"
		}
		else { "HP2empty.png" }
	}
	
}
