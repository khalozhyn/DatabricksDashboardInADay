-- Date dimension (CSV -> silver streaming)
CREATE OR REFRESH STREAMING TABLE silver.date AS
SELECT
    *
FROM STREAM read_files(
  '/Volumes/sunny_bay_roastery/bronze/raw/dim_date/',
  format => 'csv'
);

-- Store dimension (CSV -> silver streaming)
CREATE OR REFRESH STREAMING TABLE silver.store AS
SELECT
    *
FROM STREAM read_files(
  '/Volumes/sunny_bay_roastery/bronze/raw/dim_store/',
  format => 'csv'
);

-- Customer dimension (CSV -> silver streaming)
CREATE OR REFRESH STREAMING TABLE silver.customer AS
SELECT
    *
FROM STREAM read_files(
  '/Volumes/sunny_bay_roastery/bronze/raw/dim_customer/',
  format => 'csv'
);

-- Product dimension (CSV -> silver streaming)
CREATE OR REFRESH STREAMING TABLE silver.product AS
SELECT
    *
FROM STREAM read_files(
  '/Volumes/sunny_bay_roastery/bronze/raw/dim_product/',
  format => 'csv'
);

-- Coffee sales fact (Parquet -> silver streaming)
CREATE OR REFRESH STREAMING TABLE silver.coffee_sales AS
SELECT
    *
FROM STREAM read_files(
  '/Volumes/sunny_bay_roastery/bronze/raw/fact_coffee_sales/',
  format => 'parquet'
);

CREATE MATERIALIZED VIEW gold.dim_date AS
SELECT * FROM silver.date;

CREATE MATERIALIZED VIEW gold.dim_store AS
SELECT * FROM silver.store;

CREATE MATERIALIZED VIEW gold.dim_customer AS
SELECT * FROM silver.customer;

CREATE MATERIALIZED VIEW gold.dim_product AS
SELECT * FROM silver.product;

CREATE MATERIALIZED VIEW gold.fact_coffee_sales AS
SELECT
    fcs.*
    -- dp.list_price_usd * fcs.quantity_sold                               AS gross_revenue_usd,
    -- (dp.list_price_usd * fcs.quantity_sold) / (1 + ds.tax_rate)         AS net_revenue_usd
FROM silver.coffee_sales fcs
JOIN silver.product dp
  ON fcs.product_key = dp.product_key
JOIN silver.store ds
  ON fcs.store_key = ds.store_key;