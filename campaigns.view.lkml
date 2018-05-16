view: campaigns {
  sql_table_name: adwords.campaigns ;;

  filter: campaign_selector {
    type: string
    suggest_dimension: campaign_name
  }

  dimension: campaign_benchmark {
    type: string
    sql: IF( {% condition campaign_selector %} ${campaign_name} {% endcondition %}, ${campaign_name}, 'Benchmark') ;;
  }

  dimension: campaign_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: advertising_channel {
    type: string
    sql: ${TABLE}.advertising_channel ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: bid_type {
    type: string
    sql: ${TABLE}.bid_type ;;
  }

  dimension: campaign_name {
    type: string
    sql: concat(cast(${campaign_id} as string), " - " , ${campaign_name_raw}) ;;
    link: {
      label: "View on AdWords"
      icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
      url: "https://adwords.google.com/aw/adgroups?campaignId={{ campaign_id._value | encode_uri }}"
    }
    link: {
      label: "Pause Campaign"
      icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
      url: "https://adwords.google.com/aw/ads?campaignId={{ campaign_id._value | encode_uri }}"
    }
    link: {
      url: "https://adwords.google.com/aw/ads?campaignId={{ campaign_id._value | encode_uri }}"
      icon_url: "https://www.gstatic.com/awn/awsm/brt/awn_awsm_20171108_RC00/aw_blend/favicon.ico"
      label: "Change Budget"
    }
  }

  dimension: campaign_name_raw {
    label: "Campaign Name"
    hidden: yes
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_type {
    sql: SUBSTR(SUBSTR(${campaign_name_raw},STRPOS(${campaign_name_raw},' - ')+3),STRPOS(SUBSTR(${campaign_name_raw},STRPOS(${campaign_name_raw},' - ')+3),' - ')+3) ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: DATE_ADD(${created_raw}, INTERVAL ${period} DAY) ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: is_active_now {
    type: yesno
    sql: ${end_date} >= current_date() ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_id, campaign_name, adgroups.count]
  }
}
