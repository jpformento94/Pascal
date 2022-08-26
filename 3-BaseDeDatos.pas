program ReadFile;

uses
	crt, Sysutils;

const
	META_COUNT_SIZA = 2;
	META_NAME_SIZE = 32;
	META_SIZE_SIZE = 4;

type
	Meta = record
		name: String[META_NAME_SIZE];
		size: String[META_SIZE_SIZE];
	end.

	MetaData = array of Meta;
	
var
  archivo: text;
  s: string;

{----------------------Funciones y procedimientos----------------------}

//Crear Base de datos
procedure crearBaseDeDatos(var archivo:text);
var
	c: string;
begin
	writeln('Esta seguro que desea crear un archivo nuevo?');
	textcolor(12);
	writeln('Cualquier archivo existente sera destruido');
	textcolor(15);
	writeln('Ingrese S/N');
	readln(c);
	if (c = 's') or (c = 'S') then
		begin
			clrscr;
			rewrite(archivo);
			
			writeln('Ingrese la cantidad de campos [1-99]');
			readln(c);
			if (Length(c) < 2) then
				c:= '0' + c;
			writeln(archivo,c);
			
			writeln('Ingrese el nombre del campos');
			readln(c);
			while (Length(c) < 32) do
				c:= c + ' ';
			write(archivo,c);
			
			writeln('Ingrese cantidad de caracteres del campo');
			readln(c);
			agregarCeros(c);
			write(archivo,c);
			
			close(archivo);
			writeln('Archivo creado exitosamente');
			readkey;
		end
	else
		begin
			clrscr;
			textcolor(12);
			writeln('Cancelado, se regresara al menu');
			readkey;
		end;
end;

//Abrir Base de Datos
procedure abrirBaseDeDatos(var archivo);
begin

end;

//Lee el archivo y lo muestra por pantalla
procedure leerArchivo(var archivo:text);
begin
	reset(archivo);
	while not eof(archivo) do
		begin
			readln(archivo, s);
			writeln(s);
		end;
	Close(archivo);
	readkey;
end;

//Menu principal
procedure menu(var archivo:text);
var
	opcion:char;
begin
	repeat
		clrscr;
		textcolor(14);
		gotoxy(2,1);writeln('==Menu Principal==');
		textcolor(10);
		gotoxy(2,3);writeln('1- Crear Base de datos');
		gotoxy(2,5);writeln('2- Abrir Base de datos');
		gotoxy(2,7);writeln('3- Alta');
		gotoxy(2,9);writeln('4- Baja');
		gotoxy(2,11);writeln('5- Modificacion');
		textcolor(12);
		gotoxy(2,13);writeln('0- Salir');
		textcolor(45);
		gotoxy(2,15);writeln('Elija una opcion');
		textcolor(15);
		repeat
			opcion:=readkey;
		until opcion in ['0'..'5'];
		clrscr;
		case opcion of
			'1':crearBaseDeDatos(archivo);
			'2':abrirBaseDeDatos(archivo);
			'3':;
			'4':;
			'5':;
		end;
	until opcion='0';
end;	

BEGIN
	assign(archivo,'db.txt');
	menu(archivo);
	TextColor(NormVideo);
END.
