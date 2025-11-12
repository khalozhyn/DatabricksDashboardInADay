-- This file defines a sample transformation.
-- Edit the sample below or add new transformations
-- using "+ Add" in the file browser.

CREATE MATERIALIZED VIEW sunny_bay_roastery.gold.dim_date AS
SELECT
    *
FROM read_files(
  "/Volumes/sunny_bay_roastery/bronze/raw/dim_date/",
  format => "csv"
);

-- CREATE MATERIALIZED VIEW sunny_bay_roastery.gold.dim_store AS
-- SELECT
--     *
-- FROM read_files(
--   "/Volumes/sunny_bay_roastery/bronze/raw/dim_store/",
--   format => "csv"
-- );

CREATE MATERIALIZED VIEW sunny_bay_roastery.gold.dim_customer AS
SELECT
    *
FROM read_files(
  "/Volumes/sunny_bay_roastery/bronze/raw/dim_customer/",
  format => "csv"
);

CREATE MATERIALIZED VIEW sunny_bay_roastery.gold.dim_product AS
SELECT
    *
FROM read_files(
  "/Volumes/sunny_bay_roastery/bronze/raw/dim_product/",
  format => "csv"
);

CREATE MATERIALIZED VIEW sunny_bay_roastery.gold.fact_coffee_sales AS
SELECT
    *
FROM read_files(
  "/Volumes/sunny_bay_roastery/bronze/raw/fact_coffee_sales/",
  format => "parquet"
);