- dashboard: user_acquisition
  title: User Acquisition
  layout: newspaper
  elements:
  - title: Traffic Source
    name: Traffic Source
    model: thelook_adwords
    explore: user_acquisition
    type: looker_donut_multiples
    fields:
    - user_acquisition.acquisition_source
    - user_acquisition.behavior
    - user_acquisition.count
    pivots:
    - user_acquisition.acquisition_source
    sorts:
    - user_acquisition.count desc 0
    - user_acquisition.behavior
    - user_acquisition.acquisition_source
    limit: 500
    query_timezone: America/Los_Angeles
    show_value_labels: true
    font_size: 18
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hide_legend: false
    row: 0
    col: 4
    width: 10
    height: 8
  - title: New Users
    name: New Users
    model: thelook_adwords
    explore: acquisition_analysis
    type: single_value
    fields:
    - acquisition_analysis.count
    filters:
      acquisition_analysis.first_visit_date: 30 days
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 0
    col: 0
    width: 4
    height: 4
  - title: New Purchases
    name: New Purchases
    model: thelook_adwords
    explore: acquisition_analysis
    type: single_value
    fields:
    - acquisition_analysis.count
    filters:
      acquisition_analysis.first_purchase_date: 30 days
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 4
    col: 0
    width: 4
    height: 4
  - title: Session Retention by Acquisition Source
    name: Session Retention by Acquisition Source
    model: thelook_adwords
    explore: acquisition_analysis
    type: looker_area
    fields:
    - acquisition_analysis.site_acquisition_source
    - acquisition_analysis.session_count
    - acquisition_analysis.count
    pivots:
    - acquisition_analysis.site_acquisition_source
    sorts:
    - acquisition_analysis.count desc 0
    - acquisition_analysis.session_count
    - acquisition_analysis.site_acquisition_source
    limit: 25
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: Display
        name: Display
        axisId: acquisition_analysis.count
      - id: Email
        name: Email
        axisId: acquisition_analysis.count
      - id: Facebook
        name: Facebook
        axisId: acquisition_analysis.count
      - id: Organic
        name: Organic
        axisId: acquisition_analysis.count
      - id: Search
        name: Search
        axisId: acquisition_analysis.count
      showLabels: false
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    row: 15
    col: 0
    width: 12
    height: 8
  - title: Purchase Retention by Acquisition Source
    name: Purchase Retention by Acquisition Source
    model: thelook_adwords
    explore: acquisition_analysis
    type: looker_area
    fields:
    - acquisition_analysis.site_acquisition_source
    - acquisition_analysis.count
    - acquisition_analysis.count_with_purchase
    pivots:
    - acquisition_analysis.site_acquisition_source
    sorts:
    - acquisition_analysis.count desc 0
    - acquisition_analysis.site_acquisition_source
    limit: 25
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: Display
        name: Display
        axisId: acquisition_analysis.count
      - id: Email
        name: Email
        axisId: acquisition_analysis.count
      - id: Facebook
        name: Facebook
        axisId: acquisition_analysis.count
      - id: Organic
        name: Organic
        axisId: acquisition_analysis.count
      - id: Search
        name: Search
        axisId: acquisition_analysis.count
      showLabels: false
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    row: 15
    col: 12
    width: 12
    height: 8
  - title: Customer Trends
    name: Customer Trends
    model: thelook_adwords
    explore: acquisition_analysis
    type: looker_line
    fields:
    - acquisition_analysis.first_visit_month
    - adevents.total_cost
    - acquisition_analysis.average_loyalty
    - acquisition_analysis.average_engagement
    filters:
      adevents.total_cost: ">0"
    sorts:
    - acquisition_analysis.first_visit_month
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    show_null_points: false
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    y_axes:
    - label: Liftetime Visits/Purchases
      orientation: left
      series:
      - id: acquisition_analysis.average_engagement
        name: Average Engagement
        axisId: acquisition_analysis.average_engagement
      - id: acquisition_analysis.average_loyalty
        name: Average Loyalty
        axisId: acquisition_analysis.average_loyalty
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      maxValue:
    - label:
      orientation: right
      series:
      - id: adevents.total_cost
        name: Total Spend
        axisId: adevents.total_cost
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
      maxValue:
      tickDensityCustom: 5
    show_null_labels: false
    x_axis_datetime_label: "%m-%y"
    trend_lines:
    - color: "#b3adad"
      label_position: right
      period: 7
      regression_type: linear
      series_index: 1
      show_label: false
    row: 8
    col: 0
    width: 24
    height: 7
  - title: Purchase Session (Associated Revenue)
    name: Purchase Session (Associated Revenue)
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - session_purchase_facts.purchase_session_source
    - session_purchase_facts.total_attribution
    filters:
      session_purchase_facts.purchase_session_source: Adwords
    sorts:
    - session_purchase_facts.total_attribution desc
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    barColors:
    - red
    - blue
    groupBars: true
    labelSize: 10pt
    showLegend: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    single_value_title: Purchase Session (Revenue)
    row: 0
    col: 14
    width: 5
    height: 8
  - title: Associated Revenue
    name: Associated Revenue
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - session_purchase_facts.total_attribution
    - sessions.traffic_source
    sorts:
    - session_purchase_facts.total_attribution desc
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    barColors:
    - red
    - blue
    groupBars: true
    labelSize: 10pt
    showLegend: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    single_value_title: All Sessions (Revenue)
    row: 0
    col: 19
    width: 5
    height: 8
