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
	var property tip = ""
	
}



class Champion inherits ChampionSelect {
	
	var property maxHP = 1 
	var property hp = 1
	var property strength = 0
	var property wisdom = 1
	var property alive = true
	var property weapon = equipments.sword()
	var property armor = equipments.leatherArmor()
	var property buff = noBuff
	var property knowsSorcery = false
	var property yCoordinateForAttack = 0
	
	method deleteBuffs() {
		if(self.isBuffed()) {
			game.removeVisual(buff)
			buff = noBuff
		}
	}
	
	method isBuffed() {
		return buff != noBuff
	}
	
	method positionBuff() {
		return if (team.isLight()) {
			position.left(1)
		} else {
			position.right(2)
		}
	}
	
	method isAlive() {
		return hp > 0
	}
	
	method die() {
		image = name + "4.png"
		alive = false
	}
	
	method sayPhysicalDmg() {
		game.say(self, "Mi daño físico es " + self.totalPhysicalDmg().toString())
	}
	
	method totalPhysicalDmg() {
		return weapon.physicalDmg() + buff.physicalGains() + strength
	}
	
	method sayMagicDmg() {
		game.say(self, "Mi daño mágico es " + self.totalMagicDmg().toString())
	}
	
	method totalMagicDmg() {
		return weapon.magicDmg() + buff.magicGains() + wisdom
	}
	
	method sayWisdom() {
		game.say(self, "Mi sabiduría es de " + wisdom)
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
	 	invigoratingWave.removeVisual()
	 	hp -= buff.cost()
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
		alive = true
		buff = noBuff
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
	
	method canBuff(objective, num) {
		return 
			(not objective.isBuffed()) &&
			num == 2
	}
}

object physical {
	method dmgCalculation(attacker, attacked) { 
		return (attacker.totalPhysicalDmg() - attacked.armor().physicalRes()).max(0)
	}
}

object magic {
	method dmgCalculation(attacker, attacked) { 
		return (attacker.totalMagicDmg() - attacked.armor().magicRes()).max(0)
	}
}


object championsToSelect {
	
//LIGHTNESS
const property paladin = new ChampionSelect(position=game.at(10,11), image="paladin.png", team=lightness, name="paladin", tip="Último suspiro debería usarse al final...")
const property berserker = new ChampionSelect(position=game.at(12,11), image="berserker.png", team=lightness, name="berserker", tip="Sólo es un tipo duro.")
const property archer = new ChampionSelect(position=game.at(14,11), image="archer.png", team=lightness, name="archer", tip="Último suspiro debería usarse al final...")
const property mage = new ChampionSelect(position=game.at(16,11), image="mage.png", team=lightness, name="mage", tip="La onda destructiva divide tu sabiduría por 4, ¡cuidado!")
const property doomGuy = new ChampionSelect(position=game.at(18,11), image="doomGuy.png", team=lightness, name="doomGuy", tip="Otro tipo duro.")
const property knight = new ChampionSelect(position=game.at(20,11), image="knight.png", team=lightness, name="knight", tip="Tal vez sea el campeón perfecto... o tal vez el peor.")
//DARKNESS
const property dracula = new ChampionSelect(position=game.at(10,2), image="dracula.png", team=darkness, name="dracula", tip="Solo chupo sangre...")
const property darkBerserker = new ChampionSelect(position=game.at(12,2), image="darkBerserker.png", team=darkness, name="darkBerserker", tip="Sólo un pobre vikingo corrompido...")
const property goblin = new ChampionSelect(position=game.at(14,2), image="goblin.png", team=darkness, name="goblin", tip="gungigingan")
const property wizard = new ChampionSelect(position=game.at(16,2), image="wizard.png", team=darkness, name="wizard", tip="La onda destructiva divide tu sabiduría por 4, ¡cuidado!")
const property pinkyDemon = new ChampionSelect(position=game.at(18,2), image="pinkyDemon.png", team=darkness, name="pinkyDemon", tip="Sólo un demonio duro.")
const property spellCaster = new ChampionSelect(position=game.at(20,2), image="spellCaster.png", team=darkness, name="spellCaster", tip="Tal vez sea el hechicero perfecto... o tal vez el peor.")
//TEAMS
var property lightTeam = [paladin,berserker,archer,mage,doomGuy,knight]
const property lightTeamImmutable = [paladin,berserker,archer,mage,doomGuy,knight]
var property darkTeam = [dracula,darkBerserker,goblin,wizard,pinkyDemon,spellCaster]
const property darkTeamImmutable = [dracula,darkBerserker,goblin,wizard,pinkyDemon,spellCaster]

