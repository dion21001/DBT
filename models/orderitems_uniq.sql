-- SELECT *
-- FROM {{ source('landing', 'ordritms') }}
-- LIMIT 10;

-- deduplicates
-- fungsi dari dbt_utils.deduplicate adalah untuk menghilangkan duplikat data berdasarkan kolom yang ditentukan pada partition_by, 
-- dan memilih baris dengan nilai terbaru berdasarkan kolom yang ditentukan pada order_by. Dalam contoh ini, 
-- kita ingin menghilangkan duplikat data berdasarkan kolom orderitemid, dan memilih baris dengan nilai terbaru berdasarkan kolom updated_at. 
-- Sehingga hasilnya akan menampilkan data yang unik berdasarkan orderitemid dengan nilai terbaru pada updated_at.
-- biasanya digunakan contoh mau lihat customer ini baru belanja apa saja
SELECT *
FROM (
    {{ dbt_utils.deduplicate(
    relation=source('landing', 'ordritms'),
    partition_by='orderitemid',
    order_by="updated_at desc",
   )
}}
)
ORDER BY orderitemid;


-- GROUP BY
select city, count(*) as total_employees
from {{ source('landing', 'emp') }}
{{ dbt_utils.group_by(n=1) }}


-- LATIHAN 1 — Buat FACT TABLE (pakai surrogate_key)
/* Surrogate key bukan sekadar untuk “menggabungkan key antar tabel”, tetapi untuk membuat satu identitas unik (single primary key) 
pada sebuah baris di fact table ketika natural key-nya berupa kombinasi beberapa kolom (composite key). Tujuan utamanya adalah menyederhanakan
 identifikasi baris, mendukung proses seperti incremental load, deduplikasi, dan menjaga konsistensi model data, bukan agar semua join 
 dilakukan menggunakan surrogate key. Fact table tetap di-join ke dimension menggunakan natural key (misalnya customerid, productid),
  sedangkan surrogate key lebih sering digunakan untuk identitas internal baris, operasi incremental, dan join antar tabel yang memiliki 
  grain yang sama. Surrogate key tidak membuat tabel “berdiri sendiri sepenuhnya”, dan tidak harus digunakan di semua tabel, melainkan 
  hanya saat dibutuhkan untuk menggantikan composite key menjadi satu kolom yang stabil, sederhana, dan mudah dikelola. */

SELECT
    {{dbt_utils.generate_surrogate_key(['o.orderid','oi.productid'])}} as sales_id,
    o.orderid,
    o.customerid,
    o.employeeid,
    o.storeid,
    oi.productid,
    oi.quantity,
    oi.unitprice
FROM {{source('landing','ordr')}} o
JOIN {{source('landing','ordritms')}} oi
    ON o.orderid = oi.orderid


-- LATIHAN 2 — Cleaning Data (pakai CAST & coalesce)

SELECT 
    CUSTOMERID,
    COALESCE(zipcode, 'UNKNOWN') as zipcode,
    CAST(phone AS STRING) AS PHONE_CLEANED
FROM {{ source('landing','cust') }};


-- pivot
select
    storeid,
    {{ dbt_utils.pivot(
        column='category',
        values=['Electronics', 'Clothing', 'Food'],
        agg='sum',
        then_value='sales'
    ) }}
from (
    select
        o.storeid,
        p.category,
        oi.quantity * oi.unitprice as sales
    from {{ source('landing', 'ordr') }} o
    join {{ source('landing', 'ordritms') }} oi
        on o.orderid = oi.orderid
    join {{ source('landing', 'prdt') }} p
        on oi.productid = p.productid
) src
group by storeid