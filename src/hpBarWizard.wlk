import wollok.game.*
import heroes.*
import porcentaje.*
import enemies.*

object hpBarWizard {
	
var property position = wizard.position().left(1)
	
	method image() {
		return
		if ( porcentaje.es100(wizard.hp(), wizard.maxHP()) ) {
			"HPfull.png"
		}
		else if ( porcentaje.es90(wizard.hp(), wizard.maxHP()) ) {
			"HP-1.png"
		}
		else if ( porcentaje.es90(wizard.hp(), wizard.maxHP()) ) {
			"HP-2.png"
		}
		else if ( porcentaje.es70(wizard.hp(), wizard.maxHP()) ) {
			"HP-3.png"
		}
		else if ( porcentaje.es60(wizard.hp(), wizard.maxHP()) ) {
			"HP-4.png"
		}
		else if ( porcentaje.es50(wizard.hp(), wizard.maxHP()) ) {
			"HP-5.png"
		}
		else if ( porcentaje.es40(wizard.hp(), wizard.maxHP()) ) {
			"HP-6.png"
		}
		else if ( porcentaje.es30(wizard.hp(), wizard.maxHP()) ) {
			"HP-7.png"
		}
		else if ( porcentaje.es20(wizard.hp(), wizard.maxHP()) ) {
			"HP-8.png"
		}
		else if ( porcentaje.es10(wizard.hp(), wizard.maxHP()) ) {
			"HP-9.png"
		}
		else { "HPempty.png" }
	}
	
}
