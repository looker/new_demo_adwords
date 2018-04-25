view: adevents {
  sql_table_name: adwords.adevents ;;

  dimension: adevent_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.event_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: keyword_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.keyword_id ;;
  }

  dimension: is_click_event {
    type: yesno
    sql: case when ${event_type} = "click" then 1 else 0 end;;
  }
  dimension: is_impression_event {
    type: yesno
    sql: case when ${event_type} = "impression" then 1 else 0 end;;
  }

  dimension: cost {
    type: number
    sql: (1.0*${TABLE}.cost)/100 ;;
    value_format_name: usd
  }

  measure: total_ad_events {
    hidden: yes
    type: count
    drill_fields: [events.id, keywords.criterion_name, keywords.keyword_id]
  }

  measure: total_cost_clicks {
    label: "Total Cost (clicks)"
    type: sum
    sql: ${cost} ;;
    filters: {
      field: event_type
      value: "click"
    }
    value_format_name: usd
  }

  measure: total_clicks {
    type: sum
    sql: case when ${event_type} = "click" then 1 else 0 end;;
  }

  measure: total_impressions {
    type: sum
    sql: case when ${event_type} = "impression" then 1 else 0 end;;
  }

  measure: click_rate {
    label: "Click Through Rate"
    description: "Percent of people that click on an ad."
    type: number
    sql: ${total_clicks}*1.0/nullif(${total_impressions},0) ;;
    value_format_name: percent_2
  }

  measure: cost_per_click {
    label: "Cost per Click"
    description: "Average cost per ad click."
    type: number
    sql: ${total_cost_clicks}* 1.0/ NULLIF(${total_clicks},0) ;;
    value_format_name: usd
  }
}
