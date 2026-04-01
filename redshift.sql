select * from tickit.sales limit 10;

-- select pricepaid/qtysold as "total"
-- from tickit.sales limit 10;

-- 2.1 The Concatenation Operator
select salesid ||' bernilai sama dengan '|| salesid as "perbandingan" from tickit.sales;

-- 2.1 duplicate
select distinct salesid
from tickit.sales;

-- 2.2 where clause
select * from tickit.sales
where pricepaid > 500;

select * from tickit.sales
where buyerid = 150
order by pricepaid;

-- 2.3 between AND
SELECT pricepaid
FROM tickit.sales
WHERE pricepaid BETWEEN 50 AND 100;

-- use BETWEEN AND equel TO
SELECT pricepaid
FROM tickit.sales
WHERE pricepaid >= 50 AND pricepaid<= 100;

-- IN
select * from tickit.category limit 10;

select catgroup,catname
from tickit.category
where catgroup IN ('Sports','Shows') 
limit 10;

-- use IN equal TO

select catgroup,catname
from tickit.category
where catgroup ='Sports' or catgroup ='Shows'
limit 10;

-- LIKE
select catgroup,catname
from tickit.category
where catgroup LIKE '____ts%'
limit 10;


select catgroup,catname
from tickit.category
where catname LIKE '%ML%'
limit 10;

-- 2.3 IS NULL AND IS NOT NULL
select *
from tickit.category c
where c.catdesc IS NULL;

SELECT *
FROM tickit.category c
WHERE c.catdesc IS NOT NULL;

-- 3.1 AND OPERATOR
SELECT *
FROM tickit.category c
WHERE c.catid > 10 AND c.catgroup ='Concerts';

-- 3.1 or OPERATOR
SELECT *
FROM tickit.category c
where c.catid > 10 or c.catgroup LIKE '_on%';

-- 3.1 NOT OPERATOR
SELECT *
FROM tickit.category c
WHERE c.catid NOT IN (11,10);

-- 3.2 ORDER BY clause
SELECT *
FROM tickit.date d
ORDER BY d.caldate;


SELECT *
FROM tickit.date d
ORDER BY d.caldate DESC;

-- 3.2 ORDER BY USING COLUMN ALIASES
SELECT caldate as tanggal
FROM tickit.date d
ORDER BY tanggal;

-- 3.2 Sorting With Other Columns
SELECT d.day,d.caldate
FROM tickit.date d
ORDER BY d.dateid;

-- 3.2 ORDER MULTIPLE COLUMN
SELECT d.day,d.caldate
FROM tickit.date d
ORDER BY d.day,d.caldate;

-- 4.1 CONCAT
SELECT concat(e.catid,e.eventname)
FROM tickit.event e;

-- 4.2 SUBSTRING
SELECT SUBSTRING(e.eventname,1,5)
FROM tickit.event e;

-- 4.2 LENGTH
SELECT LENGTH(e.eventname)
FROM tickit.event e;

-- INSTR
SELECT e.eventname,POSITION('a' IN e.eventname)
FROM tickit.event e;

-- LPAD
SELECT LPAD(e.eventname,15,'-')
FROM tickit.event e;

--RPAD
SELECT RPAD(e.eventname,15,'-')
FROM tickit.event e;

-- REPLACE
SELECT e.eventname,REPLACE(e.eventname,'T','X')
FROM tickit.event e;

-- 4.2 ROUND,TRUNC,MOD

-- ROUND
SELECT commission,ROUND(commission,1)
FROM tickit.sales;

-- TRUNC
SELECT commission,TRUNC(commission,1) as "satu dibelakang koma"
FROM tickit.sales;

-- MOD
SELECT qtysold,MOD(qtysold,2) as "sisa bagi"
from tickit.sales;

-- 4.3 date
SELECT *
FROM tickit.date;

-- SYSDATE : hari INI
-- MONTHS_BETWEEN menentukan jumlah bulan, seperti dibawah jumlah bulan dari sekarang hingga yang ada di column caldate yang lebih besar dari 240
SELECT dateid,caldate
FROM tickit.date
WHERE MONTHS_BETWEEN
(SYSDATE,caldate)>240;

-- ADD_MONTHS : tambah 12 bulan
SELECT caldate,ADD_MONTHS(caldate,12)
AS "NEXT YEAR"
from tickit.date;

