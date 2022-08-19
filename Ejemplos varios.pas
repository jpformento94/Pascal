{
Programa con ejemplos para usar de guia
Contiene funciones y procedimientos
con parametros pasados por valor y/o referencia
como asi tambien algunos ejemplos de trabajo con strings 
uso de menu con "case of"
uso de colores
}

Program Prueba;

Uses Dos,Crt,sysutils;

Var
 Color,Eleccion :Integer;
 Salir,Colores:Boolean;


//genera una linea punteada
Procedure Separador(); 
Var i: Integer;
Begin
  For i:=1 to 80 do
    Write('-');
  Writeln;
End;

//genera una pausa
Procedure pausa();
Begin
    Write('Presionar ENTER para continuar...');
    Readln;
end;

// genera una recuadro
// recibe los puntos
// angulo sup derecho x1,y1
// angulo inf izquierdo x2,y2 
Procedure recuadro(x1,y1,x2,y2:Integer;c:char); 
Var i: Integer;
Begin
     If Not Colores then
       TextColor(color)
     else 
       TextColor(2);
  For i:=x1 to x2 do
   begin 
     gotoXY(i,y1);
     Write(c);
     gotoXY(i,y2);
     Write(c);
   end;

  For i:=y1 to y2 do
   begin 
     gotoXY(x1,i);
     Write(c);
     gotoXY(x2,i);
     Write(c);
   end;
     If Not Colores then
       TextColor(color)
     else 
       TextColor(0);
End;

//Setea el uso o no de colores en el programa
Procedure UsaColores(); 
Begin
   ClrScr;
   Colores:=False;
   color:=9;
   recuadro(20,8,95,18,'@');
   TextColor(color);
   GotoXY(22,12);
   Write('Desea Usar colores distintos en los mensajes (0=No - 1=Si)');
   Readln(Eleccion); 
   While (Eleccion<>0) and (Eleccion<>1) do
     Begin
       Clrscr;
       recuadro(20,8,95,18,'@');
       GotoXY(32,10);
       Write('Ingrese CERO o UNO');
       GotoXY(22,12);
       Write('Si su monitor no muestra las opciones escoja NO');
       Write('Desea Usar colores distintos en los mensajes ( 0=NO  -   1=SI)');
       Readln(Color); 
     End; 
   If Eleccion=1 then Colores:=True;
End;







Procedure Muestra_ASCII(); 
Var j,i,x: Integer;
Begin
  clrscr;
  i:=32;
  x:=5;
     If Not Colores then
       TextColor(color)
     else 
       TextColor(4);
  gotoXY(23,3);
  Write(' Caracteres ASCII entre 32 y 126');
     If Not Colores then
       TextColor(color)
     else 
      TextColor(0);
  while i<=122 do
   begin
    for j:=1 to 5 do
     Begin
       gotoXY(10+(10*j),x);
       Write(i:4,'=',chr(i));
       i:=i+1;
     end;
     x:=x+1;
    Writeln;
   end;
   recuadro(16,1,72,25,'@');
   writeln;
   pausa;
End;


Function IngEntero(nro:Integer):Integer;   // Permite el ingreso de Enteros
Var
  Valor:Integer;
Begin
   GotoXY(10,24);
   Write('                                   ');
   GotoXY(10,24);
   Write('Ingrese el ',nro,' valor: ');
   readln(Valor);
   IngEntero:=Valor;
End;


Procedure PorValor(pv1, pv2, pv3, igual : Integer);  // Los parametros van por valor
Begin
  writeln;
  Writeln('Ahora estamos en el procedimiento Por Valor');
  Writeln('Donde Multiplicamos a cada uno por 2 y los mostramos');
  pv1:=pv1 * 2;
  pv2:=pv2 * 2;
  pv3:=pv3 * 2;
  igual:=igual * 2;
  writeln;
     If Not Colores then
       TextColor(color)
     else 
       TextColor(9);
  Writeln(' pv1: ',pv1,'    pv2: ',pv2,'    pv3: ',pv3 ,'      igual: ', igual);
     If Not Colores then
       TextColor(color)
     else 
       TextColor(0);
  writeln;
  Write('Ahora volveremos al program principal; Presionar ENTER para continuar...');
  Readln;
End;


