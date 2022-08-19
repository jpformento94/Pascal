program Ej8_Registro;

uses crt;

type
	notas=record
		x,y,z:integer;
	end;	

	alumnos=record
		nombre:string[35];
		apellido:string[35];
		parciales:notas;
		promedio:real;
	end;
	
	estudiantes=array[1..10]of alumnos;

var
	v:estudiantes;
	
procedure cargar_alumnos(var v:estudiantes);

var
	i:byte;
	
begin
	for i:=1 to 10 do
		begin
			gotoxy(1,2);
			writeln('Ingrese el nombre del alumno');
			readln(v[i].nombre);
			clrscr;
			gotoxy(1,2);
			writeln('Ingrese apellido');
			readln(v[i].apellido);
			clrscr;
			gotoxy(1,2);
			writeln('Ingrese notas del primer parcial');
			readln(v[i].parciales.x);
				while (v[i].parciales.x<0) or (v[i].parciales.x>10) do
					begin
						writeln('Error, la nota no puede ser menor a 0 o mayor a 10');
						readln(v[i].parciales.x);
					end;	
			clrscr;
			gotoxy(1,2);
			writeln('Ingrese notas del segundo parcial');
			readln(v[i].parciales.y);
			while (v[i].parciales.y<0) or (v[i].parciales.y>10) do
					begin
						writeln('Error, la nota no puede ser menor a 0 o mayor a 10');
						readln(v[i].parciales.y);
					end;	
			clrscr;
			gotoxy(1,2);
			writeln('Ingrese notas del tercer parcial');
			readln(v[i].parciales.z);
			while (v[i].parciales.z<0) or (v[i].parciales.z>10) do
					begin
						writeln('Error, la nota no puede ser menor a 0 o mayor a 10');
						readln(v[i].parciales.z);
					end;	
			v[i].promedio:=(v[i].parciales.x+v[i].parciales.y+v[i].parciales.z)/3;
			clrscr;
		end;	
end;
	
procedure mostrar_promedios(v:estudiantes);

var
	i:byte;
begin	
	for i:=1 to 10 do
		writeln('El alumno: ',v[i].nombre,' ',v[i].apellido,' obtuvo de promedio: ',v[i].promedio:5:2);
	readkey;		
end;
	
BEGIN
	textcolor(10);
	cargar_alumnos(v);
	mostrar_promedios(v);
	readkey;
END.

