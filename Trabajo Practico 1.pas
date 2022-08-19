program tp_obligatorio_1;  //Comparación de distintos metodos de búsqueda//

uses 
	crt,dos;
const 
	min=1;
	med=50000;
	max=100000;
type
	vector=array[min..max]of longint;
	contadores=array[1..6]of longint;
	vector2=array[min..med]of longint;
	contadores2=array[1..2]of longint;
var
	v:vector;
	b,ins,sh:contadores;
	buli,bubi:contadores2;
	t:vector2;
	eleccion:byte;
	salir:boolean;
	
procedure error;  //Eleccion no valida//
Begin
    GotoXY(2,24);
    writeln;
    Write('No corresponde a ninguna opcion valida');
    Readkey;
End;

//Comienzo de la Parte 1//

procedure aleatorio(var v:vector);  //Carga de un vector aleatorio//
	var i:longint;
	begin
		randomize;
		for i:=min to max do
		(v[i]):=random(65000);
		clrscr;
		writeln;
		writeln('Vector creado con exito!!!!');
		writeln;
		writeln('Presione una tecla para continuar');
		readkey;
	end;
			
procedure vector_ascendente(var v:vector);  //Carga de un vector ascendente//
	var i:longint;
	begin
		for i:=min to max do
			v[i]:=i;
		clrscr;
		writeln;
		writeln('Vector creado con exito!!!!');
		writeln;
		writeln('Presione una tecla para continuar');
		readkey;
	end;	
			
procedure vector_descendente(var v:vector);  //Carga de un vector descendente//
	var i,j:longint;
	begin
	j:=max;
		for i:=min to max do
			begin
				v[i]:=j;
				j:=j-1;
			end;	
		clrscr;	
		writeln;
		writeln('Vector creado con exito!!!!');
		writeln;
		writeln('Presione una tecla para continuar');
		readkey;
	end;	

procedure mostrar_vector(v:vector);                       //Muestra el vector ordenado//
var
	n:string;
	i:longint;
	fila,col:integer;
begin
	clrscr;
	writeln;
	writeln('Desea ver el vector?');
	writeln;
	writeln('Responda si o no');
	writeln;
	readln(n);
	while (n<>'si') and (n<>'no') do
		begin
			writeln('Error en el ingreso, ingrese si o no');
			readln(n);
		end;
	clrscr;	
	begin                                             //Muestra el vector por pantallas//
		clrscr;
		writeln('Vector ordenado con exito');
		i:=min;
		while (n='si') and (i<=max) do
			begin
				col:=1;
				while (col<=72) and (i<=max) do
					begin
						fila:=2;
						while (fila<=20) and (i<=max) do
							begin
								gotoxy(col,fila);
								write(V[i]);
								i:=i+1;
								fila:=fila+1;
							end;	
						col:=col+7;
					end;
				gotoxy(1,22);
				write('Continua mostrando, si o no?');
				writeln;
				readln(n);	
			end;							
	end;		
	readkey;
end;

procedure vector_original(v:vector);                    //Muestra el vector original//
var
	n:string;
	i:longint;
	fila,col:integer;
begin
	clrscr;
	writeln('El vector original es:');
	i:=min;
	n:='si';
	begin
	while (n='si') and (i<=max) do
		begin                                         //Muestra el vector por pantallas//
			col:=1;
				while (col<=72) and (i<=max) do
					begin
						fila:=2;
						while (fila<=20) and (i<=max) do
							begin
								gotoxy(col,fila);
								write(V[i]);
								i:=i+1;
								fila:=fila+1;
							end;	
						col:=col+7;
					end;
				gotoxy(1,22);
				write('Continua mostrando, si o no?');
				writeln;
				readln(n);	
		end;						
	if (n='no') then
	writeln('Vector mostrado con exito');
	end;		
	readkey;
end;
			
