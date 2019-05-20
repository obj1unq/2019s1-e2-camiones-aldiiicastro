import cosas.*

class Camion { 
	const property cosas = []
	
	//Accion
	method cargar(unaCosa) 		{ 
								  cosas.add(unaCosa) 	
								  unaCosa.estaSiendoCargada()
								}
	method descargar(unaCosa) 	{ cosas.remove(unaCosa) }
	
	//Consulta
	method pesos() 			= cosas.map({cosa => self.elPesoDeLaCosa(cosa)})
	method pesoTotal()		= 1000 + cosas.sum({cosa => self.elPesoDeLaCosa(cosa)})
	method totalBultos() 	= cosas.sum({cosa => cosa.bultos()})
	
	method cosaMasPesada() 			= cosas.max({cosa => self.elPesoDeLaCosa(cosa)})
	method excedidoDePeso() 		= self.pesoTotal() > 2500
	method objetosPeligrosos(nivel) = cosas.filter({cosa => cosa.nivelPeligrosidad() > nivel})
	
	method tieneAlgoQuePesaEntre(min, max) 	= cosas.any({cosa => self.elPesoDeLaCosa(cosa).between(min,max)})
	method objetosMasPeligrososQue(unaCosa) = cosas.filter({cosa => self.nivelDePeligrosidadDeCosa(cosa) > self.nivelDePeligrosidadDeCosa(unaCosa)})
	
	method puedeCircularEnRuta(nivelMaximoPeligrosidad) = self.cosaConMayorNivelDePeligrosidad()  < nivelMaximoPeligrosidad
	
	//Division 
	method cosaConMayorNivelDePeligrosidad()= cosas.max({cosa => cosa.nivelPeligrosidad()}).nivelPeligrosidad()
	method nivelDePeligrosidadDeCosa(cosa) 	= cosa.nivelPeligrosidad()
	method elPesoDeLaCosa(cosa) = cosa.peso()
}

/* 
    cargar(cosa) y descargar(cosa): para manejar qué tiene;
    pesoTotal(): es la suma del peso del camión vacío (tara) y su carga. La tara del camión es de 1 tonelada (1000 kilogramos);
    excedidoDePeso(): indica si el peso total es superior al peso máximo. El cual es de 2.5 toneladas;
    objetosPeligrosos(nivel): todos los objetos cargados que superan el nivel de peligrosidad indicados por el valor del parámetro;
    objetosMasPeligrososQue(cosa): todos los objetos cargados que son más peligrosos que la cosa;
    puedeCircularEnRuta(nivelMaximoPeligrosidad) Puede circular si ninguna cosa que transporta supera el nivelMaximoPeligrosidad.
    tieneAlgoQuePesaEntre(min, max): indica si el peso de alguna de las cosas que tiene el camión está en ese intervalo;
    cosaMasPesada(): la cosa más pesada que tenga el camión. Ojo que lo que se pide es la cosa y no su peso.
    totalBultos(): la suma de la cantidad de bultos que está transportando. KnightRider, arena a granel y residuos radioactivos son 1 bulto. Bumblebee y embalaje de seguridad son dos. Paquete de ladrillos es 1 hasta 100 ladrillos, 2 de 101 a 300, 3 301 o más. Batería antiaérea: 1 si no tiene misiles, 2 si tiene. Contenedor portuario: 1 + los bultos que tiene adentro.
    pesos(): devuelve una lista con los pesos de cada cosa que tiene el camión.
    
 */