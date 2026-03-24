{{ dbt_utils.deduplicate(
    relation=source('landing', 'ordritms'),
    partition_by='orderid',
    order_by="updated_at desc",
   )
}}