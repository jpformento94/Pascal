program ej_2_matrices;

uses crt,dos;
type
	matriz=array[1..3,1..3] of integer;
	vector1=array[1..3] of integer;
	vector2=array[1..3] of integer;
var
	m:matriz;
	sumfil:vector1;
	sumcol:vector2;
	i,j:integer;

procedure carga(var m:matriz);
	begin
		writeln('Ingrese valores');
		for i:=1 to 3 do
			for j:=1 to 3 do
				readln(m[i,j]);
	end;

procedure inicializar(var sumfil:vector1; var sumcol:vector2);
begin
	for i:=1 to 3 do
		sumfil[i]:=0;
	for j:=1 to 3 do
		sumcol[j]:=0;	
end;

procedure sumatoria(m:matriz; var sumfil:vector1;var sumcol:vector2);
	begin
		for i:=1 to 3 do
			for j:=1 to 3 do
			begin
				sumfil[i]:=sumfil[i]+m[i,j];
				sumcol[j]:=sumcol[j]+m[i,j];
			end;
	end;
				
procedure mostrar(sumfil:vector1; sumcol:vector2);
begin
	writeln('El vector de filas es:');
	begin
	for i:=1 to 3 do
		writeln(sumfil[i]);
	end;
	begin
	writeln('El vector de columnas es:');
		for j:=1 to 3 do
			writeln(sumcol[j]);
	end;
end;		

BEGIN
	clrscr;
	carga(m);
	inicializar(sumfil,sumcol);
	sumatoria(m,sumfil,sumcol);
	mostrar(sumfil,sumcol);
	readkey;
END.
