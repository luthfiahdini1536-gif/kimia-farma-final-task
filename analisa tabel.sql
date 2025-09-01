CREATE OR REPLACE TABLE `festive-flight-470613-s6.kimia_farma.tabel_analisa` AS
SELECT
    t.transaction_id,
    t.date,
    b.branch_id,
    b.branch_name,
    b.kota,
    b.provinsi,
    b.rating AS rating_cabang,
    t.customer_name,
    p.product_id,
    p.product_name,
    p.price AS actual_price,
    t.discount_percentage,   
    CASE 
        WHEN p.price <= 50000 THEN 0.10
        WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
        WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
        WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    (p.price - (p.price * t.discount_percentage/100)) AS nett_sales,
    (p.price - (p.price * t.discount_percentage/100)) * 
    CASE 
        WHEN p.price <= 50000 THEN 0.10
        WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
        WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
        WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS nett_profit,
    t.rating AS rating_transaksi
FROM `festive-flight-470613-s6.kimia_farma.kf_final_transaction` t
LEFT JOIN `festive-flight-470613-s6.kimia_farma.kf_kantor_cabang` b ON t.branch_id = b.branch_id
LEFT JOIN `festive-flight-470613-s6.kimia_farma.kf_product` p ON t.product_id = p.product_id
LEFT JOIN `festive-flight-470613-s6.kimia_farma.kf_inventory` c ON t.product_id = c.product_id;