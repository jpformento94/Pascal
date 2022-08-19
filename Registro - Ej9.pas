program Ej9_Registro;

uses crt;

const
	max=10;

type
	un_trabajador=record
		nombre,sexo,estadocivil:string[20];
		edad:byte;
		salariobase:real;
	end;
	
	trabajadores=array[1..max]of un_trabajador;

var
	t:trabajadores;

procedure cargar_trabajadores(var t:trabajadores);

var
	i:byte;
	
begin
	for i:=1 to max do
		begin
			gotoxy(1,2);
			writeln('Ingrese el nombre');
			readln(t[i].nombre);
			clrscr;
			gotoxy(1,2);
			writeln('Ingrese sexo: masculino o femenino');
			readln(t[i].sexo);
			clrscr;
			gotoxy(1,2);
			writeln('Ingrese estado civil: soltero,viudo,divorciado,casado o soltera,viuda,divorciada,casada');
			readln(t[i].estadocivil);
			clrscr;
			gotoxy(1,2);
			writeln('Ingrese edad');
			readln(t[i].edad);
			while (t[i].edad<0) or (t[i].edad>120) do
					begin
						writeln('Error, la edad no puede ser menor a 0 o mayor a 120');
						readln(t[i].edad);
					end;	
			clrscr;
			gotoxy(1,2);
			writeln('Ingrese salario base');
			readln(t[i].salariobase);
			clrscr;
		end;	
end;

procedure mostrar_trabajadores(v:trabajadores);

var
	i:byte;
	contadorm,contadorcas,menor,joven:byte;
	salariototal:real;
	trabmasc,mujcasadas:string[20];
	
begin
	trabmasc:='masculino';
	mujcasadas:='casada';
	salariototal:=0;
	contadorm:=0;
	contadorcas:=0;
	menor:=120;
	for i:=1 to max do
		begin
			if (t[i].sexo=trabmasc) then
				contadorm:=contadorm+1;
			if (t[i].estadocivil=mujcasadas) then
				contadorcas:=contadorcas+1;
			if (t[i].edad<menor) then
				begin
					menor:=t[i].edad;
					joven:=i;
				end;
			salariototal:=salariototal+t[i].salariobase;
		end;
	writeln('Cantidad total de trabajadores masculinos: ',contadorm);
	writeln;
	writeln('Cantidad de trabajadoras casadas: ',contadorcas);
	writeln;
	writeln('El empleado mas joven es: ',t[joven].nombre,' con ',t[joven].edad,' anios');
	writeln;
	writeln('La suma total de los salarios es de: $',salariototal:5:2);				
end;				



BEGIN
	textcolor(10);
	cargar_trabajadores(t);
	mostrar_trabajadores(t);
END.