-- NEXT_DAY : saturday tanggal berapa lagi
SELECT caldate,NEXT_DAY(caldate,'Saturday')
AS "NEXT Saturday"
from tickit.date;

-- LAST_DAY: Tanggal tarkhir bulan ini
SELECT caldate,LAST_DAY(caldate)
AS "Tanggal tarkhir bulan ini"
from tickit.date
order by caldate;

-- DATE_TRUNC : DATEADD tambah 1 bulan, dengan DATE_TRUNCH tanggal 1 ketika sudah ditambah 1 bulan
SELECT caldate,
DATE_TRUNC('month', DATEADD(month,1,caldate)) AS "bulan_depan_tgl_1"
FROM tickit.date;


-- DATE_TRUNC : tanggal 1 bulan caldate
SELECT caldate,
DATE_TRUNC('month', caldate) AS "tanggal_awal_bulan"
FROM tickit.date;


-- 5.1 Conversion Functions

SELECT caldate, TO_CHAR(caldate,'Month dd, YYYY')
FROM tickit.date;

SELECT caldate, TO_CHAR(caldate,'fmMonth dd, YYYY')
FROM tickit.date;

SELECT caldate, TO_CHAR(caldate,'fmMonth ddth, YYYY')
FROM tickit.date;

SELECT TO_CHAR(pricepaid,'$99999.99')
FROM tickit.sales;

SELECT TO_CHAR(pricepaid,'99.999')
FROM tickit.sales;

SELECT TO_CHAR(pricepaid,'99.999')
FROM tickit.sales;

-- 5.2 NVL,NVL2,NULLIF,COALESCE
-- NVL berguna untuk mengganti null menjadi nilai tertentu seperti dibawah
-- kita mengganti setiap null di column qtysold dengan angka 0
SELECT salesid, NVL(qtysold,0) as "Quantity sold"
FROM tickit.sales;

-- jika yang diubah bentuk datanya char maka seperti dibawah ubah dulu dari angka ke char
SELECT salesid,
NVL(CAST(qtysold AS VARCHAR), 'None') as "Quantity sold"
FROM tickit.sales;

-- NVL2 memiliki 3 paramater NVL2(nilai, hasil_jika_tidak_null, hasil_jika_null)
-- if qtysold tidak null ganti dengan 0 jika null ganti dengan -1
SELECT salesid, NVL2(qtysold,0,-1) as "Quantity sold"
FROM tickit.sales;

-- NULLIF
-- pada bagian NULLIF(LENGTH(salesid),LENGTH(listid)) jika panjang salesid dan listid sama isi dengan null, jika tidak isi
-- dengan salesid karena dia pertama di select
SELECT salesid,LENGTH(salesid) as "Panjang salesid",
listid,LENGTH(listid) as "Panjang listid",
NULLIF(LENGTH(salesid),LENGTH(listid)) as "Compare Them"
FROM tickit.sales;

-- contoh lain kalau qtysold = 0 → jadi NULL,kalau tidak → tetap
SELECT qtysold,
NULLIF(qtysold,0) AS hasil
FROM tickit.sales;


-- 6.1 CROSS JOIN and NATURAL JOINS
-- 9.2 Rollup jumlahkan kekanan dan kebawah
SELECT catgroup, catname, SUM(catid)
FROM tickit.category
GROUP BY ROLLUP(catgroup, catname);

-- 9.2 cube
SELECT catgroup, catname, SUM(catid)
FROM tickit.category
GROUP BY CUBE (catgroup, catname);

-- 10.1 Fundamentals of Subqueries

SELECT *
FROM tickit.event v
WHERE v.catid > (
    SELECT MAX(s.buyerid)
    FROM tickit.sales s
);

-- 10.2 subquery from different TABLE
-- dibawah adalah cara jika inner query memiliki hasil satu baris tanda = bisa diganti dengan  >,< dan lainnya
SELECT venuename,venuecity
from tickit.venue
where venueid = (
    select venueid
    from tickit.event
    where eventid =6348
)

-- jika inner query tidak 1 nilai bisa pakai IN seperti dibawah

SELECT v.venuename,venuecity
from tickit.venue v
where v.venueid IN (
    select e.venueid
    from tickit.event e
    where eventid BETWEEN 5000 AND 8000
)

-- cari USER 
SELECT *
FROM tickit.sales
WHERE qtysold > (
    SELECT AVG(qtysold)
    FROM tickit.sales
);

