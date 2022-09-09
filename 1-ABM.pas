program ABM;

uses
	crt;

type
	cliente = record
		apellido: string[20];
		nombre: string[20];
		numero: integer;
	end;

	bd = file of cliente;
	
var 
	archivo: bd;

{-----------------Abre el archivo y si no existe lo crea-----------------}
procedure abrir (var f: bd);
var
	resultado : Integer;
begin
	{$I-}
	reset (f);
	resultado := IOresult;
	{$I+}
	if resultado <> 0 then
		rewrite (f);
	rlose (f);
end;

{-----------------Procedimiento que agrega un registro al archivo-----------------}
procedure alta (var f :bd);
var
	R, E : Estudiante;
	I	 : Integer;		{posicion del registro en el archivo}

begin
	Clrscr;
	Gotoxy(25, 2); Writeln ('Altas');
	Reset (F);
	Gotoxy (1,24); Writeln ('Presionar N para salir');
	while Upcase (readkey) <> 'N' do
		begin
        	gotoxy (20, 13);
			writeln ('Introducir los datos del nuevo registro');
			LeerRegistro (E);
			I := Posicion (E.Apynom, F);
			if I = -1 then              {el registro no existe}
				begin
					I := FileSize (F);
					Seek (F, I);  {se posiciona al final del archivo}
					Write (F, E);
				end
			else
				begin
					Seek (F, I);
					Read (F, R);
					if R.Sw then      {si existe, verifica que se
	 								encuentre libre}
						begin
							Gotoxy (20, 21);
							writeln ('Registro Existente');
						end
					else
					    begin
							seek(F,filepos(F) - 1);
							write (F, E);
						end;
				end;
			gotoxy (20, 21);
			writeln ('Presionar N para salir')
		end;
    close (F)
end;

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
	i: integer;
	pos_eliminar: integer;
	opcion: char;
	s: string;
begin
	clrscr;

	reset(archivo);
	assign(archivoaux, 'auxiliar.txt');
	rewrite(archivoaux);
	writeln('Indique la posicion que desea borrar');
	readln(pos_eliminar);
	
	{leo y guardo en el archivo auxiliar hasta una posicion antes de la
	* que el usuario quiere eliminar}
	for i:= 1 to (pos_eliminar - 1) do
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
			rename(archivoaux, 'datos.txt');
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

{-----------------Procedimiento que modifica un registro del archivo-----------------}
procedure modificar();
var
	archivoaux: textfile;
	i: integer;
	pos_modificar: integer;
	s: string;
	apellido, nombre: string;
	cliente: integer;
begin
	clrscr;

	reset(archivo);
	assign(archivoaux, 'auxiliar.txt');
	rewrite(archivoaux);
	writeln('Indice que la posicion que desea modificar');
	readln(pos_modificar);
	
	{leo y guardo en el archivo auxiliar hasta una posicion antes de la
	* que el usuario quiere modificar}
	for i:= 1 to (pos_modificar - 1) do
		begin
			readln(archivo, s);
			writeln(archivoaux, s);
		end;
	
	{la modificacion se efectua como un proceso de alta}
	clrscr;
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
	writeln(archivoaux, apellido + ' ', nombre + ' ', cliente);
	
	readln(archivo, s);
	
	while not eof(archivo) do
		begin
			readln(archivo, s);
			writeln(archivoaux, s);	
		end;
	close(archivo);
	erase(archivo);
	close(archivoaux);
	rename(archivoaux, 'datos.txt');
	clrscr;
	writeln('Registro modificado con exito!');
	readln;
end;

{-----------------Procedimiento que muestra los registros cargados en el archivo-----------------}
procedure mostrar();
var
	i, p : integer;
	s: string;
begin
	reset(archivo);
	{Muestra el nombre de las columnas}
	textcolor(10);
	gotoxy(4,1);
	write('Apellido');
	gotoxy(24,1);
	write('Nombre');
	gotoxy(44,1);
	write('Cliente');
	writeln('');
	{Muestra el contenido del archivo}
	i:= 2;
	p:= 2;
	textcolor(15);
	while not eof(archivo) do
		begin
			readln(archivo,s);
			write(p-1);
			gotoxy(4,p);
			writeln(s);
			inc(p);
			inc(i);
		end;

  GotoXY(20,10);
  Writeln('Hola');

	readln();
end;

{-----------------Menu principal-----------------}
procedure menu(var archivo:bd);
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
	assign(archivo,'datos.dat');
	abrir(archivo);
	menu(archivo);
END.
