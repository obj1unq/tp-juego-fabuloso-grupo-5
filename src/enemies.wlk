import wollok.game.*
import equipment.*
import heroes.*
import attack.*
import spells.*
import spellCast.*
import teams.*
import buffs.*
import hpBarOgre.*
import hpBarDarkWizard.*


object ogre {

var property position = game.at(15,7)
	
const property maxHP = (-25).randomUpTo(-70).truncate(0)
var property hp = maxHP
var property strength = 6
var property wisdom = 1
var property status = "alive"
var property weapon = axe
var property armor = leatherArmor 
var property buff = noBuff
var property positionImg = "ogre1.png"
const property team = darkDefenders
const property knowsSorcery = false

	method hpBar() {
		game.addVisual(hpBarOgre)
	}
	
	method image() {
		if (hp < 0)
			return "ogre1.png"
			else status = "dead"
			return "ogre4.png"
			}
	
	//Stats
	method maxHP() {
		return maxHP.abs()
	}
	method hp() {
		return hp.abs()
	}
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHP().toString()
	}
	//Stats
	
	method physicalAttackTo(objective) {
		physicalAttack.attacker(self)
		physicalAttack.attacked(objective)
		physicalAttack.executePhysicalAttack()
	}
	
	method magicAttackTo(objective) {
		magicAttack.attacker(self)
		magicAttack.attacked(objective)
		magicAttack.executeMagicAttack()
	}
	
	method takeDamage(value) {
		hp = (hp + value).min(0)
	}
	
	method receiveSpell(_spell) {
		spellCast.attacked(self)
		_spell.effect(spellCast.attacker(), self)
	}
}


object darkWizard {
	
	var property position = game.at(16,6)
	
	const property maxHP = (-15).randomUpTo(-25).truncate(0)
	var property hp = maxHP
	var property strength = 1
	var property wisdom = 5
	var property status = "alive"
	var property weapon = magicBow
	var property armor = leatherArmor 
	var property buff = noBuff
	const property spells = [destructiveDarkWave, healingDarkWave, invigoratingDarkWave]
	var property positionImg = "darkWizard1.png"
	var property spellToUse = null
	const property team = darkDefenders
	const property knowsSorcery = true

	method hpBar() {
		game.addVisual(hpBarDarkWizard)
	}

	method image() {
		if (hp < 0)
			return "darkWizard1.png"
			else status = "dead"
			return "darkWizard4.png"
			}
	
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHP().toString()
	}
	
	method physicalAttackTo(objective) {
		physicalAttack.attacker(self)
		physicalAttack.attacked(objective)
		physicalAttack.executePhysicalAttack()
	}
	
	method magicAttackTo(objective) {
		magicAttack.attacker(self)
		magicAttack.attacked(objective)
		magicAttack.executeMagicAttack()
	}
	
	method takeDamage(value) {
		hp = (hp + value).min(0)
	}
	
	method receiveSpell(_spell) {
		spellCast.attacked(self)
		_spell.effect(spellCast.attacker(), self)
	}
	
	method firstSpell() {
		spellToUse = spells.get(0)
	}
	
	method secondSpell() {
		spellToUse = spells.get(1)
	}
	
	method thirdSpell() {
		spellToUse = spells.get(2)
	}
	
	method castSpell(objective) {
		spellCast.attacker(self)
		spellCast.attacked(objective)
		spellCast.executeSpell()
	}
	
}