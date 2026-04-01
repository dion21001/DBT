-- SELECT *
-- FROM {{ source('landing', 'ordritms') }}
-- LIMIT 10;


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
group by {{ dbt_utils.group_by(n=1) }}