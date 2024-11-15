connection: "sample_bigquery_connection"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: looker_performance_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker_performance_default_datagroup

explore: queries_by_hostname {
  description: "Data pulled from GCP Logs. This data reflects 1 day (11/13/2024)"
  join: infra_by_hostname {
    sql_on: ${queries_by_hostname.hostname} = ${infra_by_hostname.hostname} ;;
    relationship: many_to_many
  }
}