	method clear() {
		lightTeamImmutable.forEach({champ=>champ.image(champ.name() + ".png")})
		self.lightListReseted()
		darkTeamImmutable.forEach({champ=>champ.image(champ.name() + ".png")})
		self.darkListReseted()
	}
	
	method addVisuals() {
		lightTeam.forEach({champ=>game.addVisual(champ)})
		darkTeam.forEach({champ=>game.addVisual(champ)})
	}
	
	method lightListReseted() {
		lightTeam = []
		lightTeamImmutable.forEach({champ=>lightTeam.add(champ)})
	}
	
	method darkListReseted() {
		darkTeam = []
		darkTeamImmutable.forEach({champ=>darkTeam.add(champ)})
	}
	
}



object championsInBattle {

//CONFIGURACIÓN PARA SU PRIMERA SELECCIÓN
const spellCasterHP = 50.randomUpTo(250).truncate(0)
const knightHP = 50.randomUpTo(200).truncate(0)
//LIGHTNESS
const property paladin = new Sorcerer(position=game.at(10,11), image="paladin1.png", team=lightness, name="paladin", maxHP=250, hp=250, strength=25, wisdom=12, weapon=equipments.sword(),
									  armor=equipments.silverArmor(), spells=[lastBreath], spellSelected=lastBreath)

const property berserker = new Champion(position=game.at(10,11), image="berserker1.png", team=lightness, name="berserker", maxHP=300, hp=300, strength=32, wisdom=0, weapon=equipments.axe(),
									    armor=equipments.leatherArmor())

const property archer = new Sorcerer(position=game.at(10,11), image="archer1.png", team=lightness, name="archer", maxHP=100, hp=100, strength=22, wisdom=15, weapon=equipments.bow(),
									    armor=equipments.leatherArmor(), spells=[lastBreath], spellSelected=lastBreath)

const property mage = new Sorcerer(position=game.at(10,11), image="mage1.png", team=lightness, name="mage", maxHP=75, hp=75, strength=10, wisdom=30, weapon=equipments.wand(),
									    armor=equipments.magicArmor(), spells=[destructiveWave, healingWave, invigoratingWave], spellSelected=destructiveWave)

const property doomGuy = new Champion(position=game.at(10,11), image="doomGuy1.png", team=lightness, name="doomGuy", maxHP=200, hp=200, strength=28, wisdom=0, weapon=equipments.rifle(),
									     armor=equipments.steelArmor())

const property knight = new Champion(position=game.at(10,11), image="knight1.png", team=lightness, name="knight", maxHP=knightHP, hp=knightHP, strength=5.randomUpTo(50).truncate(0), wisdom=0, weapon=equipments.weapons().anyOne(),
									     armor=equipments.armors().anyOne())

//DARKNESS
const property dracula = new Sorcerer(position=game.at(10,11), image="dracula1.png", team=darkness, name="dracula", maxHP=250, hp=250, strength=25, wisdom=20, weapon=equipments.sword(),
									  armor=equipments.goldArmor(), spells=[destructiveWave, healingWave, invigoratingWave], spellSelected=destructiveWave)

const property darkBerserker = new Champion(position=game.at(10,11), image="darkBerserker1.png", team=darkness, name="darkBerserker", maxHP=300, hp=300, strength=30, wisdom=0, weapon=equipments.axe(),
									  armor=equipments.leatherArmor())

const property goblin = new Sorcerer(position=game.at(10,11), image="goblin1.png", team=darkness, name="goblin", maxHP=75, hp=75, strength=18, wisdom=15, weapon=equipments.sword(),
									  armor=equipments.leatherArmor(), spells=[lastBreath], spellSelected=lastBreath)

const property wizard = new Sorcerer(position=game.at(10,11), image="wizard1.png", team=darkness, name="wizard", maxHP=100, hp=100, strength=10, wisdom=30, weapon=equipments.wand(),
									  armor=equipments.magicArmor(), spells=[destructiveWave, healingWave, invigoratingWave], spellSelected=destructiveWave)

const property pinkyDemon = new Champion(position=game.at(10,11), image="pinkyDemon1.png", team=darkness, name="pinkyDemon", maxHP=150, hp=150, strength=30, wisdom=0, weapon=equipments.sword(),
									  armor=equipments.leatherArmor())

const property spellCaster = new Sorcerer(position=game.at(10,11), image="spellCaster1.png", team=darkness, name="spellCaster", maxHP=spellCasterHP, hp=spellCasterHP, strength=5.randomUpTo(50).truncate(0), wisdom=5.randomUpTo(50).truncate(0), weapon=equipments.weapons().anyOne(),
									  	  armor=equipments.armors().anyOne(), spells=[destructiveWave, healingWave, invigoratingWave], spellSelected=destructiveWave)

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
//es