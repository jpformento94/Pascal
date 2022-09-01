program BaseDeDatos;

uses
	crt, Sysutils, strutils;

const
	META_COUNT_SIZE = 2;	//Tamaño del campo que cuenta la cantidad de campos [00..99]
	META_NAME_SIZE = 32;	//Tamaño del nombre del campo [32 caracteres]
	META_SIZE_SIZE = 4;		//Tamaño del campo nombre [0000..9999]

type
	Meta = record
		name: String[META_NAME_SIZE];
		size: String[META_SIZE_SIZE];
	end;

	MetaData = array of Meta;
	
var
  archivo: text;
  meta_data: MetaData;
  meta_size: integer;
  NombreArchivo: string;
  
{----------------------Funciones y procedimientos----------------------}

{-----------------Crear Base de datos-----------------}
procedure crearBaseDeDatos();
var
	meta_size_str: String[META_COUNT_SIZE];
	i: integer;
	s: string;
begin
	clrscr;
	
	write('Nombre de la Base de Datos: ');		
	readln(NombreArchivo);
	writeln('');		
	
	{Guarda la cantidad campos que se van a utilizar en los metadatos}		
	write('Ingrese la cantidad de campos [1-99]: ');
	readln(meta_size_str);
	meta_size_str:= Trim(meta_size_str);
	meta_size:= StrToInt(meta_size_str);
	setLength(meta_data, meta_size);
	
	i:= 0;
	{Bucle que pide el nombre del campo y la cantidad de caracteres que ocupa y
	 los carga en el arreglo meta_data}	
	while (i < meta_size) do
		begin
			write('Ingrese el nombre del campo: ');
			readln(s);
			meta_data[i].name:= s;
			writeln('');
			write('Longitud del campo: ');
			readln(s);
			meta_data[i].size:= s;
			writeln('');
			inc(i);
		end;
		clrscr;
		{Creo el archivo con el nombre que ingreso el usuario}
		Assign(archivo, NombreArchivo);
		rewrite(archivo);
		writeln(archivo, PadRight(meta_size_str, META_COUNT_SIZE));
		
		i:= 0;
		{Bucle que pasa los datos del array al archivo y
		* los formatea como se declaro en la metadata}
		while (i < meta_size) do
			begin
				write(archivo, PadRight(meta_data[i].name, META_NAME_SIZE));
				writeln(archivo, PadRight(meta_data[i].size, META_SIZE_SIZE));
				inc(i);
			end;
		close(archivo);
		writeln('');
		writeln('Base de datos creada con exito!!!');
		readln;
end;

{-----------------Abrir Base de Datos-----------------}
procedure abrirBaseDeDatos();
var
	meta_size_str: String[META_COUNT_SIZE];
	i: integer;
	s: string;
begin
	clrscr;
	{Solicita al usuario que ingrese el nombre del archivo de texto}
	write('Ingrese el nombre del archivo: ');
	readln(NombreArchivo);
	Assign(archivo, NombreArchivo);
	reset(archivo);
	
	{Lee la primera linea del archivo y se guarda el valor que indica
	* la cantidad de campos de la metadata}
	readln(archivo, meta_size_str);
	meta_size_str:= Trim(meta_size_str);
	meta_size:= StrToInt(meta_size_str);
	setLength(meta_data, meta_size);
	
	{Lee los metadatos del archivo, y los copia en el arreglo de metadata}
	i:= 0;
	while (i < meta_size) do
		begin
			readln(archivo, s);
			meta_data[i].name:= copy(s, 1, META_NAME_SIZE);
			meta_data[i].size:= copy(s, 1 + META_NAME_SIZE, META_SIZE_SIZE);
			inc(i);
		end;
	close(archivo);
	
	{Muestra los metadatos por pantalla}
	write('Cantidad de campos: ');
	writeln(meta_size);
	writeln('');	
	i:= 0;
	while (i < meta_size) do
		begin
			write(i);
			write('		');
			write(meta_data[i].name);
			write('		');
			write(meta_data[i].size);
			writeln('');
			inc(i);
		end;
	readln;
end;

{-----------------Procedimiento que muestra los registros cargados en el archivo-----------------}
procedure mostrar();
var
	s: string;
	i, j: integer;
begin
	reset(archivo);
	i:= 0;
	j:= 11;
	s:= '';
	{Muestra el nombre de las columnas}
	textcolor(10);
	while (i < meta_size) do
		begin
			write(meta_data[i].name);
			gotoxy(i + j, 1);
			j:= j + 9;
			inc(i);
		end;
	writeln('');
	{Muestra el contenido del archivo}
	i:= 0;
	textcolor(15);
	while not eof(archivo) do
		begin
			if (i > meta_size) then
				begin
					readln(archivo,s);
					writeln(s);
				end
			else
				begin
					readln(archivo,s);
				end;
			inc(i);
		end;
	readln();
end;


{-----------------Procedimiento que agrega un registro al archivo-----------------}
procedure alta();
var
	s: string;
	i, size: integer;
begin
	append(archivo);
	writeln('Nombre de la base de datos: ' + NombreArchivo);
	writeln('');
	i:= 0;
	while i < meta_size do
		begin
			writeln('Ingrese ' + meta_data[i].name);
			readln(s);
			size:= StrToInt(Trim(meta_data[i].size));
			{Si el texto ingresado es mayor al declarado en la meta data
			* lo recorta hasta el maximo de la metadata}
			if (Length(s) > size) then
				begin
					write(archivo, Copy(s,1,size));
				end
			{Si es menor completo con espacios en blanco hasta 
			* el maximo declarado en la meta data}
			else
				begin
					write(archivo, PadRight(s, size));
				end;
			inc(i);
		end;
	{Agrega un enter al archivo}
	write(archivo, char (13));
	close(archivo);
	readln;
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
		gotoxy(2,3);writeln('1- Crear Base de datos');
		gotoxy(2,5);writeln('2- Abrir Base de datos');
		gotoxy(2,7);writeln('3- Ver archivo');
		gotoxy(2,9);writeln('4- Alta');
		gotoxy(2,11);writeln('5- Baja');
		gotoxy(2,13);writeln('6- Modificacion');
		textcolor(12);
		gotoxy(2,15);writeln('0- Salir');
		textcolor(45);
		gotoxy(2,17);writeln('Elija una opcion');
		textcolor(15);
		repeat
			opcion:=readkey;
		until opcion in ['0'..'5'];
		clrscr;
		case opcion of
			'1':crearBaseDeDatos();
			'2':abrirBaseDeDatos();
			'3':mostrar();
			'4':alta();
			'5':;
			'6':;
		end;
	until opcion='0';
end;	

{-----------------App-----------------}
BEGIN
	setLength(meta_data,0);
	menu(archivo);
END.
