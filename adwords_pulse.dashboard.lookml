- dashboard: business_pulse
  title: Business Pulse
  layout: newspaper
  elements:
  - title: Total Costs
    name: Total Costs
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - adevents.total_cost
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
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
    single_value_title: Total Spend
    comparison_label: Weekly Change
    listen:
      Date: events.event_date
    row: 0
    col: 10
    width: 7
    height: 5
  - title: Associated Revenue
    name: Associated Revenue
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - session_purchase_facts.total_attribution
    filters:
      sessions.traffic_source: Adwords
    sorts:
    - session_purchase_facts.total_attribution desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
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
    single_value_title: Associated Revenue
    comparison_label: Cost
    hidden_fields: []
    listen:
      Date: events.event_date
    row: 0
    col: 17
    width: 7
    height: 5
  - title: Total Clicks by Channel
    name: Total Clicks by Channel
    model: thelook_adwords
    explore: events
    type: looker_column
    fields:
    - adevents.total_clicks
    - campaigns.advertising_channel
    - adevents.created_date
    pivots:
    - campaigns.advertising_channel
    fill_fields:
    - adevents.created_date
    filters:
      campaigns.advertising_channel: "-NULL"
    sorts:
    - campaigns.advertising_channel
    - adevents.created_date desc
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: normal
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
    column_spacing_ratio:
    column_group_spacing_ratio:
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Date: events.event_date
    row: 16
    col: 12
    width: 12
    height: 7
  - title: Active Campaigns - Performance
    name: Active Campaigns - Performance2
    model: thelook_adwords
    explore: events
    type: looker_scatter
    fields:
    - campaigns.campaign_id
    - session_purchase_facts.total_attribution
    - adevents.total_cost
    filters:
      campaigns.campaign_id: NOT NULL
      campaigns.is_active_now: 'Yes'
      campaigns.created_year: 365 days
    sorts:
    - session_purchase_facts.total_attribution desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: profit_per_dollar
      label: Profit Per Dollar
      expression: "(${session_purchase_facts.total_attribution}- ${adevents.total_cost})\
        \ /${adevents.total_cost}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    - table_calculation: profit
      label: Profit
      expression: "(${session_purchase_facts.total_attribution}- ${adevents.total_cost})"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
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
    show_null_points: true
    point_style: circle
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
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
    hidden_fields:
    - campaigns.campaign_id
    - profit_per_dollar
    y_axes:
    - label: Attribution (USD)
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: custom
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: session_purchase_facts.total_attribution
        name: Sessions Total Attribution
        axisId: session_purchase_facts.total_attribution
    x_axis_label: Campaign Spend
    swap_axes: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    colors:
    - "#673AB7"
    - "#3F51B5"
    - "#2196F3"
    - "#03A9F4"
    - "#00BCD4"
    - "#009688"
    - "#4CAF50"
    - "#8BC34A"
    - "#d1e03a"
    - "#FFEB3B"
    - "#9E9E9E"
    - "#607D8B"
    series_colors: {}
    reference_lines: []
    trend_lines: []
    row: 23
    col: 0
    width: 12
    height: 9
  - title: Attribution (By Source)
    name: Attribution (By Source)
    model: thelook_adwords
    explore: events
    type: looker_bar
    fields:
    - session_purchase_facts.total_attribution
    - sessions.traffic_source
    - events.event_year
    pivots:
    - sessions.traffic_source
    fill_fields:
    - events.event_year
    sorts:
    - session_purchase_facts.total_attribution desc 0
    - sessions.traffic_source
    limit: 500
    column_limit: 50
    stacking: normal
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
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
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
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    series_labels:
      session_purchase_facts.total_attribution: Attribution
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    column_spacing_ratio:
    y_axes:
    - label: Attribution ($)
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: Display
        name: Display
        axisId: session_purchase_facts.total_attribution
      - id: Email
        name: Email
        axisId: session_purchase_facts.total_attribution
      - id: Facebook
        name: Facebook
        axisId: session_purchase_facts.total_attribution
      - id: Organic
        name: Organic
        axisId: session_purchase_facts.total_attribution
      - id: Search
        name: Search
        axisId: session_purchase_facts.total_attribution
    listen:
      Date: events.event_date
    row: 11
    col: 0
    width: 18
    height: 5
  - title: Clicks Over Time
    name: Clicks Over Time
    model: thelook_adwords
    explore: events
    type: looker_column
    fields:
    - adevents.cost_per_click
    - adevents.total_clicks
    - adevents.created_date
    fill_fields:
    - adevents.created_date
    filters:
      adevents.created_week: 30 days ago for 30 days
    sorts:
    - adevents.created_date
    limit: 500
    column_limit: 50
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
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes:
    - label: CPC ($)
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: adevents.cost_per_click
        name: CPC ($)
        axisId: adevents.cost_per_click
    - label: Clicks
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: adevents.total_clicks
        name: Click
        axisId: adevents.total_clicks
    series_types:
      adevents.cost_per_click: line
    series_labels:
      adevents.cost_per_click: CPC ($)
      adevents.total_clicks: Click
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    row: 16
    col: 0
    width: 12
    height: 7
  - title: Display
    name: Display
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - adevents.total_clicks
    filters:
      campaigns.advertising_channel: "-Search"
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: type
      label: Type
      expression: '"Display"'
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: string
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    hidden_fields:
    - adevents.total_clicks
    row: 0
    col: 5
    width: 5
    height: 3
  - title: New Tile
    name: New Tile1
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - adevents.total_viewability
    - adevents.total_impressions
    - adevents.total_clicks
    - adevents.cost_per_impression
    - adevents.total_cost_impressions
    filters:
      campaigns.advertising_channel: "-Search"
    sorts:
    - adevents.total_clicks desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: type
      label: Type
      expression: '"Display"'
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: string
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    hidden_fields:
    - adevents.cost_per_impression
    - adevents.total_clicks
    - adevents.total_cost_impressions
    single_value_title: Active Views
    comparison_label: Impressions
    listen:
      Date: events.event_date
    row: 3
    col: 5
    width: 5
    height: 4
  - title: CPM
    name: CPM
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - adevents.total_viewability
    - adevents.total_impressions
    - adevents.total_clicks
    - adevents.cost_per_impression
    - adevents.total_cost_impressions
    filters:
      campaigns.advertising_channel: "-Search"
    sorts:
    - adevents.total_clicks desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: type
      label: Type
      expression: '"Display"'
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: string
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    hidden_fields:
    - adevents.total_clicks
    - adevents.total_cost_impressions
    - adevents.total_impressions
    - adevents.total_viewability
    single_value_title: Cost Per Thousand (CPM)
    comparison_label: Impressions
    listen:
      Date: events.event_date
    row: 7
    col: 5
    width: 5
    height: 4
  - title: Cost Per Click
    name: Cost Per Click
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - campaigns.advertising_channel
    - adevents.total_viewability
    - adevents.total_impressions
    - adevents.total_clicks
    - adevents.total_cost_impressions
    - adevents.cost_per_click
    filters:
      campaigns.advertising_channel: Search
    sorts:
    - adevents.total_clicks desc
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    hidden_fields:
    - adevents.total_clicks
    - adevents.total_cost_impressions
    - adevents.total_impressions
    - adevents.total_viewability
    single_value_title: Cost Per Click
    comparison_label: Impressions
    listen:
      Date: events.event_date
    row: 7
    col: 0
    width: 5
    height: 4
  - title: Search
    name: Search
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - campaigns.advertising_channel
    - adevents.total_viewability
    - adevents.total_impressions
    - adevents.total_clicks
    - adevents.total_cost_impressions
    - adevents.cost_per_click
    filters:
      campaigns.advertising_channel: Search
    sorts:
    - adevents.total_clicks desc
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    hidden_fields:
    - adevents.total_clicks
    - adevents.total_cost_impressions
    - adevents.total_impressions
    - adevents.total_viewability
    - adevents.cost_per_click
    single_value_title: Cost Per Click
    comparison_label: Impressions
    row: 0
    col: 0
    width: 5
    height: 3
  - title: New Tile
    name: New Tile2
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - campaigns.advertising_channel
    - adevents.total_viewability
    - adevents.total_clicks
    - adevents.total_impressions
    - adevents.total_cost_impressions
    - adevents.cost_per_click
    filters:
      campaigns.advertising_channel: Search
    sorts:
    - adevents.total_clicks desc
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    hidden_fields:
    - adevents.total_cost_impressions
    - adevents.total_viewability
    - adevents.cost_per_click
    single_value_title: Clicks
    comparison_label: Impressions
    listen:
      Date: events.event_date
    row: 3
    col: 0
    width: 5
    height: 4
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<b><a href=\"https://saleseng.dev.looker.com/dashboards/246\"> \n\
      User Acquisition Analysis\n</a> </b>"
    row: 11
    col: 18
    width: 6
    height: 5
  - title: Conversions
    name: Conversions
    model: thelook_adwords
    explore: events
    type: looker_column
    fields:
    - adevents.total_impressions
    - adevents.total_clicks
    - session_purchase_facts.conversions_from_search
    filters:
      events.traffic_source: Adwords
    sorts:
    - adevents.total_impressions desc
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
    show_null_points: true
    point_style: circle
    interpolation: linear
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors:
    - 'palette: Looker Classic'
    smoothedBars: true
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    show_dropoff: true
    series_labels:
      sessions.count_purchase: Conversions (Purchases)
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: adevents.total_impressions
        name: Total Impressions
        axisId: adevents.total_impressions
      - id: adevents.total_clicks
        name: Total Clicks
        axisId: adevents.total_clicks
      - id: session_purchase_facts.conversions_from_search
        name: Conversions From Search
        axisId: session_purchase_facts.conversions_from_search
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: log
    listen:
      Date: events.event_date
    row: 5
    col: 10
    width: 14
    height: 6
  - title: Active Campaigns - Performance
    name: Active Campaigns - Performance
    model: thelook_adwords
    explore: events
    type: looker_column
    fields:
    - adevents.total_cost
    - session_purchase_facts.total_attribution
    - campaigns.campaign_name
    filters:
      campaigns.campaign_id: NOT NULL
      campaigns.is_active_now: 'Yes'
    sorts:
    - profit
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: profit_per_dollar
      label: Profit Per Dollar
      expression: "(${session_purchase_facts.total_attribution}- ${adevents.total_cost})\
        \ /${adevents.total_cost}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    - table_calculation: profit
      label: Profit
      expression: "(${session_purchase_facts.total_attribution}- ${adevents.total_cost})"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
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
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types:
      adevents.total_cost: line
    hidden_fields:
    - profit_per_dollar
    - profit
    y_axes:
    - label: Attribution (USD)
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: custom
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: session_purchase_facts.total_attribution
        name: Sessions Total Attribution
        axisId: session_purchase_facts.total_attribution
    x_axis_label: Campaign Spend
    swap_axes: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    reference_lines: []
    trend_lines: []
    row: 23
    col: 12
    width: 12
    height: 9
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 2 months ago for 2 months
    allow_multiple_values: true
    required: false
    model: thelook_adwords
    explore: events
    listens_to_filters: []
    field: adevents.created_date
