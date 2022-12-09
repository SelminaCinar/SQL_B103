-- DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun

--Musteri urun tablosundan urun isimlerini tekrarsiz gruplayiniz.

--1.YOL
SELECT urun_isim FROM musteri_urun
GROUP BY urun_isim

--2.YOL
SELECT DISTINCT(urun_isim) FROM musteri_urun

--Tabloda kac farkli meyve vardir

SELECT urun_isim, count(DISTINCT urun_isim)
as cesit_sayisi FROM musteri_urun GROUP BY urun_isim

-- FETCH NEXT (SAYI) ROW ONLY- OFFSET

-- Sirali tablodan ilk 3 kaydi listeleyin
SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY

--LIMIT ILE
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT 3

-- Sirali tablodan son 3 kaydi listeleyin

SELECT * FROM musteri_urun ORDER BY urun_id
DESC limit 3



CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);
INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

--En yuksek maaasi alan musteriyi listeleyin

SELECT * FROM maas ORDER BY maas DESC limit 1 offset 1

/*
Satir atlamak istedigimizde OFFSET komutunu kullaniriz
*/

--Maas tablosundan en dusuk 4. maasi  listeleyiniz

SELECT * FROM maas ORDER BY maas limit 2 offset 3


/*
					ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
 
 CREATE TABLE personel3  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel3_pk PRIMARY KEY (id)
);
INSERT INTO personel3 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel3 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel3 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel3 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel3 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel3 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel3 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel3

--ADD default deger ile tabloya field ekleyiniz

ALTER TABLE personel3
ADD ulke varchar(30)

ALTER TABLE personel3
ADD adres varchar(50) DEFAULT 'Turkiye'

ALTER TABLE personel3
ADD zipcode varchar(30)

----DROP tablodan sutun silme

ALTER TABLE personel3
DROP COLUMN zipcode

---RENAME COLUMN sutun adi degistirme

ALTER TABLE personel3
RENAME COLUMN sehir TO il

select * from isci

---RENAME tablonun ismini degistirme

ALTER TABLE personel3
RENAME TO isci

-----TYPE/SET sutunlarin ozelliklerini degistirme

ALTER TABLE isci 
ALTER COLUMN il TYPE varchar(30),
ALTER COLUMN maas SET NOT NULL
--Eger numeric data turune sahip bir sutunun data turune String bir data turu atamak istersek
--TYPE varchar(30) USING (maas::varchar(30)) bu formati kullaniriz


ALTER COLUMN maas TYPE varchar(30)
USING (maas::varchar(30))


---------------TRANSACTION----------
--Begin-Savepoint-Rollback-Commit
--Transaction baslatmak icin BEGIN komutu kullanmamiz gerekir ve Transaction'i sonlandirmak icin
--COMMIT komutunu calistirmaliyiz.

CREATE TABLE ogrenciler2
(
id serial,--serial data turu otomatik 1den baslayarak siralama yapar.
	      --INSERT INTO ile tabloya veri eklerken serial data turunu kullandigimizda veri degeri yerine default yazariz.
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;

select * from ogrenciler2

/*
	Transaction kullaniminda SERIAL data turu kullanimi tercih edilmez. Save pointten sonra ekledigimiz
	veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.
	NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
	"COMMIT" komutu kullanılır.
 */





