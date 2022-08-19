program Ej5_Secuencial;

uses crt;

var t:text;
	sexo,edad,ecivil,trabaja,estudia:byte;
	
procedure cargar_encuestas(var t:text;var sexo,edad,ecivil,trabaja,estudia:byte);

var
	seguir:byte;

begin
	rewrite(t);
	clrscr;
	seguir:=1;
	while (seguir<>0) do
		begin
			writeln('Ingrese sexo, 1:varon, 2:mujer');
			readln(sexo);
				while (sexo<>1) and (sexo<>2) do
					begin
						clrscr;
						writeln('Error sexo solo puede ser 1:varon, 2:mujer');
						readln(sexo);
					end;
			clrscr;
			writeln('Ingrese edad');
			readln(edad);
			clrscr;
			writeln('Ingrese estado civil, 1:soltero, 2:casado, 3:otros');
			readln(ecivil);
				while (ecivil<>1) and (ecivil<>2) and (ecivil<>3) do
					begin
						clrscr;
						writeln('Error estado civil solo puede ser 1:soltero, 2:casado, 3:otros');
						readln(ecivil);
					end;	
			clrscr;
			writeln('Ingrese trabaja?, 0:no, 1:si');
			readln(trabaja);
				while (trabaja<>0) and (trabaja<>1) do
					begin
						clrscr;
						writeln('Error si trabaja, 0:no, 1:si');
						readln(trabaja);
					end;
			clrscr;
			writeln('Ingrese estudia?, 0:no, 1:si');
			readln(estudia);
				while (estudia<>0) and (estudia<>1) do
					begin
						clrscr;
						writeln('Error si estudia, 0:no, 1:si');
						readln(estudia);
					end;	
			writeln(t,sexo,' ',edad,' ',ecivil,' ',trabaja,' ',estudia);
			writeln;
			clrscr;
			writeln('Si desea salir ingrese 0');
			readln(seguir);
			clrscr;
		end;	
	close(t);
end;

procedure leer_estadisticas(var t:text);

var
	varo,mujer,total,menores,solte,casad,tye,mujtrab:byte;
	
begin
	varo:=0;
	mujer:=0;
	total:=0;
	menores:=0;
	solte:=0;
	casad:=0;
	tye:=0;
	mujtrab:=0;
	reset(t);
	clrscr;
	while not eof(t) do
		begin
			readln(t,sexo,edad,ecivil,trabaja,estudia);
			if (sexo=1) then
				varo:=varo+1
			else
				mujer:=mujer+1;
			if (edad<18) and (trabaja=1) then
				menores:=menores+1;
			if (ecivil=1) then
				solte:=solte+1;
			if (ecivil=2) then
				casad:=casad+1;
			if (trabaja=1) and (estudia=1) then
				tye:=tye+1;
			if (sexo=2) and (trabaja=1) then
				mujtrab:=mujtrab+1;
		end;
	close(t);
	total:=varo+mujer;
	writeln('El porcentaje de varones es: ',(varo*100)/total:5:2);
	writeln;
	writeln('El porcentaje de mujeres es: ',(mujer*100)/total:5:2);
	writeln;
	writeln('El porcentaje de menores que trabajan es: ',(menores*100)/total:5:2);
	writeln;
	writeln('El porcentaje de solteros es: ',(solte*100)/total:5:2);
	writeln;
	writeln('El porcentaje de casados es: ',(casad*100)/total:5:2);
	writeln;
	writeln('El porcentaje de encuestados que trabajan y estudian es: ',(tye*100)/total:5:2);
	writeln;
	writeln('El porcentaje de mujeres que trabajan es: ',(mujtrab*100)/total:5:2);
	readkey;
end;	
	
BEGIN
	textcolor(10);
	assign(t,'D:\Programas en Pascal\encuestas.txt');
	cargar_encuestas(t,sexo,edad,ecivil,trabaja,estudia);
	leer_estadisticas(t);
END.

