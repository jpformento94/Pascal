program burbujeo_mejorado;

uses crt;

const
	min=1;
	max=5;

type 
	vector=array[min..max] of integer;

var 
	v:vector;

procedure aleatorio(var v:vector);  //Carga de un vector aleatorio//
	var i:integer;
	begin
		randomize;
		for i:=min to max do
		(v[i]):=random(10);
		writeln;
		writeln('Vector creado con exito!!!!');
		writeln('Presione una tecla para continuar');
		readkey;
	end;	

procedure mostrar_vector(v:vector);  //Muestra el vector hasta el momento//
	
	var i:integer;
	
	begin
	clrscr;
	writeln('El vector original es:');
		for i:=min to max do
		writeln(v[i]);	
	end;
	
procedure burbujeo_mejorado(var v:vector);  //Burbujeo mejorado//
	var
		j,i,aux:integer;
		ordenado:boolean;
		
	begin
	j:=1;
	ordenado:=false;
	while (not ordenado) and (j<max) do
		begin
			ordenado:=true;
			for i:=min to max-j do
				if v[i]>v[i+1] then
					begin
						aux:=v[i];
						v[i]:=v[i+1];
						v[i+1]:=aux;
						ordenado:=false;
					end;
		j:=j+1;
		end;
			begin  //Muestra el vector ordenado//
				writeln('El vector ordenado es:');
				for i:=min to max do
				writeln(v[i]);	
			end;
	end;		
								
BEGIN
	aleatorio(v);
	mostrar_vector(v);
	burbujeo_mejorado(v);
	readkey;
END.

