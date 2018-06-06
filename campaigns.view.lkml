view: campaigns {
#   sql_table_name: ecomm.campaigns ;;
derived_table: {
  sql_trigger_value: select count(*) from ecomm.campaigns ;;
  distribution: "id"
  sortkeys: ["id"]
  sql: SELECT *
            FROM   ecomm.campaigns
            UNION
            SELECT 9999                        AS id,
            NULL                        AS advertising_channel,
            0                           AS amount,
            NULL                        AS bid_type,
            'Total'                     AS campaign_name,
            '60'                        AS period,
            Dateadd(day, -1, Getdate()) AS created_at ;;
}

##### Campaign Facts #####

  filter: campaign_selector {
    type: string
    suggest_dimension: campaign_name
  }

  dimension: campaign_benchmark {
    type: string
    sql: case when ( {% condition campaign_selector %} ${campaign_name} {% endcondition %}) then ${campaign_name} else 'Benchmark' end  ;;
  }

  dimension: campaign_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
    sql: ${campaign_id}::VARCHAR +  ' - ' + ${campaign_name_raw} ;;
    link: {
      label: "Campaign Performance Dashboard"
      icon_url: "http://www.looker.com/favicon.ico"
      url: "https://demo.looker.com/dashboards/3016?Campaign Name={{ value | encode_uri }}"
    }
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
  }

  dimension: campaign_name_raw {
    label: "Campaign Abbreviated"
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
    sql: date_add('day', ${period},${created_date}) ;;
  }

  dimension: day_of_quarter {
    type: number
    sql: DATEDIFF(
        'day',
        CAST(CONCAT(${created_quarter}, '-01') as date),
        ${created_raw})
       ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period :: int ;;
  }

  dimension: is_active_now {
    type: yesno
    sql: ${end_date} >= CURRENT_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_id, campaign_name, adgroups.count]
  }

  set: detail {
    fields: [
      campaign_id, campaign_name, adgroups.count
    ]
  }
}
