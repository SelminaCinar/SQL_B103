
--1.Örnek: "workers" adında bir table oluşturup "worker_id, worker_name, worker_salary" sütunlarını ekleyin.
CREATE TABLE workers (worker_id VARCHAR(20), worker_name VARCHAR(20), worker_salary INT);

--2.Örnek: Table'a worker_address sütunu ekleyerek alter yapın.
ALTER TABLE workers ADD worker_adress varchar(80);

--3.ornek:workers table'i silin

DROP TABLE workers;






