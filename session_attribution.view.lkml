include: "session_purchase_facts.view.lkml"         # include all views in this project
view: session_attribution {
  extends: [session_purchase_facts]

#   dimension: percent_attribution_per_session {
#     view_label: "Sessions"
#     label: "Multi-Touch Linear Attribution"
#     description: "Associated Weight (%) from sales based on a linear multi-touch source attribution"
#     type: number
#     sql: 1.0/nullif(${sessions_till_purchase},0 );;
#     drill_fields: [detail*]
#   }

  dimension: contains_search {
    view_label: "Ad Events"
    label: "Sessions leading up to Purchase contains search"
    type: yesno
    sql: ${TABLE}.search_session_count > 0 ;;
  }
#
  measure: conversions_from_search {
    view_label: "Ad Events"
    description: "All Conversions with Traffic Source *Search* as a touch point"
    type: count_distinct
    sql: ${session_purchase_facts.order_id} ;;
    filters: {
      field: contains_search
      value: "yes"
    }
  }

  dimension: attribution_per_session {
    view_label: "Sessions"
    description: "Associated Revenue ($) from sales based on a linear multi-touch source attribution"
    hidden: yes
    type: number
    sql: 1.0 * ${gross_revenue}/nullif(${sessions_till_purchase},0 );;
    value_format_name: usd
    drill_fields: [detail*]
  }

  measure: total_attribution {
    view_label: "Sessions"
    label: "Associated Revenue (ROI)"
    type: sum_distinct
    sql_distinct_key: ${sessions.session_id} ;;
    sql: ${attribution_per_session} ;;
    value_format_name: usd
    drill_fields: [attribution_detail*]
  }

  measure: ROI {
    view_label: "Sessions"
    label: "ROI (Revenue/Cost)"
    type: number
    value_format_name: usd
    sql: 1.0 * ${total_attribution}/ NULLIF(${adevents.total_cost},0) - 1 ;;
  }


#   ----------------------------------------------------  #

  parameter: attribution_filter {
    view_label: "Cohort"
    label: "Attribution Picker"
    description: "Choose a type of Attribution"
    allowed_value: { value: "Acquisition Source" }
    allowed_value: { value: "Last Touch" }
    allowed_value: { value: "Multi-Touch Linear" }
  }

  dimension: attribution_source {
    view_label: "Cohort"
    type: string
    description: "Use in conjuction with the Attribution Picker"
    sql: CASE
          WHEN {% parameter attribution_filter %} = 'Acquisition Source' THEN ${user_session_fact.site_acquisition_source}
          WHEN {% parameter attribution_filter %} = 'Last Touch' THEN ${purchase_session_source}
          WHEN {% parameter attribution_filter %} = 'Multi-Touch Linear' THEN ${sessions.traffic_source}
          ELSE NULL
        END ;;
#     html:  {% if metric_name._value contains 'User Retention' %}
#             {{ linked_value }}{{ format_symbol._value }}
#           {% else %}
#             {{ format_symbol._value }}{{ linked_value }}
#           {% endif %} ;;
#     drill_fields: [cohort_size, percent_user_retention, users.count, average_orders_per_user, average_spend_per_user]
      label_from_parameter: attribution_filter
    }

  set: attribution_detail {
    fields: [
      attribution_per_session,
      total_attribution,
      ROI,
      attribution_filter,
      attribution_source,
    ]
  }
}