procedure burbujeo_mejorado(v:vector;var b:contadores);  //Burbujeo mejorado//
	var
		h,m,s,c,hi,hf,ht,iteraciones,intercambios:word;
		j,i,aux:longint;
		ordenado:boolean;
	begin
	clrscr;
	writeln;
	writeln('Por favor aguarde mientras el vector se ordena');
	iteraciones:=0;
	intercambios:=0;
	gettime(h,m,s,c);
	hi:=((h*60+m)*60+s)*100+c;
	j:=1;
	ordenado:=false;
	while (not ordenado) and (j<max) do
		begin
			ordenado:=true;
			for i:=min to max-j do
				if v[i]>v[i+1] then
					begin
						aux:=v[i];
						v[i]:=v[i+1];
						v[i+1]:=aux;
						ordenado:=false;
						intercambios:=intercambios+1;
					end;
		j:=j+1;
		iteraciones:=iteraciones+1;
		end;
	gettime(h,m,s,c);
	hf:=((h*60+m)*60+s)*100+c;
	ht:=hf-hi;
	b[4]:=ht mod 100;                    //Centesimas finales//
	s:=ht div 100;
	b[3]:=s mod 60;                     //Segundos finales//
	b[2]:=(s div 60)mod 60;             //Minutos finales//
	b[1]:=(s div 60)div 60;             //Horas finales//  
	b[5]:=iteraciones;
	b[6]:=intercambios;    
	clrscr;        
	gotoxy(2,2);
	writeln('Se tardo ',b[1],' horas ',b[2],' minutos ',b[3],' segundos ',b[4],' centesimas');
	gotoxy(2,4);
	writeln('Realizo ',b[5],' iteraciones y ',b[6],' intercambios.');
	gotoxy(2,6);
	writeln('Presione una tecla para continuar');
	readkey;
	mostrar_vector(v);
	end;		
	
procedure insercion (v:vector;var ins:contadores);  //Insercion//
	var
		h,m,s,c,hi,hf,ht,iteraciones,intercambios:word;
		j,i,item:longint;
	begin
		clrscr;
		writeln;
		writeln('Por favor aguarde mientras el vector se ordena');
		iteraciones:=0;
		intercambios:=0;
		gettime(h,m,s,c);
		hi:=((h*60+m)*60+s)*100+c;
		for i:=2 to max do
		begin
			item:=v[i];
			j:=i-1;
			while (j>0) and (v[j]>item) do
			begin
				v[j+1]:=v[j];
				j:=j-1;
				intercambios:=intercambios+1;
			end;
			v[j+1]:=item;
			iteraciones:=iteraciones+1;
		end;
		gettime(h,m,s,c);
		hf:=((h*60+m)*60+s)*100+c;
		ht:=hf-hi;
		ins[4]:=ht mod 100;                    //Centesimas finales//
		s:=ht div 100;
		ins[3]:=s mod 60;                     //Segundos finales//
		ins[2]:=(s div 60)mod 60;             //Minutos finales//
		ins[1]:=(s div 60)div 60;             //Horas finales//      
		ins[5]:=iteraciones;
		ins[6]:=intercambios;    
		clrscr;        
		gotoxy(2,2);
		writeln('Se tardo ',ins[1],' horas ',ins[2],' minutos ',ins[3],' segundos ',ins[4],' centesimas');
		gotoxy(2,4);
		writeln('Realizo ',ins[5],' iteraciones y ',ins[6],' intercambios.');
		gotoxy(2,6);
		writeln('Presione una tecla para continuar');
		readkey;
		mostrar_vector(v);
	end;

procedure shell(v:vector;var sh:contadores);
var 
	i,j,aux,intv:longint;
	h,m,s,c,hi,hf,ht,iteraciones,intercambios:word;   
 BEGIN     
	clrscr;
	writeln;
	writeln('Por favor aguarde mientras el vector se ordena');
	iteraciones:=0;
	intercambios:=0;
	gettime(h,m,s,c);
	hi:=((h*60+m)*60+s)*100+c;	
    intv:=max div 2;                //Comienza shell//
    while intv>0 do  
		begin
			for i:=intv to max do
				begin	
					aux:=v[i];   
					j:=i-intv;   
					while ((j>=0) and (aux<v[j])) do 
						begin
							v[j+intv]:=v[j]; 
							j:=j-intv;
							intercambios:=intercambios+1;
						end;
					v[j+intv]:=aux                   
				end;
           intv:=intv DIV 2 ;
           iteraciones:=iteraciones+1;
       END;
	gettime(h,m,s,c);
	hf:=((h*60+m)*60+s)*100+c;
	ht:=hf-hi;
	sh[4]:=ht mod 100;                    //Centesimas finales//
	s:=ht div 100;
	sh[3]:=s mod 60;                     //Segundos finales//
	sh[2]:=(s div 60)mod 60;             //Minutos finales//
	sh[1]:=(s div 60)div 60;             //Horas finales//      
	sh[5]:=iteraciones;
	sh[6]:=intercambios;    
	clrscr;        
	gotoxy(2,2);
	writeln('Se tardo ',sh[1],' horas ',sh[2],' minutos ',sh[3],' segundos ',sh[4],' centesimas');
	gotoxy(2,4);
	writeln('Realizo ',sh[5],' iteraciones y ',sh[6],' intercambios.');
	gotoxy(2,6);
	writeln('Presione una tecla para continuar');
	readkey;
	mostrar_vector(v);    
 end;

