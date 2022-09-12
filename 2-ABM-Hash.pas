program ABMHash;

uses 
	crt, SysUtils;
	
type
	tregistro = record
		apellido: string[20];
		nombres: string[20];//nombre
		cliente: word;//numero
		estado: boolean;
	end;

	TipoArchivo = file of tregistro;
	
var 
	archivo: TipoArchivo;
	reg: tregistro;

function hash(cliente:integer):integer;
begin
	hash:= cliente mod 691;
end;

function leer(x:integer):tregistro;
var
	registro:tregistro;
begin
	reset(Archivo);
	seek(Archivo,x);
	read(Archivo,registro);
	leer:=registro;
	close(Archivo);
end;
function recuperar(cliente:integer):tregistro;
var
	reg2:tregistro;
begin
	reg2:=leer(hash(cliente));
	writeln(reg2.estado,reg2.nombres,reg2.apellido, reg2.cliente);
	if (reg2.estado) and (reg2.cliente <> cliente) then begin
		reset(Archivo);
		if reg2.cliente <> cliente then begin
			seek(Archivo,692);
			while (not eof(archivo)) and (cliente <> reg2.cliente) do begin
				read(archivo,reg2);
			end;
		end;

		if cliente = reg2.cliente then
			recuperar:= reg2
		else
			recuperar.estado:=false;
	close(archivo);
	end else begin
		recuperar:=reg2;
	end;
end;

procedure Alta;
var reg: tRegistro;
begin
	write('Ingrese el apellido: ');
	readln(reg.Apellido);
	write('Ingrese el nombre: ');
	readln(reg.Nombres);
	write('Ingrese el nro. de cliente: ');
	read(reg.Cliente);
	while (reg.Cliente<=0) or (reg.Cliente>9999) or recuperar(reg.cliente).estado do begin
		write('Error. Reingrese el nro. de cliente: ');
		read(reg.Cliente);
	end;
	reg.Estado:= true;
	if leer(hash(reg.cliente)).estado then begin
		reset(archivo);
		seek(archivo,filesize(archivo));
	end else begin
		reset(archivo);
		seek(archivo,hash(reg.cliente));
	end;
	write(archivo,reg);
	close(archivo);
	writeln('El registro se ha agregado exitosamente. Presione una tecla para volver al menu.');
	readkey;
end;

procedure Mostrar;
var reg: tRegistro;
	vacio: boolean;
begin
	clrscr;
	gotoxy(36,1);
	writeln('REGISTROS:');
	writeln;
	vacio:= true;
	reset(archivo);
	while not eof(archivo) do begin
		read(archivo,reg);
		if reg.Estado then begin
			if vacio then begin
				writeln('APELLIDO              NOMBRES               NRO. CLIENTE');
				writeln;
				vacio:= false;
			end;
			writeln(reg.Apellido+' '+reg.Nombres+' '+IntToStr(reg.Cliente)+' '+inttostr(FilePos(archivo)));
		end;
	end;
	close(archivo);
	if vacio then writeln('El archivo no posee ningun registro.')
	else writeln;
	writeln('Presione una tecla para volver al menu.');
	readkey;
end;

procedure Baja;
var reg: tRegistro;
	cliente: word;
	encontre: boolean;
begin
	clrscr;
	gotoxy(38,1);
	writeln('BAJAS:');
	writeln;
	write('Ingrese el nro. de cliente que desea dar de baja (0 para volver al menu): ');
	readln(cliente);
	while cliente>9999 do begin
		write('Error. Reingrese el nro. de cliente: ');
		readln(cliente);
	end;
	if cliente<>0 then
                reset(archivo);
	while cliente<>0 do
              begin
		encontre:= false;
		seek(archivo,0);
		while (not eof(archivo)) and (not encontre) do begin
			read(archivo,reg);
			if reg.Estado then encontre:= cliente=reg.Cliente;
		end;
		if encontre then begin
			writeln('APELLIDO              NOMBRES               NRO. CLIENTE');
			writeln;
			writeln(reg.Apellido+'          '+reg.Nombres+'          '+IntToStr(reg.Cliente));
			writeln;
			writeln('Presione una tecla para dar de baja el registro.');
			readkey;
			reg.Estado:= false;
			seek(archivo,filepos(archivo)-1);
			write(archivo,reg);
		end else begin
			writeln('No existe ningun registro con el nro. de cliente ingresado.');
			writeln('Presione una tecla para continuar.');
			readkey;
		end;
		clrscr;
		gotoxy(38,1);
		writeln('BAJAS:');
		writeln;
		write('Ingrese el nro. de cliente que desea dar de baja (0 para volver al menu): ');
		readln(cliente);
		while cliente>9999 do begin
			write('Error. Reingrese el nro. de cliente: ');
			readln(cliente);
		end;
	end;
	close(archivo);
end;

procedure Modificar;
var
   reg: tRegistro;
   cliente: word;
   encontre: boolean;
   opcion: char;
begin
        clrscr;
       encontre:= false;
	gotoxy(38,1);
	writeln('MODIFICAR:');
	writeln;
	write('Ingrese el nro. de cliente que desea dar de baja (0 para volver al menu): ');
	readln(cliente);
	while cliente>9999 do begin
		write('Error. Reingrese el nro. de cliente: ');
		readln(cliente);
	end;
	if cliente<>0 then
                reset(archivo);
              begin

		seek(archivo,0);
		while (not eof(archivo)) and (not encontre) do

                      begin
			read(archivo,reg);
			if reg.Estado then encontre:= cliente=reg.Cliente;
		      end;
               if encontre then
                    begin

			writeln('APELLIDO              NOMBRES               NRO. CLIENTE');
			writeln;
			writeln(reg.Apellido+'          '+reg.Nombres+'          '+IntToStr(reg.Cliente));
			writeln;
			writeln('¿Este es el registro que desea modificar? S/N.');
                        readln(opcion);
                                       if ((opcion = 'S') or (opcion = 's')) then
                                            begin
                                                writeln('Ingrese los nuevos datos');
                                                write('Ingrese el apellido: ');
                                                readln(reg.Apellido);
	                                        write('Ingrese el nombre: ');
                                                readln(reg.Nombres);

                                            end;

                    end
               else
                       begin
	                      writeln('No existe ningun registro con el nro. de cliente ingresado.');
	                      writeln('Presione una tecla para continuar.');
	                      readkey;
                       end;

              end;

                         if encontre then
                            begin
		                 reset(archivo);
	                         seek(archivo,(reg.cliente));
	                         write(archivo,reg);
	                         close(archivo);
	                         writeln('El registro se ha modificado exitosamente. Presione una tecla para volver al menu.');
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
	assign(archivo,'datosHash.dat');
	if not (fileexists('datosHash.dat')) then 
		begin
			rewrite(archivo);
			close(archivo);
		end;
	menu();
END.

