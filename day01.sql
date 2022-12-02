CREATE TABLE ogrenciler1
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,-- Ondalıklı sayılar için kullanılır(Double gibi)
kayit_tarih date
);

--Varolan tablodan yeni tablo olusturma
CREATE TABLE ogrenci_notlari
as--Benzer tablodaki başlıklarla ve data tipleriyle yeni bir tablo oluşturmak için
--normal tablo oluştururken ki parantezler yerine AS kullanıp Select komutuyla almak istediğimiz verileri alırız
select isim,soyisim,not_ort from ogrenciler;

--DATA MANIPULATION LANG. DML
--INSERT (DATABASE VERI EKLEME)

iNSERT iNTO ogrenciler VALUES ('1234567','Said','Ilhan',85.5,now());
iNSERT iNTO ogrenciler VALUES ('1234567','Toprak Gezi','Cinar',85.5,'2022-12-01');

--BIR TABLOYA PARCALI VERI EKLEMEK ICIN
INSERT INTO ogrenciler(isim,soyisim) VALUES ('SELMINA','CINAR');

--DQL - DATA QUERY LANG.
--SELECT

select * from ogrenciler;