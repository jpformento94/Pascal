program ej_3_matrices;

uses crt;

const
	ini=1;
	fin=3;

type
	matriz=array[ini..fin,ini..fin]of byte;


var 
	m:matriz;

procedure cargar(var m:matriz);
var
	i,j:byte;
begin
	randomize;
	for i:=ini to fin do
		for j:=ini to fin do
			m[i,j]:=random(50)+1;
end;

procedure mostrar(m:matriz);
var
	i,j:byte;
begin
	for i:=ini to fin do
		begin
			for j:=ini to fin do
				write(m[i,j],' ');	
			writeln;
		end;
end;			

procedure permutar(var m:matriz);
var
	i,j,aux:byte;
begin
	for i:=ini to fin do
	begin
		j:=i+1;
		while (j<=fin) do
		begin
			aux:=m[i,j];
			m[i,j]:=m[j,i];
			m[j,i]:=aux;
			j:=j+1;
		end;
	end;			
end;	
	
BEGIN
	cargar(m);
	writeln('Matriz original');
	writeln;
	mostrar(m);
	writeln;
	readkey();
	permutar(m);
	writeln('Matriz cambiada');
	writeln;
	mostrar(m);
	readkey();
END.
