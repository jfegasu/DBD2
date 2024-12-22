delimiter $
create or replace procedure preps(in poper varchar(1), in pid integer, in pnom text, pestado integer)
sp:begin
if(poper in('Q','U','D')) then
select count(*) into @b from eps where ideps=pid;
if(@b=0) then
	select -1 as error,'45001|ID NO EXISTE' as msg;
	leave sp;
end if;
end if;

if(poper not in('A','I','Q','U','D')) then
	select -1 as error,'45000|OPERADOR NO ACEPTADO' as msg;
    leave sp;
end if;



if(poper='A') then 
	select * from eps;
end if;
if(poper='Q') then 
	select * from eps where ideps=pid;
end if;
if(poper='I') then 
	insert into eps (nombre, estadoeps) values(pnom,pestado);
end if;
if(poper='U') then 
	if(pnom is not null and pestado is null) then
		update eps set nombre=pnom where ideps=pid;
	end if;

	if(pnom is not null and pestado is not null) then
		update eps set nombre=pnom where ideps=pid;
	end if;
end if;
if(poper='D') then 
	delete from eps where ideps=pid;
end if;
end;
$
delimiter ;



