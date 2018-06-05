connection: "demonew_events_ecommerce"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: events{
  join: sessions {
    relationship: many_to_one
    sql_on: ${events.session_id} = ${sessions.session_id} ;;
  }
  join: user_acquisition {
    view_label: "Users"
    relationship: many_to_one
    sql_on: ${events.user_id} = ${user_acquisition.session_user_id} ;;
  }
  join: users {
    view_label: "Users"
    relationship: many_to_one
    sql_on: ${events.user_id} = ${users.id} ;;
    fields: [user_facts*]
  }
  join: user_session_fact {
    view_label: "Users"
    relationship: one_to_one
    sql_on: ${events.user_id} = ${user_session_fact.session_user_id} ;;
#     fields: [user_session_measures*] -- ZL: commenting out so I can use first and last touch attribution sources as regular dimensions
  }

#ZL: Getting rid of this because we're probably not going to use it
#   join: user_purchase_facts {
#     view_label: "Users"
#     relationship: one_to_one
#     sql_on: ${events.user_id} = ${user_purchase_facts.user_id} ;;
#   }


  join: session_purchase_facts {
    relationship: many_to_one
    sql_on: ${sessions.session_user_id} = ${session_purchase_facts.session_user_id}
    and ${sessions.session_start_raw} >= ${session_purchase_facts.last_session_end_raw}
    and ${sessions.session_end_raw} <= ${session_purchase_facts.session_end_raw};;
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

explore: acquisition_analysis {
  view_label: "Users"
  from: user_session_fact

  join: user_acquisition {
    relationship: one_to_many
    sql_on: ${acquisition_analysis.session_user_id} = ${user_acquisition.session_user_id} ;;
  }

  join: adevents {
    type: inner
    relationship: one_to_one
    sql_on: ${acquisition_analysis.site_acquisition_ad_event_id} = ${adevents.adevent_id};;
  }
  join: users {
    relationship: one_to_one
    sql_on: ${acquisition_analysis.session_user_id} = ${users.id} ;;
  }
  join: keywords {
    type: inner
    relationship: many_to_one
    sql_on:${keywords.keyword_id} = ${adevents.keyword_id} ;;
  }
  join: adgroups{
    type: inner
    relationship: many_to_one
    sql_on: ${keywords.ad_id} = ${adgroups.ad_id} ;;
  }
  join: campaigns {
    type: inner
    relationship: many_to_one
    sql_on: ${campaigns.campaign_id} = ${adgroups.campaign_id} ;;
  }
  join: order_items {
    relationship: one_to_many
    type: left_outer
    sql_on: ${acquisition_analysis.session_user_id} = ${order_items.user_id};;
  }
}
