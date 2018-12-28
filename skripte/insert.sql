use zooPBP;
 insert into Kavez values
(default,'kamena povrs','3','12.12.2018'),
(default,'travnata povrs','5','12.12.2018'),
(default,'travnata povrs','7','12.12.2018'),
(default,'kavez','3','12.12.2018'),
(default,'kavez','2','12.12.2018'),
(default ,'suma',5,'2018.12.01'),
(default , 'bazen',5,'2018.09.09'),
(default , 'travnata povrs',10,'2018.09.09'),
(default , 'bazen',10,'2018.09.09');

 insert into Privremeni_kavez values
(1,2),
(2,3),
(2,1),
(3,1),
(3,2),
(4,5),
(5,4),
(6,2),
(7,9),
(9,7),
(8,2),
(8,3);

insert into Dobavljac values
(default,'Zorbal','www.zorbal.rs'),
(default,'Farmia','farmia.rs'),
(default,'Tekton d.o.o', 'tekton.rs'),
(default,'Zoo Hobby','www.zoo-hobby.rs'),
(default,'Animalis','www.animalis.rs'),
(default,'Almax','www.almax.com'),
(default,'MJ Trade d.o.o','mjtrade.com');

insert into Hrana values
(default ,1,1300,'seno'),
(default ,2,2300,'meso'),
(default ,1,500,'semenke i kostunjavo voce'),
(default ,3,3300,'juzno voce'),
(default ,4,3200,'mleko'),
(default ,6,550,'insekti'),
(default ,1,800,'zitarice'),
(default ,2,1200,'riba');

insert into Vrsta values
(default,"Azijski slon",'1','Slonovi su velike životinje iz familije Elephantidae. Slonovi su biljojedi i prisutni su u različitim staništima uključujući savane, šume, pustinje, i močvare.',0),
(default,"Zirafa is Kardofana",'1','Žirafa je afrički sisar iz reda papkara, najviši od svih kopnenih životinja',0),
(default,"Africki lav",'4','Lav je veliki sisar iz porodice mačaka.',0),
(default,"Bengalski tigar",'2','Žirafa je afrički sisar iz reda papkara, najviši od svih kopnenih životinja',0),
(default,'Simpanza','1','Simpanza  je čovekoliki majmun iz porodice velikih čovekolikih majmuna koji nastanjuje prašume centralne i zapadne Afrike.',0),
(default,'Orangutan','1','Orangutani  su rod velikih čovekolikih majmuna poznati po svojoj inteligenciji, dugačkim rukama i riđem krznu..',0),
(default,"Carski pingvin",'1','Carski pingvin je najviša i najteža vrsta od 17 vrsta pingvina.Odrasli pingvini su prosečne visine od 1,3 metara',0),
(default,'Emu','1','Emu je najviša ptica u Australiji koja ne leti. Može da naraste čak do 2 metara. Vrat i noge su dugi, a krila kratka, samo 20 centimetara duga.',0),
(default,"Indijski paun",'1','Indijski paun prirodno naseljava Indijski potkontinent. Ima predivan rep od dugih pera sa okastim šarama koja širi sjajnu plavu glavu i vrat.',0),
(default,"Kornjača sa Galapagosa",'3','Galapagoška kornjača  danas je najveća kornjača. Ima velik leđni oklop, goleme udove i dugačak vrat. ',0);

