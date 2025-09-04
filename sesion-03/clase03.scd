/***************************************
              Clase 3
          04 - sep -2025
***************************************/

/**** RUTINAS ******/

(
~eventA = {SinOsc.ar(69.midicps ! 2) * Line.kr(0.1, 0, 1, 2)}; //midicps coniverte un midinote en ciclos por segundo (Hz)
~eventB = {SinOsc.ar(70.midicps ! 2) * Line.kr(0.1, 0, 1, 2)}; // 69.midicps → 440.0
~eventC = {SinOsc.ar(75.midicps ! 2) * Line.kr(0.1, 0, 1, 2)}; // las notas se representan con números enteros que van de 0 a 127

f = {
~eventA.play;
~eventB.play;
~eventC.play;
};
)

f.();


/*** MIDISCPS **/
//Programa que muestra el número MIDI, su frecuencia en HZ y el nombre de la nota

(
// Lista de nombres de notas (12 semitonos)
var notas = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

// Recorre todas las notas MIDI (0 a 127)
(0..127).do { |n|
    var frecuencia, nombre, octava;
    frecuencia = n.midicps;                   // número MIDI → frecuencia en Hz
    nombre = notas.wrapAt(n % 12);            // nombre de la nota
    octava = (n div: 12) - 1;                 // octava MIDI (C4 = 60)

    // Imprime en consola: MIDI, Frecuencia, Nota+Octava
    [n, frecuencia.round(0.01), nombre ++ octava].postln;
};
)
// **********************


// Ejemplo 1 de Routine

(
~eventA = {SinOsc.ar(60.midicps ! 2) * Line.kr(0.1, 0, 1, 2)}; //eventoA
~eventB = {SinOsc.ar(70.midicps ! 2) * Line.kr(0.1, 0, 1, 2)};
~eventC = {SinOsc.ar(75.midicps ! 2) * Line.kr(0.1, 0, 1, 2)};

f = {
~eventA.play;
1.yield; // "pausar aquí y devolver este valor al llamador, y luego continuar desde el mismo punto cuando se reanude."
~eventB.play;
2.yield;
~eventC.play;
3.yield;
	"Fin de la rutina".postln;
	4.yield;
};

r = Routine(f);
)

r.next;
r.reset;

{SinOsc.ar()}.play;

//valores por defecto
SinOsc.ar(freq: 440.0, phase: 0.0, mul: 1.0, add: 0.0)


{ SinOsc.ar(MouseX.kr(40, 10000, 1), MouseY.kr(100, 10000, 1), 0.1) }.play;



(
  // 1.- Función que reproduce una onda
  ~playTone = {
	arg freq;
  {SinOsc.ar(freq ! 2) * Line.kr(0.1, 0, 0.2, 2)}.play;
  };

 // 2.- Rutina
  r = Routine({
         loop({ // loop -> primer ciclo
         ~playTone.(72.midicps); //genera sonido
		"primera parte del loop".postln;
		"**********************".postln;
		 0.4.yield;

		   [62, 63, 64].do({ |item,indice| // .do -> segundo ciclo
           ~playTone.(item.midicps); //genera sonido
			("pos = "+indice).postln;
			("numero midi = "+item).postln;
           (0.4/3).yield;
           });
         });
    });
)
r.play;
r.stop;

0.4/3;

/****** CICLOS *****/
~lista = [20,30,50,80];

// Cíclo vacío
~lista.do({});

// Cíclo para imprimir los elementos
(
~lista.do({arg val;
	val.postln;
});
)

// Cíclo para imprimir los elementos entre 10
(
~lista.do({arg val;
	(val/10).postln;
});
)

( // concatenación en un ciclo
["h","o","l","a"].do({|letra, i|
	//("letra: "+letra).postln;
	var in = i+1;
	(letra+letra[in]).postln;
	}
);
)

(
[10,20,30].do({|item, i|
	("item = "+item+", index ="+i).postln;
}
);
)

/***** Patrones *****/

// Patterns -> Secuenciadores


(
Pbind(
	\note, Pseq([0,2,5,7,9,11,12,13]) //secuencias de notas
).play
)

