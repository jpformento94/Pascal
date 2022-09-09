program ABM;

uses
	crt, Sysutils, strutils;

var 
	archivo: text;

{-----------------Procedimiento que agrega un registro al archivo-----------------}
procedure alta();
var
	apellido, nombre: string;
	cliente: integer;
begin
	append(archivo);
	clrscr;
	TextColor(10);
	writeln('<=====Alta=====>');
	TextColor(15);
	writeln('');
	writeln('Ingrese apellido');
	readln(apellido);
	writeln('');
	writeln('Ingrese nombre');
	readln(nombre);
	writeln('');
	writeln('Ingrese codigo de cliente');
	readln(cliente);
	while (cliente <= 0) or (cliente > 9999) do
		begin
			clrscr;
			TextColor(red);
			writeln('El codigo de cliente debe ser mayor a 0 y menor a 9999');
			TextColor(15);
			writeln('Ingrese el codigo de cliente nuevamente');
			readln(cliente);
		end;
	writeln(archivo, apellido + ' ', nombre + ' ', cliente);
	close(archivo);
	writeln('');
	writeln('Agregado con exito!');
	readln;
end;

{-----------------Procedimiento que borra un registro del archivo-----------------}
procedure baja();
var
	archivoaux: textfile;
	pos_eliminar, pos_real: integer;
	i, meta_total: integer;
	s: string;
	opcion: char;
begin
	clrscr;
	{cantidad de campos que forman parte de la metadata en total}
	meta_total:= meta_size + 1;

	reset(archivo);
	assign(archivoaux, 'auxiliar.txt');
	rewrite(archivoaux);
	writeln('Indice que la posicion que desea borrar');
	{esta es la posicion que ve el usuario}
	readln(pos_eliminar);
	
	{esta es la posicion real en el archivo, se compone de
	* la que ve el usuario mas los campos de la metadata}
	pos_real:= meta_total + pos_eliminar;
	
	{leo y guardo en el archivo auxiliar hasta una posicion antes de la
	* que el usuario quiere eliminar}
	for i:= 1 to (pos_real - 1) do
		begin
			readln(archivo, s);
			writeln(archivoaux, s);
		end;
	
	{leo la siguiente posicion que se corresponde con la que el usuario
	* solicito eliminar}
	readln(archivo,s);

	clrscr;
	write('Esta a punto de borrar a ');
	TextColor(green);
	write(s);
	writeln('');
	writeln('');
	TextColor(red);
	write('Esta seguro? (S/N)');
	TextColor(15);
	readln(opcion);
	if (opcion = 's') or (opcion = 'S') then
		begin
			while not eof(archivo) do
				begin
					readln(archivo, s);
					writeln(archivoaux, s);
					
				end;
			close(archivo);
			erase(archivo);
			close(archivoaux);
			rename(archivoaux, NombreArchivo + '.txt');
			clrscr;
			writeln('Registro eliminado con exito!');
			readln;
		end
	else
		begin
			clrscr;
			writeln('No se elimino ningun registro');
			readln;
			close(archivo);
			close(archivoaux);
		end;
end;

{-----------------Menu principal-----------------}
procedure menu(var archivo:text);
var
	opcion:char;
begin
	repeat
		clrscr;
		textcolor(14);
		gotoxy(2,1);writeln('==Menu Principal==');
		textcolor(15);
		gotoxy(2,3);writeln('1- Alta');
		gotoxy(2,5);writeln('2- Baja');
		gotoxy(2,7);writeln('3- Modificacion');
		gotoxy(2,9);writeln('4- Ver archivo');
		textcolor(12);
		gotoxy(2,11);writeln('0- Salir');
		textcolor(45);
		gotoxy(2,13);writeln('Elija una opcion');
		textcolor(15);
		repeat
			opcion:=readkey;
		until opcion in ['0'..'4'];
		clrscr;
		case opcion of
			'1':alta();
			'2':baja();
			'3':modificar();
			'4':mostrar();
		end;
	until opcion='0';
end;	

BEGIN
	assign(archivo,'datos.txt');
	menu(archivo);
END.