procedure tabla_estadisticas(b,ins,sh:contadores);           //Tabla de estadisticas//
begin
	clrscr;
	textcolor(30);
	gotoxy(30,2);
	writeln('Tabla de comparaciones');
	textcolor(10);
	writeln('================================================================================');
	textcolor(45);
	gotoxy(1,4);
	writeln('Burbujeo mejorado: se realizo en ',b[1],' hs. ',b[2],' min. ',b[3],' seg. ',b[4],' cent. ');
	writeln('                   se realizaron ',b[5],' iteraciones y ',b[6],' intercambios.');
	textcolor(10);
	writeln('================================================================================');
	textcolor(31);
	writeln('Insercion: se realizo en ',ins[1],' hs. ',ins[2],' min. ',ins[3],' seg. ',ins[4],' cent. ');
	writeln('           se realizaron ',ins[5],' iteraciones y ',ins[6],' intercambios.');
	textcolor(10);
	writeln('================================================================================');
	textcolor(9);
	writeln('Shell: se realizo en ',sh[1],' hs. ',sh[2],' min. ',sh[3],' seg. ',sh[4],' cent. ');
	writeln('       se realizaron ',sh[5],' iteraciones y ',sh[6],' intercambios.');
	textcolor(10);
	writeln('================================================================================');
	textcolor(12);
	writeln;
	writeln('Presione cualquier tecla para retornar al menu principal');
	readkey;
end;

//Comienzo de la parte 2//

procedure aleatorio_2(var t:vector2);  //Carga de un vector aleatorio//
	var i:longint;
	begin
		randomize;
		for i:=min to med do
		(t[i]):=random(5001)-2500;
		clrscr;
		writeln;
		writeln('Vector creado con exito!!!!');
		writeln;
		writeln('Presione una tecla para continuar');
		readkey;
	end;

procedure vector_original_2(t:vector2);                    //Muestra el vector original//
var
	n:string;
	i:longint;
	fila,col:integer;
begin
	clrscr;
	writeln('El vector original es:');
	i:=min;
	n:='si';
	begin
	while (n='si') and (i<=max) do
		begin                                              //Muestra el vector por pantallas//
			col:=1;
				while (col<=72) and (i<=max) do
					begin
						fila:=2;
						while (fila<=20) and (i<=max) do
							begin
								gotoxy(col,fila);
								write(t[i]);
								i:=i+1;
								fila:=fila+1;
							end;	
						col:=col+7;
					end;
				gotoxy(1,22);
				write('Continua mostrando, si o no?');
				writeln;
				readln(n);	
		end;						
	if (n='no') then
	writeln('Vector mostrado con exito');
	end;		
	readkey;
end;

function busqueda_lineal(t:vector2;x:integer;var buli:contadores2):boolean;  //Busqueda lineal//
var
	i:word;
begin
     buli[1]:=0;
     buli[2]:=0;
     busqueda_lineal:=false;
    for i:=min to med do
    begin
		if t[i]=x then 
			begin
				busqueda_lineal:=true;
				buli[1]:=buli[1]+1;           //Cantidad de veces que se encontro//
			end;	
		buli[2]:=buli[2]+1;                       //Cantidad de comparaciones//       
	end;	     	
end;

function posicion_binaria(t:vector2;medio:word;x:integer):longint;  //Veces que se repite el numero//
var
	i,n:word;
begin
	n:=1;
	i:=medio+1;
	while (t[i]=x) and (i<=med) do
	begin
		n:=n+1;
		i:=i+1;
	end;	
	i:=medio-1;
	while (t[i]=x) and (i>=1) do
	begin
		n:=n+1;
		i:=i-1;
	end;	
	posicion_binaria:=n;
end;		

function busqueda_binaria(t:vector2;x:integer;var bubi:contadores2):boolean;    //Busqueda binaria//
var
	pri,ult,medio:word;
begin 
	bubi[1]:=0;
	bubi[2]:=0;
	pri:=min;
	ult:=med;
	medio:=(pri+ult) div 2;
	while (x<>t[medio]) and (pri<=ult) do
		begin
			if (x>t[medio]) then
			begin
				pri:=medio+1;
				bubi[2]:=bubi[2]+1;               //Comparaciones//
			end	
			else
				begin
					ult:=medio-1;
					bubi[2]:=bubi[2]+1;
				end;
		medio:=(pri+ult) div 2;
		end;
	if (pri<=ult) then
		begin
			busqueda_binaria:=true;	
			bubi[1]:=posicion_binaria(t,medio,x);	//Veces que lo encotro//
		end;	