Procedure PorReferencia(var pr1, pr2, pr3, igual : Integer);  // Los parametros van por referencia
Begin
  writeln;
  Writeln('Ahora estamos en el procedimiento Por Referencia');
  Writeln('Donde Multiplicamos a cada uno por 5 y los mostramos');
  pr1:=pr1 * 5;
  pr2:=pr2 * 5;
  pr3:=pr3 * 5;
  igual:=igual * 5;
  writeln;
     If Not Colores then
       TextColor(color)
     else 
       TextColor(4);
  Writeln(' pr1: ',pr1,'    pr2: ',pr2,'    pr3: ',pr3, '      igual: ', igual);
     If Not Colores then
       TextColor(color)
     else 
       TextColor(0);
  writeln;
  Write('Ahora volveremos al program principal; Presionar ENTER para continuar...');
  Readln;
End;


// es el procedimiento que llama a
// Valor y a Referencia
Procedure Ejemplo1;
Var
  pp1, pp2, pp3, igual : Integer;

Begin
  ClrScr;
  GotoXY(20,10);
  Writeln('Ingrese 4 valores enteros ');
  pp1:=IngEntero(1);
  pp2:=IngEntero(2);
  pp3:=IngEntero(3);
  igual:=IngEntero(4);

  clrscr;
  Writeln('Estos son los valore ingresados ');
  writeln;
     If Not Colores then
       TextColor(color)
     else 
       TextColor(2);
  Writeln(' pp1: ',pp1,'    pp2: ',pp2,'    pp3: ',pp3, '      igual: ', igual);
     If Not Colores then
       TextColor(color)
     else 
       TextColor(0);
  Writeln;
  writeln;
  Write('Ahora los pasaremos por valor; Presionar ENTER para continuar...');
  Readln;
  Separador;

  PorValor(pp1, pp2, pp3, igual);  // LLamamos a el procedimiento Por Valor
  writeln;
  Writeln('Ahora hemos retornado al programa principal');
  Writeln('Despues de haber pasado por valor');
  Writeln;
     If Not Colores then
       TextColor(color)
     else 
       TextColor(2);
  Writeln(' pp1: ',pp1,'    pp2: ',pp2,'    pp3: ',pp3, '      igual: ', igual);
     If Not Colores then
       TextColor(color)
     else 
      TextColor(0);
  Writeln;
  Separador;
  Write('Presionar ENTER para continuar...');
  Readln;

  Separador;
  Write('Ahora los pasaremos por Referencia; Presionar ENTER para continuar...');
  Readln;
  PorReferencia(pp1, pp2, pp3, igual);  // LLamamos a el procedimiento Por Referencia
  Writeln;
  Writeln;
  Writeln('Ahora hemos retornado al programa principal');
  Writeln('Despues de haber pasado por Referencia');
  writeln;
     If Not Colores then
       TextColor(color)
     else 
      TextColor(2);
  Writeln(' pp1: ',pp1,'    pp2: ',pp2,'    pp3: ',pp3, '      igual: ', igual);
     If Not Colores then
       TextColor(color)
     else 
      TextColor(0);
  Writeln;
  Writeln;
  Writeln('Examine las diferencias ');
  Writeln;
  Separador;
  Write('Presionar ENTER para continuar...');
  Readln;
End;

Procedure MuestradeColores;
Var i:Byte;
Begin
 ClrScr;
 For i:=0 To 10 do
  Begin
    GotoXY(5,i*2 + 6);
      If Not Colores then
       TextColor(color)
     else 
      TextColor(i);
    Writeln(' i=',i, ' Muestra de Colores ');
  End;  // Fin del For
  Readkey;
End;

Procedure MalaEleccion;
Begin
    GotoXY(38,26);
      If Not Colores then
       TextColor(color)
     else 
      TextColor(Red);
    Write('No corresponde a ninguna Opcion Válida');
    Readkey;
End;


// Este ejemplo muestra las comparaciones
// por pantalla miemtras se ejecuta
Function BuscaTexto(S1,S2:String):Boolean;
Var 
  i: Integer;
  b: Boolean; 
Begin
  b:=False;
  For i:=1 to (Length(S1)-Length(S2)+1) do
   begin
    Writeln(s2, '  ',  Copy(S1,i,Length(S2)));
    If S2=Copy(S1,i,Length(S2)) then
     begin 
      b:=True;
      Writeln('   LO ENCONTRE !!!!!!!!!  ');
      pausa; 
     end;
   end;
  BuscaTexto:=b;
End;

Procedure BorraTexto(var S1:String; S2:String);
Var 
  i,j: Integer;
Begin
     For i:=1 to (Length(S1)-Length(S2)+1) do
       If S2=Copy(S1,i,Length(S2)) then
          For j:=i to (i+Length(S2)) do
              S1[j]:=' ';
End;

Procedure BorraVocales(var S:String);
Var 
  i: Integer;