insert into Zivotinja(id_zivotinje,id_vrste,ime,naziv_vrste,datum_rodjenja,pol,interval_ishrane,status,datum_useljenja,datum_iseljenja) values
(0,1,'Dambo','Azijski slon','2008.05.03','M','1','A','2008.05.03',null),
(0,1,'Cezar','Azijski slon','1992.01.30','M',1,'A','2005.12.04',null),
(0,1,'Kleopatra','Azijski slon','1997.05.03','F',1,'A','2014.12.04',null),
(0,2,'Viktoria','Zirafa is Kardofana','2010.12.30','F',1,'A','2018.02.13',null),
(0,2,'Margaret','Zirafa is Kardofana','2009.04.12','F',2,'A','2018.02.13',null),
(0,3,'Napoleon','Africki lav','2001.02.10','M',4,'A','2001.02.10',null),
(0,4,'Jovana','Bengalski tigar','1995.05.05','F',1,'A','2014.10.1',null),
(0,5,'Lusi','Simpanza','1999.09.01','F',1,'A','2005.12.04',null),
(0,6,'Narandza','Orangutan','2012.03.10','F',1,'A','2012.03.10',null),
(0,8,'Deneris','Emu','2015.04.04','F',1,'N','2016.08.18','2018.08.10'),
(0,10,'Donatelo','Kornjača sa Galapagosa','1974.03.21','M',1,'A','2005.12.04',null),
(0,10,'Mikelandjelo','Kornjača sa Galapagosa','1964.01.01','M',1,'A','2005.12.04',null),
(0,7,'Major','Carski pingvin','2002.05.29','M',1,'A','2008.11.29',null),
(0,7,'Kovalski','Carski pingvin','2003.04.15','M',1,'A','2008.11.29',null),
(0,7,'Riko','Carski pingvin','2005.03.20','M',1,'A','2008.11.29',null),
(0,7,'Vojnik','Carski pingvin','2002.05.22','M',1,'A','2008.11.29',null);

insert into Eksponat values 
(2,1,'2008.05.03'),
(2,2,'2005.12.04'),
(2,3,'2014.12.04'),
(3,4,'2018.02.13'),
(3,5,'2018.02.13'),
(8,6,'2003.03.13'),
(1,7,'2018.02.01'),
(6,8,'2005.12.04'),
(6,9,'2012.03.10'),
(5,10,'2017.01.18'),
(7,11,'2005.12.04'),
(7,12,'2005.12.04'),
(9,13,'2008.11.29'),
(9,14,'2008.11.29'),
(9,15,'2008.11.29'),
(9,16,'2008.11.29');


insert into Raspored_hranjenja values
(1,1,'2018-12-22 12:34:59',80),
(1,1,'2018-12-23 12:59:45',79),
(2,1,'2018-12-22 14:25:59',60),
(2,1,'2018-12-23 14:20:12',65),
(3,1,'2018-12-22 14:27:31',70),
(3,1,'2018-12-23 14:29:21',70),
(4,1,'2018-12-22 11:27:31',30),
(4,1,'2018-12-23 11:29:21',30),
(5,1,'2018-12-22 14:37:31',34),
(5,1,'2018-12-23 14:38:22',30),
(6,2,'2018-12-20 09:29:21',5),
(7,2,'2018-12-21 10:34:31',7),
(7,2,'2018-12-23 11:00:00',7),
(8,3,'2018-12-22 16:22:31',4),
(8,3,'2018-12-23 16:51:21',3),
(9,3,'2018-12-22 15:17:31',2),
(9,3,'2018-12-23 15:19:21',3),
(10,7,'2018-12-22 17:17:31',1),
(10,7,'2018-12-23 17:59:21',1),
(11,3,'2018-12-20 15:17:31',1),
(11,6,'2018-12-23 15:19:21',1),
(12,3,'2018-12-20 16:17:31',1),
(12,6,'2018-12-23 16:19:21',1),
(13,8,'2018-12-22 15:17:31',1),
(13,8,'2018-12-23 15:19:21',1),
(14,8,'2018-12-22 15:17:31',1),
(14,8,'2018-12-23 15:19:21',1),
(15,8,'2018-12-22 15:17:31',1),
(15,8,'2018-12-23 15:19:21',1),
(16,8,'2018-12-22 13:17:11',1),
(16,8,'2018-12-23 13:19:21',1);


insert into Terapija values 
(default,1,'2009.10.10','2009.10.20','boginje'),
(default,6,'2010.01.01','2010.02.01','Bovine Tuuberkuloza');


