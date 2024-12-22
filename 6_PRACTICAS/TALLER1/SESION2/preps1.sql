CREATE TABLE PERMISOXTABLAXUSUARIO(
USUARIO VARCHAR(30),
TABLA VARCHAR(30),
INSERTAR INTEGER(1) DEFAULT 0,
LISTAR INTEGER(1) DEFAULT 0,
ACTUALIZAR INTEGER(1) DEFAULT 0,
BORRAR INTEGER(1) DEFAULT 0,
CONSULTAR INTEGER(1) DEFAULT 0
);

DELIMITER $
CREATE OR REPLACE FUNCTION TIENEPERMISO(
POPER VARCHAR(1), 
PTABLA VARCHAR(30)) RETURNS INTEGER
BEGIN
	DECLARE PERMI INTEGER;
	SELECT CASE
		WHEN POPER='I' THEN INSERTAR
		WHEN POPER='U' THEN ACTUALIZAR
		WHEN POPER='D' THEN BORRAR
		WHEN POPER='A' THEN LISTAR
	END PERMISO INTO PERMI
	FROM PERMISOXTABLAXUSUARIO
		WHERE USUARIO=USER() AND TABLA=PTABLA;
	RETURN PERMI;
END;
$
DELIMITER ;

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



if(poper='A' AND TIENEPERMISO('A','EPS')=1) then 
	select * from eps;
else
  select -1,'45002|NO TIENE PERMISO' as msg;
  leave sp;
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

