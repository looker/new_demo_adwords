view: session_purchase_facts {
  derived_table: {
    sql_trigger_value: select count(*) from adwords.events;;
    sql:
    select *,
      lag(session_end) over (order by session_user_id, session_end) as last_session_end
      from (
      SELECT
        session_id
        , MIN(created_at) AS session_start
        , MAX(created_at) AS session_end
        , COUNT(*) AS number_of_events_in_session
        , SUM(CASE WHEN event_type = 'Purchase' THEN 1 else 0 end) AS purchase_events
        , MAX(user_id) AS session_user_id
      FROM adwords.events
      GROUP BY session_id
      having sum(CASE WHEN event_type = 'Purchase' THEN 1 else 0 end) > 0
      order by session_user_id
      )
      order by session_user_id, session_end
      ;;
  }

#   select sessions.session_user_id
# , sessions.session_id
# , sessions_purchase.session_purchase_rank
# , sessions.session_start
# -- , count(distinct(sessions_purchase.session_id)) as sessions_till_purchase
# from democorp_scratch.lr$fe5ei6lr1q0h4jireqmlb_sessions as sessions
# join democorp_scratch.LR$FESARW23PGBBQMG1N785G_session_purchase_events as sessions_purchase
#   on sessions.session_user_id = sessions_purchase.session_user_id
#   and sessions.session_start > sessions_purchase.last_session_end and sessions.session_end < sessions_purchase.session_end
# group by 1, 2, 3, 4
# order by 1, 4, 3
# limit 100

  dimension: session_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

#   dimension: session_purchase_rank {
#     type: number
#     sql: ${TABLE}.session_purchase_rank ;;
#   }

  dimension_group: session_start {
    type: time
    sql: ${TABLE}.session_start ;;
  }

  dimension_group: session_end {
    type: time
    sql: ${TABLE}.session_end ;;
  }

  dimension: number_of_events_in_session {
    type: number
    sql: ${TABLE}.number_of_events_in_session ;;
  }

  dimension: sessions_till_purchase {
    type: number
    sql: ${TABLE}.sessions_till_purchase ;;
  }

  dimension: purchase_events {
    type: number
    sql: ${TABLE}.purchase_events ;;
  }

  dimension: session_user_id {
    type: number
    sql: ${TABLE}.session_user_id ;;
  }

  dimension_group: last_session_end {
    type: time
    sql: ${TABLE}.last_session_end ;;
  }

  set: detail {
    fields: [
      session_id,
      session_start_time,
      session_end_time,
      number_of_events_in_session,
      sessions_till_purchase,
      purchase_events,
      session_user_id,
      last_session_end_time
    ]
  }
}
