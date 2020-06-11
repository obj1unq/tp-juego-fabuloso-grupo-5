import wollok.game.*
import heroes.*
import porcentaje.*
import enemies.*

object hpBarOgre {
	
var property position = ogre.position().right(1)
	
	method image() {
		return
		if ( porcentaje.es100(ogre.hp(), ogre.maxHP()) ) {
			"HPfull2.png"
		}
		else if ( porcentaje.es90(ogre.hp(), ogre.maxHP()) ) {
			"HP2-1.png"
		}
		else if ( porcentaje.es90(ogre.hp(), ogre.maxHP()) ) {
			"HP2-2.png"
		}
		else if ( porcentaje.es70(ogre.hp(), ogre.maxHP()) ) {
			"HP2-3.png"
		}
		else if ( porcentaje.es60(ogre.hp(), ogre.maxHP()) ) {
			"HP2-4.png"
		}
		else if ( porcentaje.es50(ogre.hp(), ogre.maxHP()) ) {
			"HP2-5.png"
		}
		else if ( porcentaje.es40(ogre.hp(), ogre.maxHP()) ) {
			"HP2-6.png"
		}
		else if ( porcentaje.es30(ogre.hp(), ogre.maxHP()) ) {
			"HP2-7.png"
		}
		else if ( porcentaje.es20(ogre.hp(), ogre.maxHP()) ) {
			"HP2-8.png"
		}
		else if ( porcentaje.es10(ogre.hp(), ogre.maxHP()) ) {
			"HP2-9.png"
		}
		else { "HP2empty.png" }
	}
	
}
