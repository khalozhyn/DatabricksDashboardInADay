from pyspark.sql import SparkSession
from IPython.display import display, HTML


def setup_catalog_and_schemas(
    catalog: str = "sunny_bay_roastery",
    bronze_schema: str = "bronze",
    silver_schema: str = "silver",
    gold_schema: str = "gold",
    volume: str = "raw",
):
    spark = SparkSession.builder.getOrCreate()

    def _safe_sql(stmt: str, success_msg: str, err_msg: str) -> None:
        try:
            spark.sql(stmt)
            display(HTML(f"<div style='color:green'>{success_msg}</div>"))
        except Exception as e:
            display(HTML(f"<div style='color:red'>{err_msg}: {e}</div>"))

    _safe_sql(
        f"CREATE CATALOG IF NOT EXISTS `{catalog}`",
        f"Catalog `{catalog}` created or already exists.",
        "Failed to create catalog"
    )

    _safe_sql(
        f"CREATE SCHEMA IF NOT EXISTS `{catalog}`.`{bronze_schema}`",
        f"Schema `{bronze_schema}` created or already exists in catalog `{catalog}`.",
        f"Failed to create schema `{bronze_schema}`"
    )

    _safe_sql(
        f"CREATE SCHEMA IF NOT EXISTS `{catalog}`.`{silver_schema}`",
        f"Schema `{silver_schema}` created or already exists in catalog `{catalog}`.",
        f"Failed to create schema `{silver_schema}`"
    )

    _safe_sql(
        f"CREATE SCHEMA IF NOT EXISTS `{catalog}`.`{gold_schema}`",
        f"Schema `{gold_schema}` created or already exists in catalog `{catalog}`.",
        f"Failed to create schema `{gold_schema}`"
    )

    _safe_sql(
        f"CREATE VOLUME IF NOT EXISTS `{catalog}`.`{bronze_schema}`.`{volume}`",
        f"Volume `{volume}` created or already exists in schema `{bronze_schema}` of catalog `{catalog}`.",
        f"Failed to create volume `{volume}`"
    )

