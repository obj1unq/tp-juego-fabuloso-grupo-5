import wollok.game.*
import teams.*
import configuracionGeneral.cursor.*
import configuracionGeneral.fightingSystem.*
import hpBar.*
import buffs.*
import equipment.*
import spells.*


class ChampionSelect {
	
	var property position 
	const property name
	const property team
	var property image 
	
}



class Champion inherits ChampionSelect {
	
	//var property position 
	var property maxHP = 1 
	var property hp = 1
	var property strength = 0
	var property wisdom = 1
	var property alive = true
	var property weapon = equipments.sword()
	var property armor = equipments.leatherArmor()
	var property buff = noBuff 
	//var property name
	//var property team
	var property knowsSorcery = false
	var property yCoordinateForAttack = 0
	//var property image
	
	method isAlive() {
		return hp > 0
	}
	
	method die() {
		image = name + "4.png"
		alive = false
	}
	
	method sayHP() {
		game.say(self, "Mi vida es " + self.totalHP())
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
		_spell.effect(spellCaster, self)
	}
	
	method setAfterAttack() {
		image = name + "1.png"
		game.onTick(150, name, {self.battlePose()})
	}
	
	method battlePose() {
		if (self.hasImage(1)) {
			image = name + "2.png"
		}
		else if (self.hasImage(2)) {
				 image = name + "3.png"
		}
		else if (self.hasImage(3)) {
				 image = name + "1.png"
		}
		else { game.removeTickEvent(name)
			   image = name + "4.png"
		}
	}
	
	method hasImage(num) {
		return image == name + num + ".png"
	}
	
	method isOfSameTeam(champ) {
		return team.name() == champ.team().name()
	}
	
	method reset() {
		hp = maxHP
		image = name + "1.png"
	}
}

class Sorcerer inherits Champion {
	const property spells = [destructiveWave, healingWave, invigoratingWave]
	var property spellSelected = destructiveWave
	
	override method knowsSorcery() {
		return true
	}
	
	method getSpell(number) {
		spellSelected = spells.get(number)
	}
	
	method spellCast(champion) {
		champion.recieveSpell(self, spellSelected)
	}
	
	method hasMoreSpells(num) {
		return num <= spells.size()
	}
	
