import wollok.game.*
import heroes.*
import porcentaje.*
import enemies.*

object hpBarDarkWizard {
	
var property position = darkWizard.position().right(1)
	
	method image() {
		return
		if ( porcentaje.es100(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HPfull2.png"
		}
		else if ( porcentaje.es90(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-1.png"
		}
		else if ( porcentaje.es90(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-2.png"
		}
		else if ( porcentaje.es70(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-3.png"
		}
		else if ( porcentaje.es60(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-4.png"
		}
		else if ( porcentaje.es50(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-5.png"
		}
		else if ( porcentaje.es40(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-6.png"
		}
		else if ( porcentaje.es30(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-7.png"
		}
		else if ( porcentaje.es20(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-8.png"
		}
		else if ( porcentaje.es10(darkWizard.hp(), darkWizard.maxHP()) ) {
			"HP2-9.png"
		}
		else { "HP2empty.png" }
	}
	
}
