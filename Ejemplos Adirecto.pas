program Adirecto;
uses
	crt;
type
	cadena40	= string[40];
    Estudiante  = Record
	  Apynom	:cadena40;
	  Codpos	:string[10];
	  Edad	:integer;
	  Sw		:boolean;
    end;

	Fichero	= file of Estudiante;

var
   Arch : Fichero;

//Procedure Metadatos(F);Forward;


procedure Tecla;
var
   Car	:char;
begin
  Gotoxy (1, 24);
  writeln ('presionar cualquier tecla para continuar');
  Car := Readkey;
  Clrscr
end;

procedure Abrir (var F: Fichero);
var
	Resultado : Integer;
begin
	Clrscr;
	{$I-}
	Reset (F);
	Resultado := IOresult;
	{$I+}
	if resultado <> 0 then
		Rewrite (F);
	Close (F)
end;

function Posicion (N :Cadena40; var F:Fichero) :Integer;
var
	Registro :Estudiante;
	Hallado	 :boolean;
begin
	Hallado := false;
	Seek (F, 0);
	while not eof(F) and not Hallado do
		begin
			Read (F, Registro);
			Hallado:= Registro.Apynom = N
		end;
	if Hallado then
		Posicion := Filepos(F) - 1
	else
		Posicion := -1;
end;

procedure Visualizar (E: Estudiante);
begin
	with E do
		if E.Sw then
			begin
				Gotoxy (20, 5); Writeln ('Apellido y Nombre	:', Apynom);
				Gotoxy (20, 6); Writeln ('Codigo Postal		:', Codpos);
                Gotoxy (20, 7); Writeln ('Edad				:', Edad)
			end;
	Tecla
end;

procedure LeerRegistro (var E :Estudiante);
begin
    	with E do
		if Sw then
			begin
				Gotoxy (20, 15); Write ('Apellido y Nombre	:'); readln (Apynom);
				Gotoxy (20, 16); Write ('Codigo Postal		:'); readln (Codpos);
                Gotoxy (20, 17); Write ('Edad				:'); readln (Edad);
				Sw := true
			end;
		Tecla
end;

procedure ListadoTotal (var F: Fichero);
var E: Estudiante;
begin
	Reset (F);
	while not eof(F) do
		begin
			Clrscr;
			writeln ('Registro : ', Filepos (F) + 1 : 1);
			Read (F, E);
			if E.Sw then
				Visualizar (E)
			else
				begin
					Gotoxy  (20, 7);
					Writeln ('Registro vac¡o');
					Tecla
				end
		end;
	Close (F)
end;

procedure Altas (var F :Fichero);
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

procedure Bajas (var F :Fichero);
var
	E: Estudiante;
	N: Cadena40;
	I: Integer;

begin
	Reset (F);
	repeat
		Clrscr;
		Gotoxy (25, 2);
		Writeln ('Bajas');
		Gotoxy (25, 4);
        Writeln ('Ingresar el nombre del estudiante a dar de baja');
		Readln (N);
		I := Posicion (N, F);
		if I = -1 then
			begin
				Gotoxy (20, 11);
				writeln ('Registro Inexistente');
			end
		else
			begin
				Seek (F, I);
				Read (F, E);
				if E.Sw then
					begin
						Visualizar (E);
						E.Sw := false;
						I := Filepos (F) - 1;
						Seek (F, I);
						Write (F, E)
					end;
				Gotoxy (20, 11);
				Writeln ('Registro Eliminado')
			end;
		Tecla;
        Gotoxy (20, 11);
		writeln ('Presionar N para salir');
    until Upcase (readkey) = 'N';
	close (F)
end;

procedure Modificar (var F :Fichero);
var
	E: Estudiante;
	N: Cadena40;
	I: Integer;

begin
	Reset (F);
    repeat
		Clrscr;
		gotoxy (25, 2);
		writeln ('Modificaciones');
		gotoxy(25, 4);
		writeln ('Ingresar el nombre del estudiante a modificar');
		readln (N);
		I:= posicion (N, F);
		if I = -1 then
			begin
				gotoxy (20, 11);
				writeln ('Registro Inexistente')
			end
		else
			begin
				seek (F, I);
				read (F, E);
				if E.Sw then
					begin
						Clrscr;
						Visualizar (E);
                                   gotoxy (20, 13);
						writeln ('Ingresar los nuevos datos');
						LeerRegistro (E);
						I := Filepos (F) - 1;
						seek (F, I);
						write (F, E);
						gotoxy (20, 21);
						writeln ('Registro modificado')
					end
				else
					begin
						gotoxy(20, 11);
						writeln ('Registro Inexistente')
					end
            end;
			Tecla;
			gotoxy (25, 23);
			writeln ('Presionar N para salir')
    until Upcase (readkey) = 'N';
	close (F)
end;

procedure Consultas (var F :Fichero);
var
	E: Estudiante;
	N: Cadena40;
	I: Integer;

begin
	Reset (F);
	repeat
		Clrscr;
	  	gotoxy (25, 2);
		writeln ('Consultas');
		gotoxy(25, 4);
		writeln ('Ingresar el nombre del estudiante a consultar');
		readln (N);
		I:= posicion (N, F);
		if I = -1 then
			begin
				gotoxy (20, 11);
				writeln ('Registro Inexistente')
			end
		else
			begin
				seek (F, I);
				read (F, E);
				if E.Sw then
					begin
						Clrscr;
						Visualizar (E);
					end
				else
					begin
						gotoxy(20, 11);
						writeln ('Registro Inexistente');
						Tecla
					end
        	end;
		Tecla;
		gotoxy (25, 23);
		writeln ('Presionar N para salir')
    until Upcase (readkey) = 'N';
	close (F)
end;

procedure Menu (var F: Fichero);
var
	Opcion : Char;

begin
	repeat
		Clrscr;
		Gotoxy (23, 2) ; Writeln ('Menu Principal');
   		Gotoxy (20, 4) ; Writeln ('1- Altas');
		Gotoxy (20, 6) ; Writeln ('2- Bajas');
		Gotoxy (20, 8) ; Writeln ('3- Modificaciones');
        Gotoxy (20, 10); Writeln ('4- Consultas');
        Gotoxy (20, 12); Writeln ('5- Listado Completo');
//        Gotoxy (20, 14); Writeln ('6- Ver Meta-Datos del Archivo');
        Gotoxy (23, 20); Write ('Elija una opcion: (0-Salida)');
		repeat
			Opcion := readkey
        until Opcion in ['0'..'6'];
		Clrscr;
		case Opcion of
			'1' : Altas (F);
			'2' : Bajas (F);
			'3' : Modificar (F);
			'4' : Consultas (F);
			'5' : ListadoTotal (F)
//			'6' : Metadatos(F)
		end
	until Opcion = '0'
end;

begin
	Clrscr;
	Assign (Arch, 'alumnos.dat');
	Abrir (Arch);
	Menu (Arch)
end.



