view: infra_by_hostname {
  sql_table_name: `swanproj-1.looker_performance.infra_by_hostname_2` ;;

  dimension: id {
    primary_key: yes
    sql: ${TABLE}.`ID`;;
  }
  dimension: hostname {
    type: string
    sql: ${TABLE}.`Host Information Hostname` ;;
  }
  dimension: pod_id {
    description: "name of node as seen on grafana"
    type: string
    sql: ${TABLE}.`Host Information Pod ID` ;;
  }
  dimension: cpu_count {
    description: "count of CPU per node"
    type: number
    sql: ${TABLE}.`Log Fields CPU Count` ;;
  }
  dimension: node_id {
    type: number
    sql: ${TABLE}.`Log Fields Node ID` ;;
  }
  dimension: os_arch {
    type: string
    sql: ${TABLE}.`Log Fields OS Arch` ;;
  }
  dimension: total_memory {
    type: number
    sql: ${TABLE}.`Log Fields Total Memory` ;;
  }

  dimension: is_scheduler_node {
    type: yesno
    sql: CONTAINS_SUBSTR(${pod_id}, 'alternate') ;;
  }

  measure: count_scheduler_nodes {
    type: count_distinct
    sql: ${pod_id} ;;
    filters: [is_scheduler_node : "Yes"]
  }

  measure: count_regular_nodes {
    type: count_distinct
    sql: ${pod_id} ;;
    filters: [is_scheduler_node : "No"]
  }

  measure: sum_cpu {
    description: "Total CPU dedicated to instance"
    type: sum
    sql: ${cpu_count} ;;
  }

  measure: sum_cpu_regular_node {
    type: sum
    sql: ${cpu_count} ;;
    filters: [is_scheduler_node : "No"]
  }

  measure: sum_cpu_scheduler_node {
    type: sum
    sql: ${cpu_count} ;;
    filters: [is_scheduler_node : "Yes"]
  }



}