	method validateSpell(objective) {
		spellSelected.validate(self, objective)
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


object championsToSelect {
	
//LIGHTNESS
const property paladin = new ChampionSelect(position=game.at(10,11), image="paladin.png", team=lightness, name="paladin")
const property berserker = new ChampionSelect(position=game.at(12,11), image="berserker.png", team=lightness, name="berserker")
const property archer = new ChampionSelect(position=game.at(14,11), image="archer.png", team=lightness, name="archer")
const property mage = new ChampionSelect(position=game.at(16,11), image="mage.png", team=lightness, name="mage")
const property doomGuy = new ChampionSelect(position=game.at(18,11), image="doomGuy.png", team=lightness, name="doomGuy")
const property knight = new ChampionSelect(position=game.at(20,11), image="knight.png", team=lightness, name="knight")
//DARKNESS
const property dracula = new ChampionSelect(position=game.at(10,2), image="dracula.png", team=darkness, name="dracula")
const property darkBerserker = new ChampionSelect(position=game.at(12,2), image="darkBerserker.png", team=darkness, name="darkBerserker")
const property goblin = new ChampionSelect(position=game.at(14,2), image="goblin.png", team=darkness, name="goblin")
const property wizard = new ChampionSelect(position=game.at(16,2), image="wizard.png", team=darkness, name="wizard")
const property pinkyDemon = new ChampionSelect(position=game.at(18,2), image="pinkyDemon.png", team=darkness, name="pinkyDemon")
const property spellCaster = new ChampionSelect(position=game.at(20,2), image="spellCaster.png", team=darkness, name="spellCaster")
//TEAMS
var property lightTeam = [paladin,berserker,archer,mage,doomGuy,knight]
var property lightTeamImmutable = [paladin,berserker,archer,mage,doomGuy,knight]
var property darkTeam = [dracula,darkBerserker,goblin,wizard,pinkyDemon,spellCaster]
var property darkTeamImmutable = [dracula,darkBerserker,goblin,wizard,pinkyDemon,spellCaster]

	method clear() {
		lightTeamImmutable.forEach({champ=>champ.image(champ.name() + ".png")})
		lightTeam = lightTeamImmutable
		darkTeamImmutable.forEach({champ=>champ.image(champ.name() + ".png")})
		darkTeam  = darkTeamImmutable
	}
	
	method addVisuals() {
		lightTeam.forEach({champ=>game.addVisual(champ)})
		darkTeam.forEach({champ=>game.addVisual(champ)})
	}
	
}



object championsInBattle {
	
//CONFIGURACIÓN PARA SU PRIMERA SELECCIÓN
//LIGHTNESS
const property paladin = new Sorcerer(position=game.at(10,11), image="paladin1.png", team=lightness, name="paladin", maxHP=1, hp=1, strength=25, wisdom=12, weapon=equipments.sword(),
									  armor=equipments.steelArmor(), spells=[lastBreath], spellSelected=lastBreath)

const property berserker = new Champion(position=game.at(10,11), image="berserker1.png", team=lightness, name="berserker", maxHP=1, hp=1, strength=32, wisdom=0, weapon=equipments.axe(),
									    armor=equipments.leatherArmor())

const property archer = new Sorcerer(position=game.at(10,11), image="archer1.png", team=lightness, name="archer", maxHP=1, hp=1, strength=22, wisdom=15, weapon=equipments.bow(),
									    armor=equipments.leatherArmor(), spells=[lastBreath], spellSelected=lastBreath)

const property mage = new Sorcerer(position=game.at(10,11), image="mage1.png", team=lightness, name="mage", maxHP=1, hp=1, strength=10, wisdom=30, weapon=equipments.wand(),
									    armor=equipments.leatherArmor(), spells=[destructiveWave, healingWave, invigoratingWave], spellSelected=destructiveWave)

const property doomGuy = new Champion(position=game.at(10,11), image="doomGuy1.png", team=lightness, name="doomGuy", maxHP=1, hp=1, strength=28, wisdom=0, weapon=equipments.sword(),
									     armor=equipments.leatherArmor())

const property knight = new Champion(position=game.at(10,11), image="knight1.png", team=lightness, name="knight", maxHP=1, hp=1, strength=25, wisdom=0, weapon=equipments.sword(),
									     armor=equipments.leatherArmor())

//DARKNESS
const property dracula = new Sorcerer(position=game.at(10,11), image="dracula1.png", team=darkness, name="dracula", maxHP=1, hp=1, strength=25, wisdom=12, weapon=equipments.sword(),
									  armor=equipments.steelArmor(), spells=[lastBreath], spellSelected=lastBreath)

const property darkBerserker = new Champion(position=game.at(10,11), image="darkBerserker1.png", team=darkness, name="darkBerserker", maxHP=1, hp=1, strength=30, wisdom=0, weapon=equipments.axe(),
									  armor=equipments.leatherArmor())

const property goblin = new Sorcerer(position=game.at(10,11), image="goblin1.png", team=darkness, name="goblin", maxHP=1, hp=1, strength=18, wisdom=15, weapon=equipments.sword(),
									  armor=equipments.leatherArmor(), spells=[lastBreath], spellSelected=lastBreath)

const property wizard = new Sorcerer(position=game.at(10,11), image="wizard1.png", team=darkness, name="wizard", maxHP=1, hp=1, strength=10, wisdom=30, weapon=equipments.wand(),
									  armor=equipments.leatherArmor(), spells=[destructiveWave, healingWave, invigoratingWave], spellSelected=destructiveWave)

const property pinkyDemon = new Champion(position=game.at(10,11), image="pinkyDemon1.png", team=darkness, name="pinkyDemon", maxHP=1, hp=1, strength=30, wisdom=0, weapon=equipments.sword(),
									  armor=equipments.leatherArmor())

const property spellCaster = new Sorcerer(position=game.at(10,11), image="spellCaster1.png", team=darkness, name="spellCaster", maxHP=1, hp=1, strength=30, wisdom=0, weapon=equipments.sword(),
									  	  armor=equipments.leatherArmor(), spells=[destructiveWave, healingWave, invigoratingWave], spellSelected=destructiveWave)

//TEAMS
const property lightTeam = [paladin,berserker,archer,mage,doomGuy,knight]
const property darkTeam = [dracula,darkBerserker,goblin,wizard,pinkyDemon,spellCaster]
	
	
	method isFromTeam(_champ, _team) {
		return _champ.team() == _team
	}
	
	method find(_champ, _team) {
		return
		if(_team.isLight()) {
			lightTeam.find({champ=>champ.name() == _champ.name()})
		}
		else { darkTeam.find({champ=>champ.name() == _champ.name()}) }
	}
	
	method reset() {
		lightTeam.forEach({champ=>champ.reset()})
		darkTeam.forEach({champ=>champ.reset()})
	}
}
