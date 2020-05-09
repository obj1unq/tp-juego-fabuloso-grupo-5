import fightingsystem.*

object teamLight {
	var property chars = []
	var property charSelected = null
		
	method nextChar() {
		chars.add(chars.head())
		chars = chars.drop(1)
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method previousChar() {
		chars = chars.last() + chars
		chars.remove(chars.last())
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
}

object teamDarkness {
	var property chars = []
	var property charSelected = null
		
	method nextChar() {
		chars.add(chars.head())
		chars = chars.drop(1)
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
	
	method previousChar() {
		chars = chars.last() + chars
		chars.remove(chars.last())
		charSelected = chars.head()
		cursor.position(charSelected.position())
	}
}
