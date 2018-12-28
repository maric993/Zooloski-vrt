use zooPBP;



delimiter //
DROP TRIGGER IF EXISTS remove_delete;
CREATE TRIGGER remove_delete BEFORE DELETE on Zivotinja
for each row
begin
SIGNAL sqlstate '45000' set message_text = 'Nije moguce izbrisati zivotinju iz baze podataka';
end;//
delimiter ;



delimiter //
DROP TRIGGER IF EXISTS update_kolicine_hrane_after_insert;
CREATE TRIGGER update_kolicine_hrane_after_insert BEFORE INSERT on Raspored_hranjenja
for each row
begin
if((select kolicina_u_skladistu from Hrana where id_hrane=new.id_hrane)-new.kolicina>0)
then
UPDATE Hrana 
set kolicina_u_skladistu = kolicina_u_skladistu - new.kolicina 
where id_hrane=new.id_hrane;
else
SIGNAL sqlstate '45000' set message_text = 'Nije moguce nahraniti zivotinju sa uneteom hranom';
end if;
end;//
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS update_kolicine_hrane_before_update;
CREATE TRIGGER update_kolicine_hrane_before_update BEFORE UPDATE on Raspored_hranjenja
for each row
begin
if(kolicina_u_skladistu + (new.kolicina - old.kolicina)>0)
THEN
UPDATE Hrana 
set kolicina_u_skladistu = kolicina_u_skladistu + (new.kolicina - old.kolicina) 
where id_hrane=new.id_hrane;
else
SIGNAL sqlstate '45000' set message_text = 'Nije moguce updateovati kolicinu sa unetim podatkom';
END IF;
end;//
delimiter ;



delimiter //
DROP TRIGGER IF EXISTS update_broj_stanara_and_karton_after_insert;
CREATE TRIGGER update_broj_stanara_and_karton_after_insert AFTER INSERT on Zivotinja
for each row
begin
if(new.status like 'N')
then
INSERT into Zdravstveni_kartoni values(0,new.id_zivotinje,'zivotinja nije vise u zoovrtu',null,null,'zatvoren'); 
else
UPDATE Vrsta 
set broj_stanara = broj_stanara+1 
where id_vrste=new.id_vrste;
INSERT into Zdravstveni_kartoni values(0,new.id_zivotinje,'nova zivotinja u bazi',null,CURDATE() + INTERVAL 1 DAY,'otvoren');
end if; 
end;//
delimiter ;


delimiter //
DROP TRIGGER IF EXISTS update_broj_stanara_and_karton_after_update;
CREATE TRIGGER update_broj_stanara_and_karton_after_update AFTER UPDATE on Zivotinja
for each row
begin
IF(new.status not like 'A')
then
UPDATE Vrsta 
set broj_stanara = broj_stanara-1
where id_vrste=new.id_vrste ;
UPDATE Zdravstveni_kartoni 
set status='zatvoren'
where id_zivotinje=new.id_zivotinje;
else
UPDATE Vrsta 
set broj_stanara = broj_stanara+1
where id_vrste=new.id_vrste ;
UPDATE Zdravstveni_kartoni 
set status='otvoren'
where id_zivotinje=new.id_zivotinje;
end if;
end;//
delimiter ;




