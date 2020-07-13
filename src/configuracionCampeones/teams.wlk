import wollok.game.*
import configuracionGeneral.starting.*
import champions.*
import configuracionCampeones.hpBar.*


class Team {
var property position
var property image
var property champions=[]
var property characters=[]
var property name
var property isLight
var property champ1
var property champ2
var property champ3

	method leader()
	method nextTeam()
	method addChampion(champ) { champions.add(champ)
								characters.add(champ)
								self.nextTeam().characters().add(champ)}
	method fullTeam() {return champions.size() == 3}
	method configForBattle() { if(self.fullTeam()) { champions.forEach({champion=>champion.image(champion.name() + "1.png")})
													 champions.forEach({champion=>game.addVisual(champion)})
													 self.showHPbars()
													 champions.forEach({champion=>})
													 game.onTick(150, champ1.name(), {champ1.battlePose()})
													 game.onTick(150, champ2.name(), {champ2.battlePose()})
													 game.onTick(150, champ3.name(), {champ3.battlePose()}) 
													 }
	}
	
	method listAfterSelection() {
		return champions + self.nextTeam().champions()
	}
	
	method isFromTeam(objective) {
		 return champions.contains(objective)
	}	
	
	method showHPbars() {
		const hp1 = new HPinterface(champ = champ1, y=9)
		champ1.yCoordinateForAttack(9)
		const hp2 = new HPinterface(champ = champ2, y=5)
		champ2.yCoordinateForAttack(5)
		const hp3 = new HPinterface(champ = champ3, y=1)
		champ3.yCoordinateForAttack(1)
		game.addVisual (hp1)
		game.addVisual (hp2)
		game.addVisual (hp3)
		hp1.showHPbar()
		hp2.showHPbar()
		hp3.showHPbar()
	}	
	
	method kill(objective) {
		champions.remove(objective)
		characters.remove(objective)
		self.nextTeam().champions().remove(objective)
		self.nextTeam().characters().remove(objective)
	}	
	
	method isDefeated() {
		return champions.isEmpty()
	}	
	
	method clear() {
		//champ1.reset()
		//champ2.reset()
		//champ3.reset()
		champions = []
		characters = []
	}			 
}


object lightness inherits Team(position=game.at(2,6), image="light.png", name="lightness", isLight=true) {
	const property bannerPosition = game.at(0,14) 
	
	override method configForBattle() {
		champions.get(0).position(game.at(13,5))
		champions.get(1).position(game.at(12,3))
		champions.get(2).position(game.at(13,1))
		super()
	}

	override method nextTeam() {
		return darkness
	}
	
	override method leader() {
		return championsToSelect.paladin()
	}
}


object darkness inherits Team(position=game.at(24,6), image="dark.png", name="darkness", isLight=false) {
	const property bannerPosition = game.at(28,14)
	
	override method configForBattle() {
		champions.get(0).position(game.at(15,5))
		champions.get(1).position(game.at(16,3))
		champions.get(2).position(game.at(15,1))
		super()
	}

	override method nextTeam() {
		return lightness
	}
	
	override method leader() {
		return championsToSelect.dracula()
	}
													
}

