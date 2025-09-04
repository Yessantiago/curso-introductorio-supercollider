/***************************************
              Clase 2
          03 - sep -2025
***************************************/


/*********** CLASES Y METODOS **********/


// Ambos heredan .abs y .squared de Number
(-5).abs;        // -> 5               (Integer)
(-3.2).abs;      // -> 3.2             (Float)

5.squared;       // -> 25              (Integer)
3.5.squared;     // -> 12.25           (Float)

// Comprobar clases
5.class;         // -> Integer
3.5.class;       // -> Float
Number.superclasses;  // cadena de herencia

/*** SinOsc **/
s.boot;

{ SinOsc.ar(440, 0, 0.2) }.play;
{ SinOsc.ar(880, 0, 0.2)}.play;
{ SinOsc.ar(80, 0, 0.2)}.play;
{ SinOsc.ar(XLine.kr(2000, 200), 0, 0.15) }.play;


/**** OSCILADORES ****/

SinOsc //onda sinoidal
Saw // onda Diente de cierra
Pulse // onda cuadrada
LFTri // onda triangular

/**** GENERADORES DE RUIDO ****/

WhiteNoise
PinkNoise

/**** METODOS Y PARAMETROS IMPORTANTES ****/
métodos:
.ar - audio rate
.kr - controlador de audio

parametros:
freq - frecuencia
mul - volumen
