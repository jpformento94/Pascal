{HECHO EN GRUPO: MAGALI LATESSA, LUCAS LATESSA, JUAN PABLO FORMENTO}

program ABMHash;

uses 
	crt, SysUtils, StrUtils;
	
const
	HASH_PRIME = 701;	
	
type
	tRegistroColision = record
		Cliente: longint;
		Apellido: string[20];
		Nombres: string[20];
		Estado: boolean;
	end;

	arrayColisiones=array[1..10]of tRegistroColision;

	tRegistro = record
		Cliente: longint;
		Apellido: string[20];
		Nombres: string[20];
		Estado: boolean;
		CantidadColisiones:integer;
		ListaDeColisiones:arrayColisiones; //si hay colision lo ubica en la listaDeColisiones de esa posicion
	end;
	
	tArchivo = file of tRegistro;
	
var 
	archivo: tArchivo;
	reg:tregistro;
	i: integer;

{-----------------Funcion Hash-----------------}
function hash(cliente:longint):integer;
begin
	hash:= cliente mod HASH_PRIME;
end;

{-----------------Funcion que lee un registro del archivo-----------------}
function leer(x:integer):tregistro;
var
	registro:tregistro;
begin
	reset(Archivo);
	seek(Archivo,x);
	read(Archivo,registro);
	close(Archivo);
	leer:=registro;
end;

{-----------------Alta-----------------}
procedure Alta();
var reg: tRegistro;
	regAux:tRegistroColision;
	numeroCliente:string;
begin
	write('Ingrese el nro. de cliente: ');
	readln(numeroCliente);
	if not(leer(hash(strtoint(numeroCliente))).estado) then  //Si no estaba antes..
	begin  
		reset(archivo);
		write('Ingrese el apellido: ');
		readln(reg.Apellido);
		write('Ingrese el nombre: ');
		readln(reg.Nombres);
		reg.estado:=true;
		reg.cliente:=strtoint(numeroCliente);
		reg.CantidadColisiones:=0;
		
	end 
	else 
	begin //Si ya esta ocupado...
		reset(archivo);
		seek(archivo,hash(strtoint(numeroCliente)));
		read(archivo,reg);
		reg.CantidadColisiones+=1;
		write('Ingrese el apellido: ');
		readln(regAux.Apellido);
		write('Ingrese el nombre: ');
		readln(regAux.Nombres);
		regAux.cliente:=strtoint(numeroCliente);
		regAux.estado:=true;
		reg.listaDeColisiones[reg.CantidadColisiones]:=regAux;
		end;
	seek(archivo,hash(reg.cliente));
	write(archivo,reg);
	close(archivo);
	writeln('El registro se ha agregado exitosamente. Presione una tecla para volver al menu.');
	readkey;
end;

{-----------------Baja-----------------}
procedure Baja();
var reg: tRegistro;
	cliente: string;
begin
	reset(archivo);
	clrscr;
	gotoxy(38,1);
	writeln('BAJAS:');
	writeln;
	write('Ingrese el nro. de cliente que desea dar de baja (0 para volver al menu): ');
	readln(cliente);
	if (strtoint(cliente)<>0) then begin
		seek(archivo,hash(strtoint(cliente)));
		read(archivo,reg);
		if reg.Estado then begin
			if reg.cliente=strtoint(cliente) then begin 
				seek(archivo,hash(strtoint(cliente)));
				reg.estado:=false;
				write(archivo,reg);
				writeln ('El registro fue dado de baja');
			end else 
				if reg.CantidadColisiones<>0 then begin 
					i:=reg.CantidadColisiones;
					while i<>0 do begin
						if reg.listaDeColisiones[i].cliente=strtoint(cliente) then begin 
							reg.listaDeColisiones[i].estado:=false;
							seek(archivo,hash(strtoint(cliente)));
							write(archivo,reg);
							writeln ('El registro fue dado de baja');
						end;
					end;
				end else writeln('El numero del cliente no existe');
		end;
	end;
	close(archivo);
end;

{-----------------Modificar carga-----------------}
function ModificarCarga():tRegistro;
var reg:tregistro;
begin
	writeln('Ingrese los nuevos datos');
	write('Ingrese el apellido: ');
	readln(reg.Apellido);
	write('Ingrese el nombre: ');
	readln(reg.Nombres);
	ModificarCarga:=reg;
end;

{-----------------Modificar carga con colision-----------------}
function ModificarCargaColision():tRegistroColision;
var regAux:tRegistroColision; 
begin
	writeln('Ingrese los nuevos datos');
	write('Ingrese el apellido: ');
	readln(regAux.Apellido);
	write('Ingrese el nombre: ');
	readln(regAux.Nombres);
	ModificarCargaColision:=regAux;
end;

