import wollok.game.*
import teams.*
import cursor.*
import fightingSystem.*
import hpBar.*
import buffs.*

class Champion {
	
	var property position 
	const maxHP 
	var hp 
	var property strength 
	var property wisdom 
	var property status = "alive" //pasar a objeto
	var property weapon 
	var property armor 
	var property buff = noBuff 
	var property spell 
	const property imageAlive
	const property imageDead
	
	method image() {
		if (hp.abs() > 0)
		return imageAlive
		else status = "dead"
			 return imageDead		  		 
	}
	method hp(){
		return hp.abs()
	}
	method maxHP(){
		return maxHP.abs()
	}
	method hpBar() {
		game.addVisual(new HPBar(character = self))
	}
	method totalHP() {
		return self.hp().toString() + "/" + self.maxHP().toString()
	}
	method hpPercent(){
		return (self.hp() * 100) / self.maxHP()
	}
	method takeDamage(type, damage){
		hp = (hp - damage - type.defense(self)).max(0) 
	}
	method attack(type, attacked) {
	 	attacked.takeDamage(type, type.dmgCalculation(self, attacked))
	}
	
	method spellCast(_spell, champion) {
		champion.recieveSpell(self, _spell)
	}
	
	method recieveSpell(spellCaster, _spell) {
		_spell.effect(self, spellCaster)
	}
}

object physical {
	method dmgCalculation(attacker, attacked) { 
		//operación total = daño total attacker - armadura física attacked
	}
}

object magic {
	method dmgCalculation(attacker, attacked) {  }
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


	method battlePose(champ) {
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
