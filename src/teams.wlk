import wollok.game.*
import starting.*
import champions.*


class Team {
var property position
var property image
var property champions=[]
var property characters=[]
var property name
var property isLight

	method leader()
	method nextTeam()
	method addChampion(champ) { champions.add(champ)
								characters.add(champ)
								self.nextTeam().characters().add(champ)}
	method fullTeam() {return champions.size() == 3}
	method configForBattle() { if(self.fullTeam()) { champions.forEach({champion=>champion.image(champion.name() + "1.png")})
													 champions.forEach({champion=>game.addVisual(champion)})
													 champions.forEach({champion=>champion.hpBar()})
													 game.onTick(150, champions.get(0).name(), {allChampions.battlePose(champions.get(0))})
													 game.onTick(150, champions.get(1).name(), {allChampions.battlePose(champions.get(1))})
													 game.onTick(150, champions.get(2).name(), {allChampions.battlePose(champions.get(2))}) } 
													 }
	method listAfterSelection() {
		return champions + self.nextTeam().champions()
	}
	
	method isFromTeam(objective) {
		 return champions.contains(objective)
	}								 
}


object lightness inherits Team(position=game.at(2,6), image="light.png", name="lightness", isLight=true) {

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
		return allChampions.paladin()
	}
}


object darkness inherits Team(position=game.at(24,6), image="dark.png", name="darkness", isLight=false) {

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
		return allChampions.dracula()
	}
													
}

