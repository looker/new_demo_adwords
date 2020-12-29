view: session_purchase {
  derived_table: {
    datagroup_trigger: ecommerce_etl
    publish_as_db_view: yes
    sql:
      select
      coalesce(session_rank - lag(session_rank) over(partition by session_user_id order by session_end), session_rank) as sessions_till_purchase
      , session_rank as rank
      , rank() over (partition by session_user_id order by session_end) as session_purchase_rank
      , lag(session_end) over(partition by session_user_id order by session_end) as purchase_session_start
      ,*
      from ${sessions.SQL_TABLE_NAME}
      where purchase_events > 0
      order by session_user_id, session_rank
    ;;
  }

  dimension: session_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: sessions_till_purchase {
    type: number
    sql: ${TABLE}.sessions_till_purchase ;;
  }

  dimension: session_purchase_rank {
    view_label: "Sessions"
    type: number
    sql: ${TABLE}.session_purchase_rank ;;
  }

  dimension_group: session_end {
    type: time
    view_label: "Sessions"
    label: "Purchase End Session"
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.session_end ;;
  }

  dimension_group: session_start {
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.session_start ;;
  }

  dimension: session_user_id {
    type: number
    sql: ${TABLE}.session_user_id ;;
  }

  dimension: traffic_source {
    type: string
  }

  dimension: ad_event_id {
    type: number
  }

  dimension: session_rank {
    type: number
    sql: ${TABLE}.session_rank ;;
  }

  dimension: purchase_rank {
    type: number
    sql: ${TABLE}.purchase_rank ;;
  }

  dimension: session_type {
    description: "Used for Pivots"
    type: string
    sql: 'All' ;;
  }

  dimension: landing_event_id {
    sql: ${TABLE}.landing_event_id ;;
  }

  dimension: bounce_event_id {
    sql: ${TABLE}.bounce_event_id ;;
  }

  dimension: number_of_browse_events_in_session {
    type: number
    sql: ${TABLE}.browse_events ;;
  }

  dimension: number_of_product_events_in_session {
    type: number
    sql: ${TABLE}.product_events ;;
  }

  dimension: number_of_cart_events_in_session {
    type: number
    sql: ${TABLE}.cart_events ;;
  }

  dimension: number_of_purchase_events_in_session {
    type: number
    sql: ${TABLE}.purchase_events ;;
  }

  dimension: number_of_events_in_session {
    type: number
    sql: ${TABLE}.number_of_events_in_session ;;
  }
}
