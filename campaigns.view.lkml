view: campaigns {
  sql_table_name: adwords.campaigns ;;

  filter: campaign_selector {
    type: string
    suggest_dimension: campaign_name_raw
  }

  dimension: campaign_benchmark {
    type: string
    sql: IF( {% condition campaign_selector %} ${campaign_name_raw} {% endcondition %}, ${campaign_name_raw}, 'Benchmark') ;;
  }

  dimension: campaign_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: advertising_channel {
    type: string
    sql: ${TABLE}.advertising_channel ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: bid_type {
    type: string
    sql: ${TABLE}.bid_type ;;
  }

  dimension: campaign_name {
    type: string
    sql: concat(cast(${campaign_id} as string), " - " , ${campaign_name_raw}) ;;
  }

  dimension: campaign_name_raw {
    label: "Campaign Name"
    hidden: yes
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_type {
    sql: SUBSTR(SUBSTR(${campaign_name_raw},STRPOS(${campaign_name_raw},' - ')+3),STRPOS(SUBSTR(${campaign_name_raw},STRPOS(${campaign_name_raw},' - ')+3),' - ')+3) ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: DATE_ADD(${created_raw}, INTERVAL ${period} DAY) ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: is_active_now {
    type: yesno
    sql: ${end_date} >= current_date() ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_id, campaign_name, adgroups.count]
  }
}
