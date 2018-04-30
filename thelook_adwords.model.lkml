connection: "lookerdata_bigquery_standard_sql"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project



explore: events{
  join: sessions {
    relationship: many_to_one
    sql_on: ${events.session_id} = ${sessions.session_id} ;;
  }
  join: user_session_fact {
    view_label: "Users"
    relationship: many_to_one
    type: inner
    sql: ${sessions.session_user_id} = ${session_purchase_facts.session_user_id} ;;
  }
  join: session_purchase_facts {
    relationship: many_to_one
    sql_on: ${sessions.session_user_id} = ${session_purchase_facts.session_user_id}
    and ${sessions.session_start_raw} > ${session_purchase_facts.last_session_end_raw}
    and ${sessions.session_end_raw} < ${session_purchase_facts.session_end_raw};;
  }

  join: adevents {
    relationship: one_to_many
    sql_on: ${events.ad_event_id} = ${adevents.adevent_id}
      and ${events.referrer_code} = ${adevents.keyword_id}
      and ${events.is_entry_event}
      ;;
  }
  join: keywords {
    relationship: many_to_one
    sql_on:${keywords.keyword_id} = ${adevents.keyword_id} ;;
  }
  join: adgroups{
    relationship: many_to_one
    sql_on: ${keywords.ad_id} = ${adgroups.ad_id} ;;
  }
  join: campaigns {
    relationship: many_to_one
    sql_on: ${campaigns.campaign_id} = ${adgroups.campaign_id} ;;
  }
}
