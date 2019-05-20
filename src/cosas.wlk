
object knightRider {
	
	method peso() = 500
	method nivelPeligrosidad() = 10
	method bultos() = 1
	method estaSiendoCargada() { /*No hace nada*/ }
}

object bumblebee {
	var transformadoEnAuto = true
	
	method peso() = 800
	method nivelPeligrosidad() = if (transformadoEnAuto) { 15 } else { 30 }
	method bultos() = 2
	method estaSiendoCargada() { transformadoEnAuto = false }
	
	method transformar() { transformadoEnAuto = not transformadoEnAuto }
}

class PaqueteDeLadrillos {
	var  property cantLadrillos = 0
	
	method peso() = 2*cantLadrillos
	method nivelPeligrosidad() =  2
	method bultos() = if (self.cantDeLadrillosEsDe1A100()) {1} else if (self.cantDeLadrillosEstaEntre101y300()) {2} else {3}
	method estaSiendoCargada() { cantLadrillos += 12 }
	
	
	method cantDeLadrillosEsDe1A100() = cantLadrillos.between(1,100)
	method cantDeLadrillosEstaEntre101y300() = cantLadrillos.between(101,300)
}

object arenaGranel {
	var property peso = 0
	
	method nivelPeligrosidad() = 1
	method bultos() = 1
	method estaSiendoCargada() { peso += 20 }
}

object bateriaAntiaerea {
	var property estaConMisiles = false
	
	method peso() = if (estaConMisiles) {300} else {200}
	method nivelPeligrosidad() = if (estaConMisiles) {100} else {0}
	method bultos() = if (estaConMisiles) {2} else {1}
	method estaSiendoCargada() { estaConMisiles = true }
}

object contenedorPortuario {
	var property cosasAdentro = []

	method peso() = 100 + cosasAdentro.sum({cosa => cosa.peso()})
	method nivelPeligrosidad() = if (not cosasAdentro.isEmpty()) {self.maximoNivelDePeligrosidadDeLasCosas()} else {0}
	method bultos() = 1 + cosasAdentro.sum({cosa => cosa.bultos()})
	method estaSiendoCargada() {cosasAdentro.forEach({cosa => cosa.estaSiendoCargada()})} //ERA UN FOREACH
	
	method agregarCosas(cosa) { cosasAdentro.add(cosa) }
	method nivelDePeligrosidadDeLasCosas() = cosasAdentro.map({cosa => cosa.nivelPeligrosidad()})
	method maximoNivelDePeligrosidadDeLasCosas() = self.nivelDePeligrosidadDeLasCosas().max()
}

object residuosRadioactivos {
	var property peso = 0
	
	method nivelPeligrosidad() = 200
	method bultos() = 1
	method estaSiendoCargada() { peso += 15}
}

object embalajeDeSeguridad {
	const paqueteDeLadrillos = new PaqueteDeLadrillos()
	var property cosaAdentro = paqueteDeLadrillos
	
	method peso() = cosaAdentro.peso()
	method nivelPeligrosidad() = cosaAdentro.nivelPeligrosidad()/2
	method bultos() = 2
	method estaSiendoCargada() { /*No hace nada*/ }
}

