import wollok.game.*
import starting.*
import players2.*
import teams2.*
import champions.*

object battle {
	
var property image = "arena.png"
var property position = game.origin()	
	
	method start() {
		game.clear()
		game.addVisual(self)
		self.setChampionsVisuals()
		self.addChampions()
		self.battlePoses()
	}
	
	method addChampions() {
		lightness.champions().get(0).position(game.at(11,5))
		lightness.champions().get(1).position(game.at(10,3))
		lightness.champions().get(2).position(game.at(11,1))
		lightness.champions().forEach({ champion => game.addVisual(champion) })
		darkness.champions().get(0).position(game.at(16,5))
		darkness.champions().get(1).position(game.at(17,3))
		darkness.champions().get(2).position(game.at(16,1))
		darkness.champions().forEach({ champion => game.addVisual(champion) })
	}
	
	method setChampionsVisuals() {
		lightness.champions().forEach({ champion => champion.image(champion.name() + "1.png") })
		darkness.champions().forEach({ champion => champion.image(champion.name() + "1.png") })
	}
	
	 
	method battlePoses() {
		game.onTick(500, "completePoses", {
		 lightness.champions().forEach({ champion => game.onTick((200..500).anyOne(), "dance" + champion.name(), {self.pose(champion)}) })
		 darkness.champions().forEach({ champion => game.onTick((200..500).anyOne(), "dance" + champion.name(), {self.pose(champion)}) }) })
	}
	
	
	method pose(champion) {
		if (champion.image() == champion.name() + "1.png") {
			champion.image(champion.name() + "2.png")
		}
		else if (champion.image() == champion.name() + "2.png") {
			champion.image(champion.name() + "2.png")
		}
		else { game.removeTickEvent("dance" + champion.name())
			   image = champion.name() + "4.png"
		}
	}
	
	
}
