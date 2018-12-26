use zooPBP
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
CREATE TRIGGER update_kolicine_hrane_after_insert after INSERT on Raspored_hranjenja
for each row
begin
UPDATE Hrana 
set kolicina_u_skladistu = kolicina_u_skladistu - new.kolicina 
where id_hrane=new.id_hrane;
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
DROP TRIGGER IF EXISTS update_broj_stanara_after_insert;
CREATE TRIGGER update_broj_stanara_after_insert after INSERT on Zivotinja
for each row
begin
UPDATE Vrsta 
set broj_stanara = broj_stanara+1 
where id_vrste=new.id_vrste;
end;//
delimiter ;


delimiter //
DROP TRIGGER IF EXISTS update_broj_stanara_after_update;
CREATE TRIGGER update_broj_stanara_after_update after UPDATE on Zivotinja
for each row
begin
IF(new.status not like ('N' or 'A'))
then
SIGNAL sqlstate '45000' set message_text = 'Status zivotinje moze biti ili (N)eaktivan ili (A)ktivan';
end if ;
UPDATE Vrsta 
set broj_stanara = broj_stanara-1
where id_vrste=new.id_vrste and new.status like 'N' and old.status not like 'N';
end;//
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS update_zdravstvenog_kartona_after_insert;
CREATE TRIGGER update_zdravstvenog_kartona_after_insert after INSERT on Zivotinja
for each row
begin
INSERT into Zdravstveni_kartoni values(0,new.id_zivotinje,'nova zivotinja u bazi',null,CURDATE() + INTERVAL 1 DAY,'otvoren'); 
end;//
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS update_zdravstvenog_kartona_after_update;
CREATE TRIGGER update_zdravstvenog_kartona_after_update after UPDATE on Zivotinja
for each row
begin
UPDATE Zdravstveni_kartoni 
set status='zatvoren'
where id_zivotinje=new.id_zivotinje and new.status like 'N' and old.status not like 'N';
end;//
delimiter ;


