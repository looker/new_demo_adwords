view: events {
  sql_table_name: looker-private-demo.ecomm.events ;;

  dimension: event_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

   dimension: utm_code {
    type: string
    sql: CONCAT(SAFE_CAST(${ad_event_id} AS STRING), ' - ', SAFE_CAST(${referrer_code} AS STRING)) ;;
  }

  dimension: ad_event_id {
    type: number
    sql: SAFE_CAST(${TABLE}.ad_event_id AS INT64) ;;
  }

  dimension: referrer_code {
    hidden: yes
    type: number
    sql: SAFE_CAST(${TABLE}.referrer_code AS INT64) ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: event {
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

  filter: previous_period_filter {
    type: date
    description: "Use this filter for period analysis"
  }

  dimension: previous_period {
    type: string
    description: "The reporting period as selected by the Previous Period Filter"
    sql:
        {% if previous_period_filter._in_query %}
            CASE
              WHEN (${event_raw} >=  {% date_start previous_period_filter %}
                  AND ${event_raw}  <= {% date_end previous_period_filter %})
                THEN 'This Period'
              WHEN (date(${event_raw})  >= DATE_SUB(DATE_SUB(date({% date_start previous_period_filter %}), INTERVAL 1 DAY )
                                          , INTERVAL DATE_DIFF(date({% date_end previous_period_filter %}),
                                          date({% date_start previous_period_filter %}), DAY ) + 1 DAY)
                  AND date(${event_raw})  <= DATE_SUB(date({% date_start previous_period_filter %}), INTERVAL 1 DAY ))
                THEN 'Previous Period'
              ELSE NULL END
        {% else %} NULL {% endif %};;
  }


  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}.sequence_number ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}.uri ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: is_entry_event {
    type: yesno
    description: "Yes indicates this was the entry point / landing page of the session"
    sql: ${sequence_number} = 1 ;;
  }

  dimension: is_exit_event {
    type: yesno
    label: "UTM Source"
    sql: ${sequence_number} = ${sessions.number_of_events_in_session} ;;
    description: "Yes indicates this was the exit point / bounce page of the session"
  }

  measure: count_bounces {
    type: count
    description: "Count of events where those events were the bounce page for the session"

    filters: {
      field: is_exit_event
      value: "Yes"
    }
  }

  measure: bounce_rate {
    type: number
    value_format_name: percent_2
    description: "Percent of events where those events were the bounce page for the session, out of all events"
    sql: ${count_bounces}*1.0 / nullif(${count}*1.0,0) ;;
  }

  dimension: full_page_url {
    sql: ${TABLE}.uri ;;
  }

  dimension: viewed_product_id {
    type: number
    sql: CASE
        WHEN ${event_type} = 'Product' THEN SUBSTR(${full_page_url},
        LENGTH(${full_page_url})- (LENGTH(${full_page_url})-10),LENGTH(${full_page_url})-9)
      END
       ;;
  }

##### Funnel Analysis #####

  dimension: funnel_step {
    description: "Login -> Browse -> Add to Cart -> Checkout"
    sql: CASE
        WHEN ${event_type} IN ('Login', 'Home') THEN '(1) Land'
        WHEN ${event_type} IN ('Category', 'Brand') THEN '(2) Browse Inventory'
        WHEN ${event_type} = 'Product' THEN '(3) View Product'
        WHEN ${event_type} = 'Cart' THEN '(4) Add Item to Cart'
        WHEN ${event_type} = 'Purchase' THEN '(5) Purchase'
        ELSE 'No Event'
      END
       ;;

    html:
    {% if value == '(1) Land' %}
      <div style="background: #8BC34A; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == '(2) Browse Inventory' %}
      <div style="background:  #4285F4; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == '(3) View Product' %}
      <div style="background: #FBBC04; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == '(4) Add Item to Cart' %}
      <div style="background: #B31412; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == '(5) Purchase' %}
      <div style="background: #137333; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% else %}
      <div style="background: #EA8600; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% endif %} ;;
  }

  dimension: funnel_step_adwords {
    description: "Login -> Browse -> Add to Cart -> Checkout (for Adwords)"
    sql: CASE
        WHEN ${event_type} IN ('Login', 'Home') and ${utm_code} is not null THEN '(1) Land'
        WHEN ${event_type} IN ('Category', 'Brand') and ${utm_code} is not null THEN '(2) Browse Inventory'
        WHEN ${event_type} = 'Product' and ${utm_code} is not null THEN '(3) View Product'
        WHEN ${event_type} = 'Cart' and ${utm_code} is not null THEN '(4) Add Item to Cart'
        WHEN ${event_type} = 'Purchase' and ${utm_code} is not null THEN '(5) Purchase'
      END
       ;;
  }

#   measure: unique_visitors {
#     type: count_distinct
#     description: "Uniqueness determined by IP Address and User Login"
#     view_label: "Visitors"
#     sql: ${ip} ;;
#     drill_fields: [visitors*]
#   }

  dimension: location {
    type: location
    view_label: "Visitors"
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  dimension: approx_location {
    type: location
    view_label: "Visitors"
    sql_latitude: round(${TABLE}.latitude,1) ;;
    sql_longitude: round(${TABLE}.longitude,1) ;;
  }

#   dimension: has_user_id {
#     type: yesno
#     view_label: "Visitors"
#     description: "Did the visitor sign in as a website user?"
#     sql: ${users.id} > 0 ;;
#   }

  measure: count {
    type: count
    drill_fields: [simple_page_info*]
  }

  measure: sessions_count {
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: count_m {
    label: "Count (MM)"
    type: number
    hidden: yes
    sql: ${count}/1000000.0 ;;
    drill_fields: [simple_page_info*]
    value_format: "#.### \"M\""
  }

#   measure: unique_visitors_m {
#     label: "Unique Visitors (MM)"
#     view_label: "Visitors"
#     type: number
#     sql: count (distinct ${ip}) / 1000000.0 ;;
#     description: "Uniqueness determined by IP Address and User Login"
#     value_format: "#.### \"M\""
#     hidden: yes
#     drill_fields: [visitors*]
#   }
#
#   measure: unique_visitors_k {
#     label: "Unique Visitors (k)"
#     view_label: "Visitors"
#     type: number
#     hidden: yes
#     description: "Uniqueness determined by IP Address and User Login"
#     sql: count (distinct ${ip}) / 1000.0 ;;
#     value_format: "#.### \"k\""
#     drill_fields: [visitors*]
#   }

  set: simple_page_info {
    fields: [
      event_id,
      event_time,
      event_type,
      full_page_url, user_id, funnel_step]
  }

  set: visitors {
    fields: [os, browser, user_id, count]
  }
}
