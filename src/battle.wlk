import wollok.game.*
import starting.*
import players2.*
import teams2.*
import champions.*
import fightingSystem.*
import cursor.*
import attributes.*

object battle {
	
var property image = "arena.png"
var property position = game.origin()
	
	method start() {
		game.clear()
		game.addVisual(self)
		attributes.setAll()
		game.addVisual(cursor)
		lightness.selectedChar(lightness.champions().first())
		darkness.selectedChar(darkness.champions().first())
		self.addChampions()
		game.onTick(400, "lightMoves", lightness.champions().forEach({champion => champion.battlePose()}))
		game.onTick(300, "darkMoves", darkness.champions().forEach({champion => champion.battlePose()}))
		self.selectFirstChamp()
		keyboard.down().onPressDo({ warSystem.teamTurn().nextChamp() })
		keyboard.up().onPressDo({ warSystem.teamTurn().previousChamp() })
		keyboard.s().onPressDo({ warSystem.selectChar() })
		keyboard.z().onPressDo( { warSystem.executeTurnPhysical() })
		keyboard.x().onPressDo( { warSystem.executeTurnMagic() })
		keyboard.num1().onPressDo { warSystem.selectedAttacker().firstSpell()
									warSystem.executeSpellCast()
		}
		keyboard.num2().onPressDo { warSystem.selectedAttacker().secondSpell()
									warSystem.executeSpellCast()
		}
		keyboard.num3().onPressDo { warSystem.selectedAttacker().thirdSpell()
									warSystem.executeSpellCast()
		}
	}
	
	method addChampions() {
		lightness.champions().get(0).position(game.at(11,5))
		lightness.champions().get(1).position(game.at(11,3))
		lightness.champions().get(2).position(game.at(11,1))
		lightness.champions().forEach({ champion => game.addVisual(champion) })
		darkness.champions().get(0).position(game.at(16,5))
		darkness.champions().get(1).position(game.at(16,3))
		darkness.champions().get(2).position(game.at(16,1))
		darkness.champions().forEach({ champion => game.addVisual(champion) })
	}
	
	method selectFirstChamp() {
		   warSystem.selectedAttacker(teamSelector.winnerPlayer().team().champions().first())
	}
	
	 
	 /* 
	method battlePoses() {
		game.onTick(500, "completePoses", {
		 lightness.champions().forEach({ champion => game.onTick((200..500).anyOne(), "dance" + champion.name(), {self.pose(champion)}) })
		 darkness.champions().forEach({ champion => game.onTick((200..500).anyOne(), "dance" + champion.name(), {self.pose(champion)}) }) })
	}
	*/
	
	
}
