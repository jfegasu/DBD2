USE SALUD
CREATE USER 'YO'@'localhost' IDENTIFIED BY 'YO1234';
GRANT ALL PRIVILEGES ON HR.* TO 'YO'@'localhost';

-- INGRESA CON EL USUARIO YO
-- mysql --user=YO --password=YO1234
show databases;
use hr
show tables;
select * from departments;
