connection: "lookerdata_bigquery_standard_sql "

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project


explore: keywords {}