Begin
  For i:=1 to Length(S) do
    If (UpCase(S[i])='A') or (UpCase(S[i])='E') or (UpCase(S[i])='I') or (UpCase(S[i])='O') or (UpCase(S[i])='U') Then
       S[i]:=' ';
End;


Procedure Ej_Texto;  //Menu de los ejemplos de Texto

Var
  Salir:Boolean;
  Eleccion:Integer;
  T1,T2:String;
Begin
   Salir:=False; //Variable que controla el ciclo

   While Not Salir do
   Begin
     ClrScr;
     recuadro(30,8,92,28,'@');
        If Not Colores then
       TextColor(color)
     else 
       TextColor(9);
     GotoXY(42,12);
     Write('SubPrograma para ver ejemplos de Texto ');
     If Not Colores then
       TextColor(color)
     else 
       TextColor(0);
     GotoXY(40,14);
     Write('1 Informar si un texto está contenido en otro ');
     GotoXY(40,16);
     Write('2 Borrar un texto contenido en otro ');
     GotoXY(40,18);
     Write('3 Borrar todas las vocales ');
     GotoXY(40,20);
     Write('0 Salir ');
     GotoXY(40,24);
     Write(' Escoja una Opcion: ');

     Readln(Eleccion);

     Case Eleccion of

        1: Begin
             clrscr; 
             Writeln (' Este ejemplo muestra las comparaciones');
             Writeln (' por pantalla miemtras se ejecuta ');
             Writeln;
             Write('Ingrese texto principal: ');
             ReadLn(t1);  
             Write('Ingrese texto a buscar: ');
             ReadLn(t2);  
             If BuscaTexto(t1,t2) then
              begin
               If Not Colores then
                 TextColor(color)
               else
		           TextColor(4);
                Writeln(t2, ' SI está contenido en ', t1); 
	           If Not Colores then
	             TextColor(color)
	           else 
                TextColor(0);
              end
             Else
              begin
              If Not Colores then
                TextColor(color)
              else 
                TextColor(4);
                Writeln(t2, ' NO está contenido en ', t1);
              If Not Colores then
                TextColor(color)
              else 
                TextColor(0);
              end;
             Separador;
             Pausa;
           End;  


        2: Begin 
             clrscr; 
             Write('Ingrese texto principal: ');
             ReadLn(t1);  
             Write('Ingrese texto a borrar: ');
             ReadLn(t2);  
             BorraTexto(t1,t2);
              If Not Colores then
                TextColor(color)
              else 
                TextColor(4);
             Writeln('Ahora el texto es: ', t1); 
              If Not Colores then
                TextColor(color)
              else 
                TextColor(0);
             Separador;
             Pausa;
           End;  
        
        3: Begin 
             clrscr; 
             Write('Ingrese texto : ');
             ReadLn(t1);  
             BorraVocales(t1);
              If Not Colores then
                TextColor(color)
              else 
                TextColor(4);
             Writeln('Ahora el texto es: ', t1); 
              If Not Colores then
                TextColor(color)
              else 
                TextColor(0);
             Separador;
             Pausa;
           End;  

        0: Salir:=True;

       Otherwise
         MalaEleccion;
     End; // Fin del Case
   End; // Fin del While

End; // Fin del Procedimiento

// Programa Principal

Begin

   UsaColores();

   Salir:=False; //Variable que controla el ciclo

   While Not Salir do
   Begin
     ClrScr;
     recuadro(30,8,86,28,'@');
     If Not Colores then
       TextColor(color)
     else 
       TextColor(4);
     GotoXY(42,12);
     Write('Programa para ver ejemplos ');
     If Not Colores then
       TextColor(color)
     else 
         TextColor(0);
     GotoXY(40,14);
     Write('1 Ver Ejemplo de Valor y Referencia ');
     GotoXY(40,16);
     Write('2 Ver Ejemplos de Colores ');
     GotoXY(40,18);
     Write('3 Ver Ejemplos de Texto ');
     GotoXY(40,20);
     Write('4 Ver Codigos ASCII ');
     GotoXY(40,22);
     Write('0 Salir ');
     GotoXY(40,24);
     Write(' Escoja una Opcion: ');

     Readln(Eleccion);

     Case Eleccion of

        1: Ejemplo1;

        2: MuestradeColores;

        3: Ej_Texto;
  
        4: Muestra_ASCII;

        0: Salir:=True;

       Otherwise
         MalaEleccion;
     End; // Fin del Case
   End; // Fin del While
   TextColor(7);
   clrscr;
End.  // Fin del Programa



