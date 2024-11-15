view: queries_by_hostname {
  sql_table_name: `swanproj-1.looker_performance.queries_by_hostname_2` ;;

  dimension: id {
    primary_key: yes
    sql: ${TABLE}.`ID`;;
  }
  dimension: hostname {
    type: string
    sql: ${TABLE}.`Host Information Hostname` ;;
  }
  dimension: query_count {
    hidden: yes
    type: number
    sql: ${TABLE}.`Log Fields Count` ;;
  }
  dimension: hour_of_day {
    type: number
    sql: ${TABLE}.`Log Fields Log Entry Hour of Day` ;;
  }
  dimension: query_summary_source {
    type: string
    sql: ${TABLE}.`Query Summary Source` ;;
  }

  measure: sum_queries {
    type: sum
    sql: ${query_count} ;;
  }

}
