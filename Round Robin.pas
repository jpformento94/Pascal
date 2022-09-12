program RoundRobin;

uses 
	crt, SysUtils;

const
	MIN = 1;
	MAX = 10;
	
type
	Proceso = record
		nombre: string;
		ts:integer;		//tiempo de servicio
		te:integer;		//tiempo de espera
		tr:integer;		//tiempo de reloj utilizado
		ti:integer;		//tiempo de inicio
		tsa:integer;	//tiempo de salida
	end;

	//Lista de procesos	
     Lista_Procesos = Array [MIN..MAX] of Proceso;

var 
	LP: Lista_Procesos;
	Q: integer;		//Quantum
	cantidad_procesos: integer;

{-----------------Cargar procesos-----------------}
procedure cargar_procesos();
var
	nuevo: Proceso;
begin
	clrscr;
	if (cantidad_procesos < MAX) then
		begin
			inc(cantidad_procesos);
			write('Ingrese nombre del procesos: ');readln(nuevo.nombre);
			writeln;
			write('Indique tiempo de servicio: ');readln(nuevo.ts);
			nuevo.ti:= nuevo.ts;
			nuevo.te:= 0;
			nuevo.tr:= 0;
			nuevo.tsa:= 0;
			LP[cantidad_procesos]:= nuevo;
		end
	else
		begin
			writeln('La lista de procesos se encuentra llena');
			readkey;
		end;
end;

{-----------------Muestra los procesos cargados en la lista-----------------}
procedure verProcesos();
var
	i: integer;
begin
	clrscr;
	if (cantidad_procesos = 0) then
		writeln('No hay procesos cargados')
	else
		begin
			TextColor(10);
			writeln('Lista de procesos');
			TextColor(15);
			writeln;
			for i:= MIN to cantidad_procesos do
				begin
					write('Nombre del proceso: ');write(LP[i].nombre);
					writeln;
					writeln;
					write('Tiempo de servicio inicial: ');write(LP[i].ti);
					writeln;
					writeln;
					write('Tiempo de servicio restante: ');write(LP[i].ts);
					writeln;
					writeln('-----------------------------------------------');
				end;
		end;
	readkey;
end;

{-----------------Reinicia la lista de procesos-----------------}
procedure reiniciarListaDeProcesos();
var
	opcion: string;
begin
	clrscr;
	writeln('Esta seguro que quiere reiniciar la lista de procesos? (S/N)');
	readln(opcion);
	if (opcion = 's') or (opcion = 'S')then
		begin
			cantidad_procesos:= 0;
			clrscr;
			writeln('Lista reiniciada');
		end
	else
		begin
			clrscr;
			writeln('La lista no se reinicio');
		end;
	readkey;
end;

{-----------------Cambia el valor del Quantum-----------------}
procedure quantum();
var
	i: integer;
begin
	clrscr;
	writeln('Indique el tiempo de servicio para cada proceso o Quantum');
	readln(i);
	Q:= i;
end;

{-----------------Sumatoria de los tiempos de los procesos-----------------}
function sumatoriaTS():integer;
var
	contador, i: integer;
begin
	contador:= 0;
	for i:= MIN to cantidad_procesos do
		contador:= contador + LP[i].ts;
	sumatoriaTS:= contador;
end;

{-----------------Round Robin-----------------}
procedure roundRobin();
var
	i, vuelta: integer;
begin
	vuelta:= 0;
	{mientras la suma de los tiempos sea mayor que 0 proceso}
	while (sumatoriaTS > 0) do
		begin
			{recorro la lista de procesos}
			for i:= MIN to cantidad_procesos do
				begin
					{si el tiempo de servicio es mayor a 0, lo proceso}
					if (LP[i].ts > 0) then
						begin
							{si es mayor a Q voy a necesitar al menos
							* una vuelta mas para finalizarlo}
							if (LP[i].ts > Q) then
								begin
									{le resto el Q al tiempo restante del proceso}
									LP[i].ts:= LP[i].ts - Q;
								end
							else
								{si no es mayor que Q, el proceso termina en esta ronda}
								begin
									LP[i].ts:= 0;
								end;
						end;
				end;
			inc(vuelta);
			clrscr;
			{muestro como estan los procesos al final de cada vuelta}
			verProcesos();
			write('Vuelta numero: ');write(vuelta);
			readkey;
		end;
end;


{-----------------Menu principal-----------------}
procedure menu();
var
	opcion:char;
begin
	repeat
		clrscr;
		textcolor(10);
		gotoxy(1,1);
		writeln('|=======================================================|');
		writeln('|                    Round Robin                        |');
		writeln('|=======================================================|');
		writeln;
		gotoxy(2,5);
		write('Quantum = ');write(Q);
		textcolor(15);
		gotoxy(2,7);writeln('1- Cargar procesos');
		gotoxy(2,9);writeln('2- Mostrar procesos');
		gotoxy(2,11);writeln('3- Reiniciar lista de procesos');
		gotoxy(2,13);writeln('4- Cambiar Quantum');
		gotoxy(2,15);writeln('5- Iniciar Round Robin');
		textcolor(red);
		gotoxy(2,17);writeln('0- Salir');
		textcolor(45);
		gotoxy(2,19);writeln('Elija una opcion');
		textcolor(15);
		repeat
			opcion:=readkey;
		until opcion in ['0'..'5'];
		clrscr;
		case opcion of
			'1':cargar_procesos();
			'2':verProcesos();
			'3':reiniciarListaDeProcesos();
			'4':quantum();
			'5':roundRobin();
		end;
	until opcion='0';
end;	

BEGIN
	Q:= 4;
	menu();
END.

