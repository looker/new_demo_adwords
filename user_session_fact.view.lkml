explore: user_acquisition {
  hidden: yes
}
view: user_acquisition {
  derived_table: {
    sql_trigger_value: select count(*) from ${user_session_fact.SQL_TABLE_NAME} ;;
    distribution: "session_user_id"
    sortkeys: ["session_user_id"]
    sql:
          SELECT
          session_user_id
          ,COALESCE(purchase_acquisition_source,'Organic') as acquisition_source
          ,'First Purchase' as behavior
          FROM  ${user_session_fact.SQL_TABLE_NAME}


          UNION ALL

          SELECT
          session_user_id
          ,site_acquisition_source as acquisition_source
          ,'First Visit' as behavior
          FROM  ${user_session_fact.SQL_TABLE_NAME}
    ;;
  }

  dimension: session_user_id {
    primary_key: yes
  }
  dimension: acquisition_source {
    group_label: "Attribution"
  }
  dimension: behavior {}
  measure: count {
    type: count
  }
}


view: user_session_fact {
  derived_table: {
    distribution: "session_user_id"
    sortkeys: ["session_user_id"]
    sql_trigger_value: select count(*) from ecomm.events ;;
    explore_source: events {
      column: session_user_id { field: sessions.session_user_id }
#       column: session_id {field: sessions.session_id}
      column: site_acquisition_ad_event_id { field: sessions.site_acquisition_ad_event_id }
      column: site_acquisition_source { field: sessions.site_acquisition_source }
      column: first_visit_dt { field: sessions.first_visit_dt }
      column: purchase_acquisition_ad_event_id { field: sessions.purhcase_acquisition_ad_event_id }
      column: purchase_acquisition_source { field: sessions.purchase_acquisition_source }
      column: first_purchase_dt { field: sessions.first_purchase_dt }
      column: session_count { field: sessions.count }
      column: count_bounce_sessions { field: sessions.count_bounce_sessions }
      column: count_with_cart { field: sessions.count_with_cart }
      column: count_with_purchase { field: sessions.count_with_purchase }
    }
  }
  dimension: session_user_id {
    primary_key: yes
  }

  dimension: site_acquisition_ad_event_id {
    type: number
    sql: ${TABLE}.site_acquisition_ad_event_id :: int ;;
  }
  dimension: site_acquisition_source {
    type: string
  }
  dimension_group: first_visit {
    type: time
    timeframes:
      [
      raw
      ,date
      ,week
      ,month
      ,quarter
      ,year
      ,day_of_week
      ,day_of_month
      ,week_of_year
      ,month_num
      ,quarter_of_year
      ]
      sql: ${TABLE}.first_visit_dt ;;
  }
  dimension: purchase_acquisition_ad_event_id {
    type: number
  }
  dimension: purchase_acquisition_source {
    type: string
    sql: COALESCE(${TABLE}.purchase_acquisition_source,'Organic') ;;
  }
  dimension_group: first_purchase {
    type: time
    timeframes:
    [
      raw
      ,date
      ,week
      ,month
      ,quarter
      ,year
      ,day_of_week
      ,day_of_month
      ,week_of_year
      ,month_num
      ,quarter_of_year
    ]
    sql: ${TABLE}.first_purchase_dt ;;
  }
  dimension: session_count {
    label: "Lifetime Sessions"
    type: number
    drill_fields: [first_visit_month]
  }
  dimension: session_count_tier {
    label: "Lifetime Sessions Tier"
    type: tier
    sql: ${session_count} ;;
    tiers: [0,3,6,9]
    style: integer
  }

  dimension: count_bounce_sessions {
    type: number
  }
  dimension: count_with_cart {
    type: number
  }
  dimension: count_with_purchase {
    type: number
    drill_fields: [first_visit_month]
  }
  dimension: count_with_purchase_tier {
    label: "Lifetime Purchases Tier"
    type: tier
    sql: ${count_with_purchase} ;;
    tiers: [0,1,3]
    style: integer

  }

  measure: count {
    type: count
    drill_fields: [campaigns.advertising_channel,count_p1]
  }
  measure: count_p1 {
    label: "Count"
    hidden: yes
    type: count
    drill_fields: [campaigns.campaign_type,count_p2]
  }
  measure: count_p2 {
    label: "Count"
    hidden: yes
    type: count
    drill_fields: [campaigns.campaign_name_raw,count_p3]
  }
  measure: count_p3 {
    label: "Count"
    hidden: yes
    type: count
    drill_fields: [keywords.criterion_name,count_p4]
  }
  measure: count_p4 {
    label: "Count"
    hidden: yes
    type: count
  }
  measure: average_loyalty {
    type: average
    value_format_name: decimal_1
    sql: ${count_with_purchase} ;;
  }
  measure: average_engagement {
    type: average
    value_format_name: decimal_1
    sql: ${session_count} ;;
  }

  set: user_session_measures {
    fields: [
      first_visit_month,
      average_engagement,
      average_loyalty
    ]
  }
}
