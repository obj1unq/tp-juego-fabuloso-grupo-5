object porcentaje {

	method es100(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 100 
	}
	method es90(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 90 
	}
	method es80(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 80 
	}
	method es70(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 70 
	}
	method es60(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 60 
	}
	method es50(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 50 
	}
	method es40(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 40 
	}
	method es30(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 30 
	}
	method es20(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) >= 20 
	}	
	method es10(nActual, nTotal) {
		return ( (nActual.abs() * 100) / nTotal.abs() ) < 20 &&
			   ( (nActual.abs() * 100) / nTotal.abs() ) > 0
	}
	
}
