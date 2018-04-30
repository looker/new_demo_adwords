view: session_purchase_facts {
  derived_table: {
    sql_trigger_value: select count(*) from adwords.events;;
    sql:

    with session_purchase_rank as (
      select
      --Contains AdWords
      session_rank - lag(session_rank) over(partition by session_user_id order by session_end) as sessions_till_purchase
      ,*
      from ${sessions.SQL_TABLE_NAME}
      where purchase_events > 0
      order by session_user_id, session_rank
    )
    select *,
        lag(session_end) over (order by session_user_id, session_end) as last_session_end
        , rank() over (partition by session_user_id order by session_end) as session_purchase_rank

    from (
      SELECT
        events.session_id
        , order_id
        , sum(sessions_till_purchase) as sessions_till_purchase
        , sum(sale_price) AS sale_price
        , MIN(events.created_at) AS session_start
        , MAX(events.created_at) AS session_end
        , MAX(events.user_id) AS session_user_id
      FROM adwords.events
      JOIN adwords.order_items on order_items.created_at = events.created_at
      JOIN session_purchase_rank on session_purchase_rank.session_id = events.session_id
      GROUP BY session_id, order_id
      having sum(CASE WHEN event_type = 'Purchase' THEN 1 else 0 end) > 0
      order by session_user_id
    )
    order by session_user_id, session_end

      ;;
  }

  dimension: session_id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: sessions_till_purchase {
    type: number
    sql: ${TABLE}.sessions_till_purchase ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: percent_attribution_per_session {
    type: number
    sql: 1.0/nullif(${sessions_till_purchase},0 );;
  }

  dimension: attribution_per_session {
    view_label: "Sessions"
    type: number
    sql: 1.0 * ${sale_price}/nullif(${sessions_till_purchase},0 );;
    value_format_name: usd_0
  }

  measure: total_attribution {
    view_label: "Sessions"
    type: sum
    sql: ${attribution_per_session} ;;
    value_format_name: usd_0
  }

#   measure: total_sale_price {
#     type: sum
#     sql: ${sale_price} ;;
#     value_format_name: usd
#   }

  dimension: session_purchase_rank {
    type: number
    sql: ${TABLE}.session_purchase_rank ;;
  }

  dimension_group: last_session_end {
    type: time
    sql: ${TABLE}.last_session_end ;;
  }

  dimension_group: session_start {
    type: time
    sql: ${TABLE}.session_start ;;
  }

  dimension_group: session_end {
    type: time
    sql: ${TABLE}.session_end ;;
  }

  dimension: session_user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.session_user_id ;;
  }

#   measure: count_purchases {
#     type: count
#     filters: {
#       field: sessions.traffic_source
#       value: "Search"
#     }
#   }

  set: detail {
    fields: [
      session_id,
      session_start_time,
      session_end_time,
      session_user_id,
      last_session_end_time
    ]
  }
}



  #     select *,
#         lag(session_end) over (order by session_user_id, session_end) as last_session_end
#         , rank() over (partition by session_user_id order by session_end) as session_purchase_rank
#
#       from (
#       SELECT
#         session_id
#         , order_id
#         , sum(sale_price) AS sale_price
#         , MIN(events.created_at) AS session_start
#         , MAX(events.created_at) AS session_end
#         , MAX(events.user_id) AS session_user_id
#       FROM adwords.events
#       JOIN adwords.order_items on order_items.created_at = events.created_at
#       GROUP BY session_id, order_id
#       having sum(CASE WHEN event_type = 'Purchase' THEN 1 else 0 end) > 0
#       order by session_user_id
#       )
#       order by session_user_id, session_end
