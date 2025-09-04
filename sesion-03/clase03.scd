/*********
Clase 3
*********/


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
	\note, Pseq(~melod)

//	\dur, Pseq([,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5])
).play
)
