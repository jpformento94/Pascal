program Ej_1_Registros;

uses crt,dos;

type
	punto=record
		x,y:integer;
	end;	

var
	p1,p2:punto;
	
procedure ingreso_de_puntos(var p1,p2:punto);
	begin
		writeln();
		writeln('Ingrese X1 ');
		readln(p1.x);
		writeln();
		writeln('Ingrese Y1 ');
		readln(p1.y);
		writeln();
		writeln('Ingrese X2 ');
		readln(p2.x);
		writeln();
		writeln('Ingrese Y2 ');
		readln(p2.y);
	end;

function distancia(p1,p2:punto):real;

var
	ca1,ca2,h:integer;
	
begin
	ca1:=p2.x-p1.x;
	ca2:=p2.y-p1.y;
	h:=sqr(ca1)+sqr(ca2);
	distancia:=sqrt(h);
end;

BEGIN
	ingreso_de_puntos(p1,p2);
	writeln('La distancia entre los puntos es ',distancia(p1,p2):5:2);
	readkey;
END.
