/***************************************
              Clase 1
          02 - sep -2025
***************************************/

/*** TIPOS DE DATOS ****/

5; // Integer (entero)
5.6; // Float (decimal)
pi; // Float (especial especial)
"a"; // char (caracter)
"hola"; // String (cadena)
true; // boolean
false; //


/**** OPERACIONES ******/
5+9;

9*10;

100 - 20;

2**3; //potencia

100/210;

5==5; //evalua si es verdadero o falso ¿5 es igual a 5? verdadero

4 == 32; //evalua si es verdadero o falso ¿4 es igual a 32? falso

1 < 2; // -> true

1 > 2; // -> false

"hello".isEmpty; // -> false


"Hola" + "mundo"; // -> "Hola mundo"
"Some" ++ "times"; // -> "Sometimes" (omite espacios)
"Soy un string".size; //regresa el numero de caracteres de la cadena
"Soy un string".reverse; //orden reverso
"Soy un string".scramble; //orden aleatorio de la cadena
"Soy un string".drop(2); // elimina los primeros 2 caracteres
"Soy un string".drop(-2); // elimina los ultimos 2 caracteres


/****** VARIABLES *****/

//variables del interprete
a = 12;
b = 25;
c = a+b;

d = "hola"+"como estas?";
d;

b =  10+ 2;
b;
z; // error nil -> No hay asignacion de valor, no existe.

// Variables globales

~caja_01 = "juguetes";
~caja_02 = "comida";
~caja_03 = "papeleria";

// ¿Que hay en las cajas?

"En las cajas hay:"+~caja_01++","+~caja_02+"y"+~caja_03;

~frase = "Hello" + "there!";
~frase.postln; //imprime en consola

~num01 = 5;
~num02 = 87;
~resultado = ~num01 + ~num02;

/***** Declaracion de numeros negativos *****/
~num = -2;
~numA =(-2);
~num =-2; //falla -> necesita un espacio


/** bloques de codigo**/

( //todo lo que esta adentro de los parentesis se ejecuta
~caja_04 = "libros";
~caja_05 = "botellas";
~caja_06 =  "ropa";
)

(
~caja_04.postln;
~caja_05.postln;
~caja_06.postln;
)


/****** ARREGLOS *****/
~listaNum = [36,56,9,20];

~listaNum[0];
~listaNum[1];
~listaNum[2];


~listaDatos = [3,2,8,9,"a","hola",3.5];
~listaDatos;

~lista02 = [ [ ], [5,2]]; //lista de listas

~colores = Array.new(5); //crea nuevo arreglo
~colores.add("azul"); //elemento 1 (add -> agrega elemento al arreglo)
~colores.add("rojo"); //elemento 2
~colores.add("gris"); //elemento 3
~colores.add("amarillo"); //elemento 4
~colores.add("morado"); //elemento 5

~colores.insert(0,"rosa"); // -> insert agrega en la posicion 0 el item "rosa"

~colores.size; //tamaño de la lista
~colores[0]; //accede al item de la posicion
~colores.at(0); // misma funcion anterior

~colores[4]; //morado quinto elemento

~colores[5]; //da error -> esta fuera del rango



/********* Ejemplo de lista de listas *********/

~paquete1 = ["galleta1", "galleta2", "galleta3","galleta4", "galleta5"];
~paquete2 = ["galleta1","galleta2"];

~cajaDeGalletas = [~paquete1, ~paquete2];

/*** Operaciones con arreglos ******/
~sumaArreglo = [1,2,3];
~sumaArreglo+100; // -> [101,102,103]

[20,10,30,9,20].sort; // -> Ordena elementos
[1,2,3,4].reverse; // -> Reverso


/******* FUNCIONES O METODOS *******/

(
 ~sumar = {
	arg num1, num2, num3;
	var total;

	total = num1 + num2 + num3;
 }
)


~sumar.(5,1,9);

(
 ~promediar = {
 	arg cal1, cal2;
	var promedio;
	promedio = (cal1 + cal2) /2;
 }
)

~promediar.(6,8);


/***** Definicion alterna de funcion *******/
(
  g = { |thingA = 7, thingB = 5|
     var result;
     thingA = thingA.squared;
     thingB = thingB.reciprocal;
     result = thingA + thingB;
  };
)

g.(3, 2); // -> 9.5 (thingA = 3, thingB = 2);


/*********** CONDICIONAL ********/

(
  if(
     [0, 1].choose == 1,
     {\aguila.postln}, // \etiqueta
     {\sol.postln}
  );
)

/******* EJERCICIO *******/

//datos a evaluar

~calAna = [10, 10, 8, 9, 9, 10, 8, 9, 10, 6];
~calDiego = [7, 5, 6, 6, 5, 7, 8, 5, 7, 9];
~calFrank = [5, 4, 8, 6, 5, 5, 4, 5, 3, 5];


//funcion de promedio
(
~promediar = { | listaCal |
	var promedio;

	promedio = listaCal.sum / listaCal.size;
};
)

~evaluar = ~promediar.(~calFrank);

//condicional
(
 if (
 	~evaluar <=  6, //condición
	{"reprobado"}, // si es verdadero
 	{"aprobado"} // si es falso
 );
)




/******** OTRA SOLUCION ********/

(
// Función que calcula el promedio y dice si aprobó o reprobó
~evaluarAlumno = {
    arg calificaciones, cadena; //como usuario se lo mandar
    var promedio, resultado;

    // 1. Calcular el promedio (completar)
    promedio = calificaciones.sum/calificaciones.size;

    // 2. Evaluar si el estudiante aprueba o reprueba
    if ( promedio >= 6,
		{resultado = "Aprobado"},
		{resultado = "Reprobado"}
	);

    // 3. Mostrar resultados en la consola
    ("Promedio: " ++ promedio).postln;
    ("Resultado: " ++ resultado).postln;
};
)
// Arreglos de calificaciones
~calAna = [10, 10, 8, 9, 9, 10, 8, 9, 10, 6];
~calDiego = [7, 5, 6, 6, 5, 7, 8, 5, 7, 9];
~calFrank = [5, 4, 8, 6, 5, 5, 4, 5, 3, 5];

// Llamadas de ejemplo
~evaluarAlumno.(~calAna);
~evaluarAlumno.(~calDiego);
~evaluarAlumno.(~calFrank);
