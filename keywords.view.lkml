view: keywords {
  sql_table_name: adwords.keywords ;;

  dimension: keyword_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.KEYWORD_ID ;;
  }

  dimension: ad_id {
    type: number
    sql: ${TABLE}.AD_ID ;;
  }

  dimension: bidding_strategy_type {
    type: string
    sql: ${TABLE}.BIDDING_STRATEGY_TYPE ;;
  }

  dimension: cpc_bid_amount {
    type: number
    sql: ${TABLE}.CPC_BID_AMOUNT ;;
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

  dimension: criterion_name {
    type: string
    sql: ${TABLE}.CRITERION_NAME ;;
  }

  dimension: keyword_match_type {
    type: string
    sql: ${TABLE}.KEYWORD_MATCH_TYPE ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.PERIOD ;;
  }

  dimension: quality_score {
    type: number
    sql: ${TABLE}.QUALITY_SCORE ;;
  }

  dimension: system_serving_status {
    type: string
    sql: ${TABLE}.SYSTEM_SERVING_STATUS ;;
  }

  measure: count {
    type: count
    drill_fields: [keyword_id, criterion_name, adevents.count]
  }
}
