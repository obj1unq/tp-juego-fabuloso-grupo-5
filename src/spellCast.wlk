import heroes.*
import enemies.*
import equipment.*
import spells.*

object spellCast {
	
var property attacker = null
var property attacked = null

	method executeSpell() {
		attacked.receiveSpell(attacker.spellToUse())
	}	
	
	
}