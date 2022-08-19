program Ej2_Registro;

uses crt;

type
	punto=record
		x,y:integer;
	End;
	
	ciudad=record
		nombre:string[35];
		coordenadas:punto;
	End;
	
	arreglociudades=array[1..100]of ciudad;
	
var
	v:arreglociudades;
	buscar:string[35];
	coord:punto;

procedure cargar_ciudades(var v:arreglociudades);
var
	i:byte;
	fin:string[35];
begin
	fin:='fin';
	i:=1;
	v[1].nombre:='';
	while (v[i].nombre<>fin) and (i<=100) do
		begin
			gotoxy(1,2);
			writeln('Ingrese el nombre de la ciudad o ingrese fin para finalizar ingresos');
			readln(v[i].nombre);
			if (v[i].nombre<>fin) then
				begin
					writeln('Ingrese coordenada x');
					readln(v[i].coordenadas.x);
					writeln('Ingrese coordenada y');
					readln(v[i].coordenadas.y);
					i:=i+1;
					clrscr;
				end;
		end;
end;

procedure buscar_ciudad(buscar:string;var v:arreglociudades;var coord:punto);
var
	i:byte;
	flag:boolean;
begin
	flag:=false;
	for i:=1 to 100 do
		if (v[i].nombre=buscar) then
			begin
			coord.x:=v[i].coordenadas.x;
			coord.y:=v[i].coordenadas.y;
			flag:=true;
			end;
	if (not flag) then
		begin
		writeln;
		writeln('La ciudad no se encuentra cargada');
		end
		else
		begin
			writeln;	
			writeln('La ciudad: ',buscar,' se encuentra en las coordenadas:');
			writeln;
			writeln('X= ',coord.x);
			writeln	;
			writeln('Y= ',coord.y);
			readkey;
		end;	
end;		
			
BEGIN
	clrscr;
	textcolor(10);
	cargar_ciudades(v);
	clrscr;
	writeln;
	writeln('Ingrese la ciudad a buscar');
	readln(buscar);
	buscar_ciudad(buscar,v,coord);
END.
