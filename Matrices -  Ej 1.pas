program ej_1_matrices;

uses crt,dos;
type
	matriz=array[1..3,1..4] of integer;
var
	m:matriz;
	i,j:integer;
	suma:integer;

procedure carga(var m:matriz);
	begin
		writeln('Ingrese valores');
		for i:=1 to 3 do
			for j:=1 to 4 do
				readln(m[i,j]);
	end;

procedure sumatoria(m:matriz; var sum:integer);
	begin
		sum:=0;
		for i:=1 to 3 do
			for j:=1 to 4 do
				sum:=sum+m[i,j];
	end;
				

BEGIN
	clrscr;
	carga(m);
	sumatoria(m,suma);
	writeln('La suma de todos los elementos es ',suma);
	readkey;
END.
