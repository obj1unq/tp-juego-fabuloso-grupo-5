import wollok.game.*
import buffs.*
import equipment.*
import spells.*
import attack.*
import spellCast.*
import fightingSystem.*

class Champion {
	
	var property position = game.origin()
	var property image  
	const property team
	var property name 
	
	var property maxHP = 0
	var property hp = maxHP
	var property strength = 0
	var property wisdom = 0
	var property status = "alive"
	var property weapon = sword
	var property armor = steelArmor 
	var property buff = noBuff
	var property knowsSorcery = false
	const property spells = []
	var property spellToUse = "null"
	
	method battlePose() {
		if (image == name + "1.png") {
			image = name + "2.png"
		}
		else if (image == name + "2.png") {
			image = name + "2.png"
		}
		else { game.removeTickEvent("dance" + name)
			   image = name + "4.png"
		}
	}
	
	method totalHP() {
		return hp.toString() + "/" + self.maxHP().toString()
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
		hp = (hp - value).max(0)
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
