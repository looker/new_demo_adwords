include: "thelook_adwords.model.lkml"

view: user_session_fact {
  derived_table: {
    sql_trigger_value: select count(*) from events ;;
    explore_source: events {
      column: session_user_id { field: sessions.session_user_id }
      column: acquisition_ad_event_id { field: sessions.acquisition_ad_event_id }
      column: acquisition_source { field: sessions.acquisition_source }
      column: session_count { field: sessions.count }
      column: count_bounce_sessions { field: sessions.count_bounce_sessions }
      column: count_with_cart { field: sessions.count_with_cart }
      column: count_with_purchase { field: sessions.count_with_purchase }
    }
  }
  dimension: session_user_id {}
  dimension: acquisition_ad_event_id {
    type: number
  }
  dimension: acquisition_source {
    type: number
  }
  dimension: session_count {
    type: number
  }
  dimension: count_bounce_sessions {
    type: number
  }
  dimension: count_with_cart {
    type: number
  }
  dimension: count_with_purchase {
    type: number
  }
  measure: count {
    type: count
  }
}
