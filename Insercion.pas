program insercion;

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
	
procedure insercion (var v:vector);  //Insercion//
	var
		j,i,item:integer;
	begin
		for i:=2 to max do
		begin
			item:=v[i];
			j:=i-1;
			while (j>0) and (v[j]>item) do
			begin
				v[j+1]:=v[j];
				j:=j-1;
			end;
			v[j+1]:=item;
		end;
		
		writeln('El vector ordenado es:');   //Muestra el vector ordenado//
		for i:=min to max do
			writeln(v[i]);	
	end;
			
								
BEGIN
	aleatorio(v);
	mostrar_vector(v);
	insercion(v);
	readkey;
END.