-- use HAVING
SELECT city,userid
FROM tickit.users
GROUP BY city,userid
HAVING userid IN(
    SELECT buyerid
    FROM tickit.sales
);

-- 10.3 Multiple-ROW Subqueries
-- IN,ANY,ALL

-- ANY example dibawah mengambil baris yang qtysold-nya sama dengan salah satu nilai (6–8)
SELECT *
FROM tickit.sales
WHERE qtysold = ANY (
    SELECT qtysold
    FROM tickit.sales
    WHERE qtysold BETWEEN 6 AND 8
);

-- natural join pakai semua kolom sama dikedua table untuk menghubungkan kedua TABLE, biasanya kita pakai ON kan, tetapi natural tidak, makanya natural jarang dipakai karena
-- bisa saja kedua column sama tetapi isinya beda atau kedua nya memiliki type yang berbeda
SELECT VENUENAME,eventname
FROM tickit.venue
NATURAL JOIN
tickit.event

-- cross join table a = 3 baris table b =4 baris jadi cros joinnya ada 12 baris
SELECT VENUENAME,eventname
FROM tickit.venue
CROSS JOIN
tickit.event

-- 6.2 clause join, nah disilah kita pakai USING dan menghindari penggunaan NATURAL JOIN
SELECT venueid,VENUENAME,eventname
FROM tickit.venue
JOIN
tickit.event
USING(venueid)

-- penggunaan ON, USING harus memilih column dengan nama yang sama kalau beda maka pakai ON

SELECT v.venueid,v.VENUENAME,e.eventname
FROM tickit.venue v
JOIN
tickit.event e
ON v.venueid = e.venueid
WHERE v.venuename LIKE 'Lu%';

-- ON Clause with non-equality operator, dimana tidak ada column salary di job_grades jadi kita pakai BETWEEN
SELECT e.emp_id, e.salary, j.grade
FROM employees e
JOIN job_grades j
ON e.salary BETWEEN j.min_salary AND j.max_salary;

-- 6.3 LEFT and RIGHT JOIN
-- left join 👉 LEFT JOIN = ambil semua data dari tabel kiri,Kalau tidak ada pasangan di tabel kanan → diisi NULL
-- dibawah menentukan venuename mana yang tidak digunakan untuk event
SELECT v.venueid,v.VENUENAME,e.eventname
FROM tickit.venue v
LEFT JOIN
tickit.event e
ON v.venueid = e.venueid
WHERE e.venueid IS NULL;

-- right join 👉 RIGHT JOIN = ambil semua data dari tabel kanan,Kalau tidak ada pasangan di tabel kiri → diisi NULL
SELECT v.venueid,v.VENUENAME,e.eventname
FROM tickit.venue v
RIGHT JOIN
tickit.event e
ON v.venueid = e.venueid
WHERE v.venueid IS NULL;


-- partition
-- FUNCTION() OVER (...)
-- code dibawah membuat kita bisa sum(qtysold) tanpa groupby buyerid
SELECT buyerid, qtysold,
SUM(qtysold) OVER (PARTITION BY buyerid) as total
FROM tickit.sales;

-- dengan group by akan seperti dibawah
SELECT buyerid,
SUM(qtysold)
FROM tickit.sales
GROUP BY buyerid
HAVING buyerid = 64;

-- kita bisa pakai function ROW_NUMBER() juga untuk perangkingan jika ada yang sama tetap dirangking menurut urutan
SELECT buyerid, pricepaid,
ROW_NUMBER() OVER (ORDER BY pricepaid DESC) as ranking
FROM tickit.sales;

-- kita bisa pakai function ROW_NUMBER() juga untuk perangkingan jika ada yang sama nilainya di pricepaid maka di rangking akan ditulis angka yang sama
SELECT buyerid, pricepaid,
RANK() OVER (ORDER BY pricepaid DESC) as ranking
FROM tickit.sales;

SELECT buyerid, pricepaid,
LAG(pricepaid) OVER (ORDER BY pricepaid DESC) as ranking,ranking-pricepaid as pengurangan
FROM tickit.sales;


-- urutan kode dibawah bagian partition, dia pisah kan dulu setiap buyerid membentuk window, baru dimasing masing buyerid urutkan berdasarkan pricepaid
SELECT buyerid, pricepaid,
ROW_NUMBER() OVER (
    PARTITION BY buyerid 
    ORDER BY pricepaid DESC
) as rank
FROM tickit.sales