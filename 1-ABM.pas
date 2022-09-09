program ABM;

uses
	crt, SysUtils;

type
	TipoCliente = record
		apellido: string[20];
		nombre: string[20];
		numero: integer;
		estado: boolean;
	end;

	Archivo = file of TipoCliente;
	
var 
	a: Archivo;

{-----------------Abre el archivo y si no existe lo crea-----------------}
procedure abrir (var f: archivo);
var
	resultado : Integer;
begin
	{$I-}
	reset (f);
	resultado := IOresult;
	{$I+}
	if resultado <> 0 then
		rewrite (f);
	close (f);
end;

{-----------------Procedimiento que agrega un registro al archivo-----------------}
procedure alta();
var 
	cliente: TipoCliente;
	pos: integer;
begin
	clrscr;
	
	TextColor(10);
	writeln('<=====Alta=====>');
	writeln('');
	
	TextColor(15);
	write('Ingrese el apellido: ');
	readln(cliente.apellido);
	writeln('');
	
	write('Ingrese el nombre: ');
	readln(cliente.nombre);
	writeln('');
	
	write('Ingrese el numero de cliente: ');
	readln(cliente.numero);
	while (cliente.numero <= 0) or (cliente.numero > 9999) do
		begin
			TextColor(red);
			writeln('');
			writeln('Error, el numero de cliente debe ser mayor a cero y de 4 digitos: ');
			TextColor(15);
			readln(cliente.numero);
		end;
		
	cliente.estado:= true;
	TextColor(15);
	reset(a);
	pos:= filesize(a);
	seek(a,pos);
	write(a,cliente);
	close(a);
	writeln('');
	writeln('El registro se ha agregado exitosamente. Presione una tecla para volver al menu.');
	readkey;
end;

{-----------------Procedimiento que borra un registro del archivo-----------------}
procedure baja();
var 
	cliente: TipoCliente;
	pos: integer;
	opcion: char;
begin
	clrscr;
	write('Ingrese la posicion del cliente que desea dar de baja: ');
	readln(pos);
	while (pos <= 0) or (pos > 9999) do 
		begin
			writeln;
			TextColor(red);
			write('Error, reingrese el nunero de cliente: ');
			TextColor(15);
			readln(pos);
		end;
	clrscr;	
	reset(a);
	if (filesize(a) >= pos) then
		begin
			seek(a, pos - 1);
			read(a, cliente);
			if (cliente.estado = true)then
				begin
					write('Borrar a ');
					write(cliente.apellido);
					write(' ');
					write(cliente.nombre);
					write(' ');
					write(cliente.numero);
					write(' ? (S/N)');
					readln(opcion);
					if (opcion = 's') or (opcion = 'S') then
						begin
							cliente.estado:= false;
							seek(a, pos - 1);
							write(a, cliente);
							writeln();
							writeln('Cliente dado de baja');
						end
					else
						begin
							writeln();
							writeln('El cliente no fue dado de baja');
						end;						
				end
			else
				writeln('El cliente ya se encuentra dado de baja');
		end;
	close(a);
	readkey;
end;

{-----------------Procedimiento que muestra los registros cargados en el archivo-----------------}
procedure mostrar();
var
	cliente: TipoCliente;
	p: integer;
begin
	clrscr;
	reset(a);
	textcolor(10);
	gotoxy(4,1);
	write('Apellido');
	gotoxy(25,1);
	write('Nombre');
	gotoxy(45,1);
	write('Cliente');
	writeln('');
	textcolor(15);
	p:= 2;
	while not eof(a) do begin
		read(a,cliente);
		if (cliente.estado = true) then 
			begin	
				gotoxy(1,p);
				write(inttostr(FilePos(a)));
				gotoxy(4,p);
				write(cliente.apellido);
				gotoxy(25,p);
				write(cliente.nombre);
				gotoxy(46,p);
				write(IntToStr(cliente.numero));
				writeln;
				inc(p);
			end;
	end;
	close(a);
	writeln;
	writeln('Presione una tecla para volver al menu.');
	readkey;
end;

{-----------------Menu principal-----------------}
procedure menu();
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
			'3':;//modificar();
			'4':mostrar();
		end;
	until opcion='0';
end;	

BEGIN
	assign(a,'datos.dat');
	abrir(a);
	menu();
END.
