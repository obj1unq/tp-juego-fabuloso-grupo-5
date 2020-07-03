import wollok.game.*
import teams.*
import cursor.*
import fightingSystem.*
import hpBar.*
import buffs.*
import equipment.*


class Champion {
	
	var property position 
	const property maxHP = 1 
	var property hp = 1
	var property strength = 0
	var property wisdom = 0 
	var property alive = true
	var property weapon = equipments.sword()
	var property armor = equipments.leatherArmor()
	var property buff = noBuff 
	var property name
	var property team
	var property knowsSorcery = false
	
	//var property spells 
	//const property imageAlive
	//const property imageDead
	var property image
	
	/*
	method image() {
		if (hp.abs() > 0)
		return imageAlive
		else status = "dead"
			 return imageDead		  		 
	}
	*/
	
	method hpBar() {
		game.addVisual(new HPBar(character = self))
	}
	method totalHP() {
		return hp.toString() + "/" + maxHP.toString()
	}
	method hpPercent(){
		return (hp * 100) / maxHP
	}
	method takeDamage(damage){
		hp = (hp - damage).max(0)
	}
	method attack(type, attacked) {
	 	attacked.takeDamage(type.dmgCalculation(self, attacked))
	}
	
	method recieveSpell(spellCaster, _spell) {
		_spell.effect(self, spellCaster)
	}
}

class Sorcerer inherits Champion {
	const property spells
	var property spellSelected
	
	override method knowsSorcery() {
		return true
	}
	
	method getSpell(number) {
		spellSelected = spells.get(number)
	}
	
	method spellCast(champion) {
		champion.recieveSpell(self, spellSelected)
	}
}

object physical {
	method dmgCalculation(attacker, attacked) { 
		//operación total = daño total attacker - armadura física attacked
		return ( (attacker.strength() + attacker.buff().physicalGains() + attacker.weapon().physicalDmg()) - attacked.armor().physicalRes() )
	}
}

object magic {
	method dmgCalculation(attacker, attacked) { 
		return ( (attacker.wisdom() + attacker.buff().magicGains() + attacker.weapon().magicDmg()) - attacked.armor().magicRes() )
	}
}

object allChampions {
	
//CONFIGURACIÓN PARA SU PRIMERA SELECCIÓN
//LIGHTNESS
const property paladin = new Champion(position=game.at(10,11), image="paladin.png", team=lightness, name="paladin")
const property berserker = new Champion(position=game.at(12,11), image="berserker.png", team=lightness, name="berserker")
const property archer = new Champion(position=game.at(14,11), image="archer.png", team=lightness, name="archer")
const property mage = new Champion(position=game.at(16,11), image="mage.png", team=lightness, name="mage")
const property doomGuy = new Champion(position=game.at(18,11), image="doomGuy.png", team=lightness, name="doomGuy")
const property knight = new Champion(position=game.at(20,11), image="knight.png", team=lightness, name="knight")
//DARKNESS
const property dracula = new Champion(position=game.at(10,2), image="dracula.png", team=darkness, name="dracula")
const property darkBerserker = new Champion(position=game.at(12,2), image="darkBerserker.png", team=darkness, name="darkBerserker")
const property goblin = new Champion(position=game.at(14,2), image="goblin.png", team=darkness, name="goblin")
const property wizard = new Champion(position=game.at(16,2), image="wizard.png", team=darkness, name="wizard")
const property pinkyDemon = new Champion(position=game.at(18,2), image="pinkyDemon.png", team=darkness, name="pinkyDemon")
const property spellCaster = new Champion(position=game.at(20,2), image="spellCaster.png", team=darkness, name="spellCaster")
//TEAMS
const property lightTeam = [paladin,berserker,archer,mage,doomGuy,knight]
const property darkTeam = [dracula,darkBerserker,goblin,wizard,pinkyDemon,spellCaster]


	method battlePose(champ) {   					//TODO
		if (champ.image() == champ.name() + "1.png") {
			champ.image(champ.name() + "2.png")
		}
		else if (champ.image() == champ.name() + "2.png") {
				 champ.image(champ.name() + "3.png")
		}
		else if (champ.image() == champ.name() + "3.png") {
				 champ.image(champ.name() + "1.png")
		}
		else { game.removeTickEvent(champ.name())
			   champ.image(champ.name() + "4.png")
		}
	}
	
	
	method isFromTeam(_champ, _team) {
		return _champ.team() == _team
	}
}
