/***************************************
              Clase 4
          05 - sep -2025
***************************************/

/***** BUFFERS *****/

//thisProcess.nowExecutingPath.dirname devuelve la carpeta donde está guardado el archivo .scd que se está ejecutando.
//.scd = supercollider document
~path = thisProcess.nowExecutingPath.dirname +/+"forest.wav";

~path2 = thisProcess.nowExecutingPath.dirname +/+"sangre.flac";

// Buffer.read(server, path)
~buf = Buffer.read(s, ~path2);
// PlayBuf.ar(1- numCanales, 2- buffer a reproducir, 3- velocidad de reproducción, 4-trigger, 5-posicion inicial, 6-loop, 7-doneAction
// doneAction -> Que hacer cuando termina (0=no hacer nada)
{PlayBuf.ar(3, ~buf.bufnum, 1, 1,0,0,0)}.play;
s.meter;

ServerOptions.outDevices;   // salidas disponibles
ServerOptions.inDevices;    // entradas disponibles

(
s.options.device = "ASIO : SQ ASIO Driver"; // o el que prefieras, depende del hardware
s.options.numOutputBusChannels = 4; //coloca el num de canales
s.options.numInputBusChannels = 5; //coloca el num de canales


s.reboot; // reinicia el servidor con la nueva configuración

s.meter;
)





~buf.plot; //muestra una pantalla con la forma de onda

~buf.numFrames; //devuelve la cantidad de frames (muestras) que contiene el buffer

// calcula la duración del audio: duración (segundos) = numFrames / sampleRate


~buf.bufnum; // devuelve el ID numerico que el servidor usa para identificarlo

/*** Reporoducción de Buffers ***/

s.meter; //ventana de visualización de canales activos
{PlayBuf.ar(2, ~buf.bufnum, 1, 1,0,0,0)}.play;
{PlayBuf.ar(2, ~buf.bufnum, 0.4, 1,0,0,0)}.play;
{PlayBuf.ar(1, ~buf.bufnum, 3, 1,0,0,0)}.play;


// Visualizador de espectro
FreqScope.new();

/**** MODULACION DE BUFFERS**/

// Modular amplitud de un Buffer
{SinOsc.ar(30)*PlayBuf.ar(1, ~buf.bufnum, 1, 1,0,0,0)}.play;

// Modular rate de un buffer
{PlayBuf.ar(1, ~buf.bufnum,SinOsc.ar(0.05).poll, 1,0,1,0)}.play;


// Modular amplitud de un Buffer
{SinOsc.ar(2)*PlayBuf.ar(1, ~buf.bufnum, 1, 1,0,0,0)}.play;

// Modular rate de un buffer
{PlayBuf.ar(1, ~buf.bufnum,SinOsc.ar(0.05).poll, 1,0,1,0)}.play;
// Podemos usar el método .poll para ver el valor actual de una señal moduladora.

// Señal estereo
{ SinOsc.ar([400,800])}.play;

{ [SinOsc.ar(300), Saw.ar(400)] }.play;

{ [SinOsc.ar(300), Saw.ar(400), LFTri.ar(500),LFPulse.ar(50)] }.play;
,

/****** SINTESIS ******/

{SinOsc.ar(MouseX.kr(40,4000))}.play;

// Visualizador de espectro
FreqScope.new();

// Controlador eje X con el mouse (horizontal)
{SinOsc.ar(MouseX.kr(50,1000))}.play;

// Controlador eje y con el mouse (vertical)
{SinOsc.ar(MouseX.kr(40,4000),0,MouseY.kr(0,1))}.play;

// Frecuencia Modulada
{SinOsc.ar( SinOsc.ar(1,0,500,1000)  )}.play;

// Poll Imprime los valores de la frecuencia
{SinOsc.ar( SinOsc.ar(1,0,500,1000).poll  )}.play;
{SinOsc.ar( SinOsc.ar(2,0,500,1000).poll  )}.play;
{SinOsc.ar( SinOsc.ar(10,0,500,1000)  )}.play;
{SinOsc.ar( SinOsc.ar(300,0,500,1000)  )}.play;
{SinOsc.ar( SinOsc.ar(300,0,500,1000)  )}.play;

(
{SinOsc.ar(
	SinOsc.ar(
		MouseX.kr(0,200),
		0,
		MouseY.kr(0,1000),
		1000)
	,0,0.3  )
}.play;
)

// Señal estereo
{ SinOsc.ar([400,800])}.play; // recibe un array como argumento de frecuencia. el primer canal (400 Hz) y el otro (800 hz)

{ [SinOsc.ar(300), Saw.ar(400)] }.play; // El array contiene dos generadores distintos: un SinOsc y una Saw (sierra)

// tres canales
{ [SinOsc.ar(300), Saw.ar(400), LFTri.ar(500)] }.play;


/**** GRABAR AUDIO ****/

// Comenzar grabación
Server.default.record;

// Terminar grabación
Server.default.stopRecording

s.record; { PinkNoise.ar(0.1) }.play; s.stopRecording;


/**
* FALTA EXPLORAR
*
* Amplitud Modulada
* Modulación de Anillo
*
**/

/***** SynthDef ****/
(
  x = {
   var sig;
   sig = SinOsc.ar([350, 353, 400, 450],0,0.5);
   sig = sig * 0.2;
}.play;
)
x.free;


(
   SynthDef(\test,
	{
     var sig;
     sig = SinOsc.ar([350, 353, 400, 450]);
     sig = sig * 0.3;
     Out.ar(0, sig); //especifica salida
   }).add;
)

y = Synth(\test);
y.free;


(
   SynthDef(\sineSimple,
	{
    Out.ar(0, SinOsc.ar(440, 0, 0.2));
    Out.ar(1, SinOsc.ar(440, 0, 0.2));
	Out.ar(2, SinOsc.ar(440, 0, 0.2));
	Out.ar(3, SinOsc.ar(440, 0, 0.2));
  }).add;
)
Synth(\sineSimple);

s.meter;

(
    SynthDef.new(\test, {
	   arg freq = 350, amp = 0.2, atk = 0.01, dec = 0.3, slev = 0.4, rel = 1, gate = 1, out = 0;
      var sig, env;

	env = EnvGen.kr(Env.adsr(atk, dec, slev, rel),gate, doneAction: 2);

    sig = SinOsc.ar(freq + [0, 1]);
    sig = sig * env;
    sig = sig * amp;
    Out.ar(out, sig);

}).add;
)

x = Synth(\test);
x.set(\freq, 80);
x.set(\amp, 0.5);
x.set(\gate, 3, \rel, 3);
x.set(\out,3);

x = Synth(\test, [freq: 800, amp: 0.1, atk: 4, slev: 1]);