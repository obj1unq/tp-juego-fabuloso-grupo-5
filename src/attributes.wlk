import champions.*
import teams2.*
import starting.*

object attributes {
	
var property paladin = new Champion(image="paladin1.png",
							 team=lightness,
							 name="paladin",
							 maxHP=120,
							 strength=15,
							 wisdom=5)

var property berserker = new Champion(image="berserker1.png",
							   team=lightness,
							   name="berserker",
							   maxHP=100,
							   strength=20,
							   wisdom=2)

var property archer = 	new Champion(image="archer1.png",
							 team=lightness,
							 name="archer",
							 maxHP=80,
							 strength=12,
							 wisdom=10)

var property mage = new Champion(image="mage1.png",
						  team=lightness,
						  name="mage",
						  maxHP=70,
					      strength=5,
						  wisdom=20)

var property doomGuy = new Champion(image="doomGuy1.png",
						     team=lightness,
						     name="doomGuy",
						     maxHP=110,
					         strength=18,
						     wisdom=8)

var property knight = new Champion(image="knight1.png",
							team=lightness,
							name="knight",
							maxHP= (60).randomUpTo(120),
							strength= (10).randomUpTo(20),
							wisdom= (2).randomUpTo(10))


var property dracula = new Champion(image="dracula1.png",
							 team=darkness,
							 name="dracula",
							 maxHP= (-110),
							 strength=17,
							 wisdom=17)

var property goblin = new Champion(image="goblin1.png",
							 team=darkness,
							 name="goblin",
							 maxHP= (-110),
							 strength=17,
							 wisdom=17)

var property wizard = new Champion(image="wizard1.png",
							 team=darkness,
							 name="wizard",
							 maxHP= (-110),
							 strength=17,
							 wisdom=17)

var property darkBerserker = new Champion(image="darkBerserker1.png",
							 team=darkness,
							 name="darkBerserker",
							 maxHP= (-110),
							 strength=17,
							 wisdom=17)

var property spellCaster = new Champion(image="spellCaster1.png",
							 team=darkness,
							 name="spellCaster",
							 maxHP= (-110),
							 strength=17,
							 wisdom=17)

var property pinkyDemon = new Champion(image="pinkyDemon1.png",
							 team=darkness,
							 name="pinkyDemon",
							 maxHP= (-110),
							 strength=17,
							 wisdom=17)
				
const property allCharacters = [paladin,berserker,archer,mage,doomGuy,knight,dracula,goblin,wizard,darkBerserker,spellCaster,pinkyDemon]				
							 

		method setAll() {
			teamSelector.winnerPlayer().team().champions().forEach({champion => self.setActual(champion)})
			teamSelector.loserPlayer().team().champions().forEach({champion => self.setActual(champion)})
		}
		
		method setActual(champion) {
			teamSelector.winnerPlayer().team().champions().add(self.finded(champion))
			teamSelector.winnerPlayer().team().champions().remove(teamSelector.winnerPlayer().team().champions().first())
			teamSelector.loserPlayer().team().champions().add(self.finded(champion))
			teamSelector.loserPlayer().team().champions().remove(teamSelector.loserPlayer().team().champions().first())
		}
		
		method finded(champion) {
			return allCharacters.find({ character => character.name() == champion.name() })
		}

	
}
