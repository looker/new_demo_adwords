view: campaigns {
  sql_table_name: adwords.campaigns ;;

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
    sql: ${TABLE}.campaign_name ;;
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

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: is_active {
    type: yesno
    sql: DATEADD(${campaign_id}, 3, month) ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_id, campaign_name, adgroups.count]
  }
}
