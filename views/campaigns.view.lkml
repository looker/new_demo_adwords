view: campaigns {

derived_table: {
  datagroup_trigger: ecommerce_etl
  sql: SELECT *
      FROM   looker-private-demo.ecomm.campaigns
      UNION ALL
      SELECT 9999                 AS id,
      NULL                        AS advertising_channel,
      0                           AS amount,
      NULL                        AS bid_type,
      'Total'                     AS campaign_name,
      '60'                        AS period,
      date_add(current_date(), interval -1 day) AS created_at  ;;
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
    full_suggestions: yes
    type: string
    sql: CONCAT(${campaign_id},' - ',${campaign_name_raw}) ;;
    link: {
      label: "Campaign Performance Dashboard"
      icon_url: "http://www.looker.com/favicon.ico"
      url: "/dashboards/pwSkck3zvGd1fnhCO7Fc12?Campaign Name={{ value | encode_uri }}"
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
    action: {
      label: "Send to Chat"
      icon_url: "https://www.google.com/s2/favicons?domain=https://chat.google.com/"
      url: "https://us-central1-looker-private-demo.cloudfunctions.net/sendtomsteams"

      param: {
        name: "msteamswebhook"
        value: "https://outlook.office.com/webhook/ea063618-4f80-4b0e-9e56-ba2fa46cce15@d218a038-fce6-4d24-b555-da29bdb61480/IncomingWebhook/a5d535f262ca40978bc1f14dadc19b46/d9cd9560-7bf0-4648-879a-ea56deebb579"
      }

      param: {
        name: "link"
        value: "https://demo.looker.com/dashboards/pwSkck3zvGd1fnhCO7Fc12?Campaign%20Name={{value | encode_uri}}"
      }

      param: {
        name: "linktext"
        value: "{{value}} Campaign Dashboard"
      }

      form_param: {
        name: "Title"
        type: string
        default: "You should take a look at this campaign: {{value}}"
      }

      form_param: {
        name: "Message"
        type: textarea
        default: "Hey,
        Could you check out the latest on {{value}}?"
      }
    }
    action: {
      label: "Send to Slack"
      icon_url: "https://www.google.com/s2/favicons?domain=https://slack.com/"
      url: "https://us-central1-looker-private-demo.cloudfunctions.net/sendtomsteams"

      param: {
        name: "msteamswebhook"
        value: "https://outlook.office.com/webhook/ea063618-4f80-4b0e-9e56-ba2fa46cce15@d218a038-fce6-4d24-b555-da29bdb61480/IncomingWebhook/a5d535f262ca40978bc1f14dadc19b46/d9cd9560-7bf0-4648-879a-ea56deebb579"
      }

      param: {
        name: "link"
        value: "https://demo.looker.com/dashboards/pwSkck3zvGd1fnhCO7Fc12?Campaign%20Name={{value | encode_uri}}"
      }

      param: {
        name: "linktext"
        value: "{{value}} Campaign Dashboard"
      }

      form_param: {
        name: "Title"
        type: string
        default: "You should take a look at this campaign: {{value}}"
      }

      form_param: {
        name: "Message"
        type: textarea
        default: "Hey,
        Could you check out the latest on {{value}}?"
      }
    }
  }

  dimension: campaign_name_raw {
    label: "Campaign Abbreviated"
    sql: ${TABLE}.campaign_name ;;
    link: {
      label: "Campaign Performance Dashboard"
      icon_url: "http://www.looker.com/favicon.ico"
      url: "/dashboards/pwSkck3zvGd1fnhCO7Fc12?Campaign Name={{ campaign_name._value | encode_uri }}"
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

  dimension: campaign_type {
    sql: REGEXP_EXTRACT(${campaign_name_raw}, r"^\S+ - \S+ - (\S+)") ;;
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
    sql: date_add(${created_date}, INTERVAL ${period} DAY) ;;
  }

  dimension: day_of_quarter {
    type: number
    sql: DATE_DIFF(${created_raw}, CAST(CONCAT(${created_quarter}, '-01') as date), DAY)  ;;
  }

  dimension: period {
    type: number
    sql:  SAFE_CAST(${TABLE}.period AS INT64);;
  }

  dimension: is_active_now {
    type: yesno
    sql: ${end_date} >= CURRENT_DATE() ;;
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