end;

procedure ordenar_para_busqueda_binaria(var t:vector2);  //Ordenar para utilizar busqueda binaria//
var
	j,i,item:longint;
begin
	clrscr;
	writeln;
	writeln('Por favor aguarde mientras el elemento es buscado');
		for i:=2 to med do                     //Metodo de insercion//
		begin
			item:=t[i];
			j:=i-1;
			while (j>0) and (t[j]>item) do
			begin
				t[j+1]:=t[j];
				j:=j-1;
			end;
			t[j+1]:=item;
		end;
end;					

procedure estadisticas_busqueda(a,b:boolean;x:integer;buli,bubi:contadores2);
begin
	if (a=true) and (b=true) then
		begin
			clrscr;
			writeln;
			writeln('Numero encotrado, el numero buscado fue: ',x);
			textcolor(30);
			gotoxy(30,6);
			writeln('Tabla de comparaciones');
			textcolor(10);
			writeln('================================================================================');
			textcolor(45);
			gotoxy(1,8);
			writeln('Busqueda secuencial: El numero se encontro ',buli[1],' veces');
			writeln('                     y se realizaron ',buli[2],' comparaciones');
			textcolor(10);
			writeln('================================================================================');
			textcolor(31);
			writeln('Busqueda binaria: El numero se encontro ',bubi[1],' veces');
			writeln('                  y se realizaron ',bubi[2],' comparaciones');
			textcolor(10);
			writeln('================================================================================');
			textcolor(12);
			writeln;
			writeln('Presione cualquier tecla para retornar al menu principal');
			readkey;
		end
	else
		begin
		clrscr;
		writeln;
		writeln('El numero no se encuentra en el vector');
		writeln;
		writeln('Presione cualquier tecla para retornar al menu principal');
		readkey;
		end;
end;		
					
procedure leer_buscar(var t:vector2;var buli:contadores2;var bubi:contadores2);	//Leer numero y buscarlo//
var
	x:integer;
	a,b:boolean;
begin
	clrscr;
	writeln;
	writeln('Ingrese un numero entre -2500 y 2500, para ser buscado en el vector');
	readln(x);
	a:=busqueda_lineal(t,x,buli); 
	ordenar_para_busqueda_binaria(t);
	b:=busqueda_binaria(t,x,bubi);
	estadisticas_busqueda(a,b,x,buli,bubi);
end;	
						
//Programa principal - Menu//

BEGIN
	salir:=false;
	While Not Salir do
	Begin
		clrscr;
		textcolor(14);
		GotoXY(1,1);
		Write('====Parte 1====Metodos de ordenamiento      ====Parte 2====Metodos de busqueda');
		textcolor(45);
		GotoXY(2,3);
		Write('Escoja el tipo de vector que desee:');
		textcolor(10);
		GotoXY(2,5);
		Write('1- Cargar vector aleatorio');
		GotoXY(2,7);
		Write('2- Cargar vector ascendente');
		GotoXy(2,9);
		Write('3- Cargar vector descendente');
		gotoxy(2,11);
		write('4- Mostrar el vector original');
		textcolor(45);
		gotoxy(2,13);
		write('Escoja el metodo de ordenamiento que desee');
		textcolor(10);
		gotoxy(2,15);
		write('5- Burbujeo mejorado');
		gotoxy(2,17);
		write('6- Insercion');
		gotoxy(2,19);
		write('7- Shell');
		gotoxy(2,21);
		write('8- Tabla comparativa de los metodos');
		gotoxy(45,3);
		write('|9- Cargar vector');
		gotoxy(45,5);
		write('|10- Mostrar vector');
		gotoxy(45,7);
		write('|11- Busqueda secuencial y binaria');
		textcolor(12);
		gotoxy(2,23);
		write('0- Salir');
		textcolor(10);
		writeln;
		writeln;
		readln(eleccion);
		
			case eleccion of
				1:aleatorio(v);
				2:vector_ascendente(v);
				3:vector_descendente(v);
				4:vector_original(v);
				5:burbujeo_mejorado(v,b);
				6:insercion(v,ins);
				7:shell(v,sh);
				8:tabla_estadisticas(b,ins,sh);
				9:aleatorio_2(t);
				10:vector_original_2(t);
				11:leer_buscar(t,buli,bubi);
				0:salir:=true;
			otherwise
					error;
			end;
	end;				
END.