{-----------------Modificar-----------------}
procedure Modificar();
var
	reg: tRegistro;
	cliente: string;
	encontre: boolean;
	opcion: string;
	i:integer;
	encontrado:boolean; 
	procedure modificar2();
	begin
		opcion:='N';
		cliente:='100';
		encontre:=false;
		while ((opcion='N') and (cliente<>'-1'))  do begin
			reset(archivo);
			write('Ingrese el nro. de cliente que desea modificar (-1 para volver al menu): ');
			readln(cliente);
			if cliente<>'-1' then begin
				seek(archivo,hash(strtoint(cliente)));
				read(archivo,reg);
				writeln('APELLIDO              NOMBRES               NRO. CLIENTE');
				writeln;

			if (reg.cliente=strtoint(cliente)) then begin
					writeln(reg.Apellido+'          '+reg.Nombres+'          '+IntToStr(reg.Cliente));
					writeln;
					writeln('Este es el registro que desea modificar? S/N.');
					readln(opcion);
				end else if reg.CantidadColisiones<>0 then begin
							i:=reg.CantidadColisiones;
							while (i<>0) and not(encontre) do begin 
								if reg.listaDeColisiones[i].cliente=strtoint(cliente) then begin 
									encontre:=true;
									writeln(reg.listaDeColisiones[i].Apellido+'          '+reg.listaDeColisiones[i].Nombres+'          '+IntToStr(reg.listaDeColisiones[i].Cliente));
									writeln;	
									writeln('Este es el registro que desea modificar? S/N.');
									readln(opcion);
								end;
							end;
						end;
			end;
		end;
		close(archivo);
	end;
begin
    clrscr;
	i:=0;
	gotoxy(38,1);
	writeln('MODIFICAR:');
	writeln;
	modificar2();
	reset(archivo);
	encontrado:=false;
	if (reg.cliente=strtoint(cliente)) then begin 
			reg:=ModificarCarga();
			reg.cliente:=strtoint(cliente);
			seek(archivo,hash(strtoint(cliente)));
			write(archivo,reg);
			encontrado:=true;
		end else begin
				if reg.listaDeColisiones[i].cliente=strtoint(cliente) then begin 
					seek(archivo,hash(strtoint(cliente)));
					reg.listaDeColisiones[i]:=ModificarCargaColision();
					reg.listaDeColisiones[i].cliente:=strtoint(cliente);
					write(archivo,reg);	
					encontrado:=true;
				end;
			end;
	if encontrado then begin 
			writeln('El registro se ha modificado exitosamente. Presione una tecla para volver al menu.');
			readkey;
	end else if cliente<>'-1' then begin
			writeln('No existe ningun registro con el nro. de cliente ingresado.');
			writeln('Presione una tecla para continuar.');
			readkey;
		end;
	close(archivo);
end;

{-----------------Ver archivo-----------------}
procedure Mostrar;
var reg: tRegistro;
	vacio: boolean;
	i:integer;
begin
	clrscr;
	gotoxy(13,1);
	TextColor(10);             
	writeln('--------REGISTROS---------');
	writeln;
	reset(archivo);
	writeln('|'+PadRight('Apellido', 			        20) + '| |'+
					PadRight('Nombres',                   20) + '| |'+
					'Cliente'								  +'|');
	TextColor(15);
	writeln('________________________________________________________________');
	while not eof(archivo) do begin
		read(archivo,reg);
		if reg.Estado then begin
			vacio:=false;
			writeln('|'+PadRight(reg.Apellido, 			        20) + '| |'+
					PadRight(reg.Nombres,                   20) + '| | '+
					PadRight(IntToStr(reg.Cliente),          4)+'  |');
		end;
	end;
	close(archivo);
	reset(archivo);
	TextColor(10); 
	writeln('             --------COLISIONES--------');
	TextColor(15);
	while not eof(archivo) do begin
		read(archivo,reg);
		if (reg.CantidadColisiones<>0) and (reg.Estado) then //Mostrar colisiones
		begin 
			i:=reg.CantidadColisiones;
			while i<>0 do begin
				writeln('|'+PadRight(reg.listaDeColisiones[i].Apellido, 			        20) + '| |'+ 
					PadRight(reg.listaDeColisiones[i].Nombres,                   20) + '| | '+
					PadRight(IntToStr(reg.listaDeColisiones[i].Cliente),          4)+'  |');			
					dec(i);
			end;
		end;
	end;
	close(archivo);
	if vacio then writeln('El archivo no posee ningun registro.')
	else writeln;
	textcolor(45);
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
		gotoxy(2,7);writeln('3- Modificar');
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
			i := 0;		
			reg.Cliente := 0;
			reg.Apellido := '';
			reg.Nombres := '';
			reg.Estado := false;
			reg.CantidadColisiones:=0;		
			while (i < HASH_PRIME) do begin
				write(archivo,reg);	
				inc(i);
			end;	
			close(archivo);
		end;
	menu();
END.

