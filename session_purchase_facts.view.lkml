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
    ),
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
          COALESCE(lag(session_end) over (order by session_user_id, session_start), '0001-01-01 00:00:00') as last_session_end
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
      --GROUP BY session_id
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

  dimension: contains_search {
    view_label: "Ad Events"
    label: "Sessions leading up to Purchase contains search"
    type: yesno
    sql: ${TABLE}.search_session_count > 0 ;;
  }

  measure: conversions_from_search {
    view_label: "Ad Events"
    description: "All Conversions with Traffic Source *Search* as a touch point"
    type: count_distinct
    sql: ${session_purchase_facts.order_id} ;;
    filters: {
      field: session_purchase_facts.contains_search
      value: "yes"
    }
  }

  dimension: sessions_till_purchase {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.sessions_till_purchase,1) ;;
  }

  dimension: sale_price {
    hidden: yes
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: percent_attribution_per_session {
    label: "Multi-Touch Linear Attribution"
    description: "Associated Weight (%) from sales based on a linear multi-touch source attribution"
    view_label: "Sessions"
    type: number
    sql: 1.0/nullif(${sessions_till_purchase},0 );;
  }

  dimension: attribution_per_session {
    description: "Associated Revenue ($) from sales based on a linear multi-touch source attribution"
    hidden: yes
    view_label: "Sessions"
    type: number
    sql: 1.0 * ${sale_price}/nullif(${sessions_till_purchase},0 );;
    value_format_name: usd
  }

  measure: total_attribution {
    view_label: "Sessions"
    type: sum_distinct
    sql_distinct_key: ${sessions.session_id} ;;
    sql: ${attribution_per_session} ;;
    value_format_name: usd
  }

#   measure: total_sale_price {
#     type: sum
#     sql: ${sale_price} ;;
#     value_format_name: usd
#   }

#   measure: total_sessions_till_purchase {
#     type: sum
#     sql: ${sessions_till_purchase} ;;
#   }

  dimension: session_purchase_rank {
    view_label: "Sessions"
    type: number
    sql: ${TABLE}.session_purchase_rank ;;
  }

  dimension_group: last_session_end {
    label: "Purchase Start Session"
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.last_session_end;;
  }

  dimension_group: session_start {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.session_start ;;
  }

  dimension_group: session_end {
    type: time
    label: "Purchase End Session"
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.session_end ;;
  }

  dimension: session_user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.session_user_id ;;
  }

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
