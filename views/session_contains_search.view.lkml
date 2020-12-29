view: session_contains_search {
  derived_table: {
    datagroup_trigger: ecommerce_etl
    publish_as_db_view: yes
    sql:
     select
       session_purchase.session_id,
       sum(case when sessions.traffic_source = 'Adwords' then 1 else 0 end) as search_sessions
     from ${session_purchase.SQL_TABLE_NAME} as session_purchase
     join ${sessions.SQL_TABLE_NAME}  as sessions
     on session_purchase.session_user_id = sessions.session_user_id and sessions.session_start >= session_purchase.purchase_session_start and sessions.session_end <= session_purchase.session_end
     group by 1
    ;;
  }

  dimension: session_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: search_sessions {
    type: number
    sql: ${TABLE}.search_sessions ;;
  }
}