(
Pbind(
	\note, Pseq([11,12,13],4) //secuencias de notas
).play
)

(
Pbind(
	\note, Pseq([0,2],3,0)
).play
)


(
Pbind(
	\note, Pseq([0,2,\,4],3),
	\dur, Pseq([1,2,1,1],3)
).play
)

~melod = [5,7,9,5,5,7,9,5,9,10,12,\,9,10,12,\];
~velocidad = 0.25;

(
Pbind(
	\note, Pseq(~melod),
	\dur, 0.25
).play
)

(
Pbind(
	\note, Pshuf([0,1,2,3],8), //Devuelve una versión aleatorizada del elemento de la lista por elemento, con n repeticiones.
	\dur, 1/8
).play;
)

// ====================================
//  Serialismo Aleatorio con Pbind
// ===================================
// Se generan dos permutaciones aleatorias del total cromático (12 notas),
// luego se repiten indefinidamente con duración constante.
// Esto simula una técnica serial.

// Pshuf((..11), 2) → dos permutaciones del total cromático
// Pn(..., inf) → se repiten infinitamente
// .trace → muestra en consola las notas generadas

n = 3;
(
Pbind(
    \note, Pn(Pshuf((..n), 2), inf).trace,
    \dur, 0.2  // Duración fija de cada nota
).play;
)


~lista1 = [ [1,2,3], 2, [3,4]];
~lista1[0];
~lista1[1];
~lista1[2];

(
Pbind (
	\note, Pwrand([0,2,4,5,7,9,11],[0.4,0.05,0.2,0.05,0.2,0.05, 0.05], inf).trace, //'.trace' imprime el valor en la terminal
	\dur, 0.25
).play
)

(
Pbind (
	\note, Pwrand([[0,1,3],2,[5,8,9],5,7,9,[1,2,3]],[0,0,0,0.1,0.4,0.1,0.4], inf).trace, //'.trace' imprime el valor en la terminal
	\dur, 0.25
).play
)




// ===========================
//    Generación de acordes
// ===========================

(
Pbind(
	\note, Prand([[0,4,7], [4,7,9,12], [2,5,6,4]],inf), //inf -> repetición infinita
	\dur, 1,
	\amp, 0.4,
	\octave, 4
).play
)

// ===========================
//     Ejercicio: Scale
// ===========================

// Scale -> Objeto con un acervo de escalas.


Scale.openCodeFile; //Abre el código fuente para ver todo el acervo de las escalas.

(
Pbind(
	\scale, Scale.chromatic,
	\degree, Prand ([[0,2,4],[4,6,0],[2,6,7],0,14,7], inf).trace,
	\dur, Prand ([0.2,1,0.5,0.3,0.6,0.9],inf) //Es recomendable variar la duración para hacer ritmos.
).play
)


// =================================
//         Funciones Estocásticas
// ================================

// Aleatoriedad estocástica: se generan valores aleatorios controlados usando
// SuperCollider ofrece objetos como Prand, Pwrand, Pwhite, etc. para crear
// secuencias aleatorias con distintas propiedades estadísticas.
// Estos permiten controlar el comportamiento del azar en patrones musicales.

Pn(Pshuf())

Pshuf ([0,1,2,3,4,5,6,7,8,9,10,11])

Pshuf((..11)).asStream.all

Pwhite(0,1,200).asStream.all.plot //plot sirve para gráficar
// Presionar la tecla 'M' en la ventana de la gráfica cambia el tipo de visualización (línea, barras, puntos, etc.)

Pexprand(length:200).asStream.all.plot
Pgauss(0,1,200).asStream.all.plot
Pbrown(0,10,1,200).asStream.all.plot
Pbeta(0,1,0.1,0.1,200).asStream.all.plot

Pwrand
Prand


(
Pbind(
	\scale, Scale.minor,
	//\degree, Pbrown (0,7,1,inf),
	//\degree, Pwhite (0,7).trace,
	//\degree, Pgauss (5,10,inf).round.trace, //suena cul xd
	\degree, Pbeta(0,12,0.1,0.1).round.trace,
	\dur, 0.25
).play
)

