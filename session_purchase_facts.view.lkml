explore: session_purchase_facts {}

view: session_purchase_facts {
  derived_table: {
    sql_trigger_value: select count(*) from adwords.events;;
    sql:

    with session_purchase as (
      select
      session_rank - lag(session_rank) over(partition by session_user_id order by session_end) as sessions_till_purchase
      , lag(session_end) over(partition by session_user_id order by session_end) as purchase_session_start

      ,*
      from ${sessions.SQL_TABLE_NAME}
      where purchase_events > 0
      order by session_user_id, session_rank
    ) ,
    session_contains_search as (
    select
      session_purchase.session_id,
      sum(case when sessions.traffic_source = 'Search' then 1 else 0 end) as search_sessions
    from session_purchase
    join ${sessions.SQL_TABLE_NAME}  as sessions
    on session_purchase.session_user_id = sessions.session_user_id and sessions.session_start >= session_purchase.purchase_session_start and sessions.session_end <= session_purchase.session_end
    group by 1

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
        , sum(search_sessions) as search_session_count
        , MIN(events.created_at) AS session_start
        , MAX(events.created_at) AS session_end
        , MAX(events.user_id) AS session_user_id
      FROM adwords.events
      JOIN adwords.order_items on order_items.created_at = events.created_at
      JOIN session_purchase on session_purchase.session_id = events.session_id
      JOIN session_contains_search on session_purchase.session_id = session_contains_search.session_id
      GROUP BY session_id, order_id
      having sum(CASE WHEN event_type = 'Purchase' THEN 1 else 0 end) > 0
      order by session_user_id
    )
    order by session_user_id, session_end
    ;;


  }

  dimension: session_id {
#     hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: contains_search {
    label: "Sessions leading up to Purchase contains search"
    type: yesno
    sql: ${TABLE}.search_session_count > 0 ;;
  }

  measure: conversions_from_search {
    view_label: "Adevents"
    description: "All Conversions with Traffic Source *Search* as a touch point"
    type: count_distinct
    sql: ${session_purchase_facts.order_id} ;;
    filters: {
      field: session_purchase_facts.contains_search
      value: "yes"
    }
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

#   measure: total_adwords_conversions {
#     type: count_distinct
#     sql: ${order_id} ;;
#     filters: {
#       field: sessions.contains_search
#       value: "yes"
#     }
#   }

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



#     with session_purchase_rank as (
#       select
#       --Contains AdWords
#       session_rank - lag(session_rank) over(partition by session_user_id order by session_end) as sessions_till_purchase
#       ,*
#       from ${sessions.SQL_TABLE_NAME}
#       where purchase_events > 0
#       order by session_user_id, session_rank
#     )
#     select *,
#         lag(session_end) over (order by session_user_id, session_end) as last_session_end
#         , rank() over (partition by session_user_id order by session_end) as session_purchase_rank
#
#     from (
#       SELECT
#         events.session_id
#         , order_id
#         , sum(sessions_till_purchase) as sessions_till_purchase
#         , sum(sale_price) AS sale_price
#         , MIN(events.created_at) AS session_start
#         , MAX(events.created_at) AS session_end
#         , MAX(events.user_id) AS session_user_id
#       FROM adwords.events
#       JOIN adwords.order_items on order_items.created_at = events.created_at
#       JOIN session_purchase_rank on session_purchase_rank.session_id = events.session_id
#       GROUP BY session_id, order_id
#       having sum(CASE WHEN event_type = 'Purchase' THEN 1 else 0 end) > 0
#       order by session_user_id
#     )
#     order by session_user_id, session_end
#
#       ;;
