program ej_8_matrices;

uses crt;

const
	centro=5;
	curso=6;
	alumno=30;

type
	matriz=array[1..centro,1..curso,1..alumno] of integer; //matriz principal
	media=array[1..centro,1..curso] of real;               //matriz de media
	vecentro=array[1..centro] of real;                     //vector media de centro

var 
	m:matriz;
	med:media;
	v:vecentro;
	
procedure cargar(var m:matriz);
var
	i,j,k:integer;
begin
	randomize;
	for i:=1 to centro do
		for j:=1 to curso do
			for k:=1 to alumno do
				m[i,j,k]:=random(10)+1;
end;

procedure obtener(m:matriz;var med:media;var v:vecentro);
var
	i,j,k,pos1,pos2,posmejal:integer;
	aux1,aux2,aux3,mayor1,mayor2,mejal:real;
begin
	aux1:=0;                                 //media por curso
	aux2:=0;                                 //media por centro
	aux3:=0;                                 //media general
	mayor1:=-1;
	mayor2:=-1;
	mejal:=-1;                                //mejor alumno por curso
	for i:=1 to centro do
		begin
		for j:=1 to curso do
			begin
				for k:=1 to alumno do
					begin
						aux1:=m[i,j,k]+aux1;
						if (m[i,j,k]>mejal) then
							begin
								mejal:=m[i,j,k];
								posmejal:=k;
							end;
					end;	
				med[i,j]:=aux1/alumno;            //media por curso
				aux1:=0;
				writeln();
				writeln('La nota medio por curso es ',med[i,j]:5:2);
				writeln();
				aux2:=med[i,j]+aux2;              //suma de todos los cursos de un centro
				writeln('El mejor alumno del curso ',j,' del centro ',i,' es el alumno ' ,posmejal,
				' con la nota ',mejal:5:2);
				readkey;
				clrscr;
			end;	
		v[i]:=aux2/curso;                     //media de un centro
		writeln();
		writeln('La nota medio por centro es ',v[i]:5:2);
		readkey;
		clrscr;
		aux2:=0;
		end;
	for i:=1 to centro do                     //recorro vector de promedio de centros
		begin
			aux3:=v[i]+aux3;
			if (v[i]>mayor1) then                 //mayor 1 de los mejores centros y sus notas
				begin
					mayor1:=v[i];
					pos1:=i;
				end
			else
				begin
					if (v[i]>mayor2) then
					begin
						mayor2:=v[i];
						pos2:=i;
					end;
				end;			
		end;
	aux3:=aux3/centro;
	writeln();
	writeln('La nota media general es ',aux3:5:2);
	writeln();
	writeln('El mejor centro es ',pos1,' y su nota es ',mayor1:5:2);
	writeln();
	writeln('El segundo mejor centro es ',pos2,' y su nota es ',mayor2:5:2);
	writeln();
	readkey;	
end;			
	
	
BEGIN
	cargar(m);
	obtener(m,med,v);
END.
