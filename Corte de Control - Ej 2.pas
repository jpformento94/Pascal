program ej_2;

uses crt;

var
	f:text;
	
procedure corte_de_control(var f:text);

var
	emp,suc,dep,sueldo,totaldep,totalsuc,sucant,depant:word;

begin
	totaldep:=0;
	totalsuc:=0;
	reset(f);
	read(f,emp,suc,dep,sueldo);
	sucant:=suc;
	while not eof(f) do
		begin
			while (suc=sucant) and (not eof(f)) do
				begin
					depant:=dep;
					while (dep=depant) and (suc=sucant) and (not eof(f)) do
						begin
							totaldep:=totaldep+sueldo;
							read(f,emp,suc,dep,sueldo);
						end;		
					if (dep<>depant) then
						begin
							totalsuc:=totalsuc+totaldep;
							Writeln('Sucursal ',sucant);
							writeln('Departamento ',depant);
							writeln('Total de sueldos ',totaldep);
							writeln;
							readkey;
						end
					else
						begin
							if (suc<>sucant) then
								begin
									totaldep:=totaldep+sueldo;
									totalsuc:=totalsuc+totaldep;
									Writeln('Sucursal ',sucant);
									writeln('Departamento ',depant);
									writeln('Total de sueldos ',totaldep);
									writeln;
									readkey;
								end;	
	end;		
					totaldep:=0;	
				end;
			if (suc<>sucant) then		
				begin
					writeln('Sucursal ',sucant);
					writeln('Total de sueldos ',totalsuc);
					totalsuc:=0;
					sucant:=suc;
					readkey;
					clrscr;
				end;	
		end;
	totaldep:=totaldep+sueldo;
	totalsuc:=totalsuc+totaldep;	
	Writeln('Sucursal ',sucant);
	writeln('Departamento ',depant);
	writeln('Total de sueldos ',totaldep);
	readkey;
	close(f);
end;	
	
BEGIN
	assign(f,'D:\Programas en Pascal 2015\sueldos.txt');
	corte_de_control(f);
END.
