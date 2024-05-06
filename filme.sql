use Filme;

CREATE table Filmes (
id		int primary key auto_increment,
titulo	varchar(60),
minuto	int
);

DELIMITER $
CREATE TRIGGER chk_minutos	before insert on Filmes
	for each row
    begin
		if new.minutos < 0 then
			set new.minutos = null;
		end if;
	end$
DELIMITER ;
        
insert into Filmes (titulo, minutos) values ("The terrible trigger" , 120);
insert into Filmes (titulo, minutos) values ("O alto da compadecida", 135);
insert into Filmes (titulo, minutos) values ("Faroeste caboclo", 240);
insert into Filmes (titulo, minutos) values ("The matrix", 90) ;
insert into Filmes (titulo, minutos) values ("Blade runner", -88);
insert into Filmes (titulo, minutos) values ("O labirinto do fauno", 110);
insert into Filmes (titulo, minutos) values ("Metropole", 0);
insert into Filmes (titulo, minutos) values ("A lista", 120);

delimiter $

create trigger chk_minutos before insert on Filmes
	for each row 
    begin
		if new.minutos < 0 then
        
		-- Lançar un Erro 
		signal SQLSTATE '45000' -- exceção não tratata
		set MESSAGE_TEXT = "Valor inválido para minutos",
		MYSQL_ERRNO = 2022;  -- código de erro pra controle
	end if;
end$
delimiter ;

create table Log_deletions (
id 		int 	primary key 	auto_increment,
titulo 	varchar (00),
quando 	datetime,
quem 	varchar (40)
);

delimiter $
create trigger log_oeletions after delete on Filmes
for each row
begin
	insert into Log_deletions values (null, oLd.titulo, sysdate(), user());
end$
delimiter ; 

delete from Filmes where id = 2;
delete from Filmes where 1d = 4;
select * from Log_deletions;
