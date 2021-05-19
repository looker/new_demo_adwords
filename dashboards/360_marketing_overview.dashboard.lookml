- dashboard: 360_marketing_overview
  title: 360 Marketing Overview
  layout: newspaper
  preferred_viewer: dashboards
  query_timezone: user_timezone
  elements:
  - title: Customer Trends
    name: Customer Trends
    model: thelook_adwords
    explore: events
    type: looker_area
    fields: [sessions.session_start_month, adevents.total_cost, session_purchase_facts.revenue]
    filters:
      adevents.total_cost: ">0"
      sessions.traffic_source: Adwords
      adevents.adevent_id: NOT NULL
    sorts: [sessions.session_start_month]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: adevents.total_cost, name: Total
              Spend, axisId: adevents.total_cost}, {id: session_purchase_facts.revenue,
            name: Revenue, axisId: session_purchase_facts.revenue}], showLabels: true,
        showValues: true, maxValue: !!null '', minValue: !!null '', valueFormat: "$#,##0",
        unpinAxis: false, tickDensity: default, tickDensityCustom: 11, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hidden_series: [user_session_fact.average_engagement, user_session_fact.average_loyalty]
    legend_position: center
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: false
    label_density: 25
    label_color: []
    x_axis_scale: ordinal
    y_axis_combined: true
    show_null_points: false
    interpolation: monotone
    show_totals_labels: true
    show_silhouette: false
    ordering: none
    show_null_labels: false
    hidden_fields: []
    listen:
    row: 7
    col: 0
    width: 14
    height: 7
  - name: "<span class='fa fa-tachometer'> Customer Behavior</span>"
    type: text
    title_text: "<span class='fa fa-tachometer'> Customer Behavior</span>"
    subtitle_text: Where are our customers coming from and when do they drop off?
    row: 14
    col: 0
    width: 24
    height: 3
  filters:
  - name: Acquisition Date
    title: Acquisition Date
    type: date_filter
    default_value: 12 months
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
