program ej_1;

uses crt;

var
	lluvias:text;
	
procedure crear_archivo(var lluvias:text);

var
	seguir:string;
	d,m,a,p:word;

begin
	rewrite(lluvias);
	seguir:='si';
	while (seguir='si') do
		begin
			write('Ingrese Dia: ');
			readln(d);
			write('Ingrese mes: ');
			readln(m);
			write('Ingrese anio: ');
			readln(a);
			write('Ingrese Precipitaciones en milimetros: ');
			readln(p);
			writeln(lluvias,d,' ',m,' ',a,' ',p);
			write('Si desea continuar igresando datos ingrese si: ');
			readln(seguir);
			clrscr;
		end;	
	close(lluvias);	
end;	
			
procedure dias_que_llovio(var lluvias:text);

var
	d,m,a,p,lloviomenos,lloviomas,nollovio:word;
	
begin
	nollovio:=0;
	lloviomenos:=0;
	lloviomas:=0;
	reset(lluvias);
	while not eof(lluvias) do
		begin
			readln(lluvias,d,m,a,p);
			if (p=0) then nollovio:=nollovio+1;
			if (p<50) and (p>0) then lloviomenos:=lloviomenos+1;
			if (p>=50) then lloviomas:=lloviomas+1;
		end;
	close(lluvias);
	clrscr;
	writeln('No llovio ',nollovio,' dias');
	writeln;
	writeln('Llovio menos de 50 mm ',lloviomenos,' dias');
	writeln;
	writeln('Llovio mas de 50 mm ',lloviomas,' dias');
	readln();
end;			
				
BEGIN
	assign(lluvias,'D:\Programas en Pascal 2015\lluvias.txt');
	crear_archivo(lluvias);
	dias_que_llovio(lluvias);
END.
