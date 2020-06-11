import wollok.game.*
import teams.*
import cursor.*
import fightingSystem.*

class Champion {
	
	var property position = game.origin()
	var property image  
	var property team = lightness
	var property name 
	
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
