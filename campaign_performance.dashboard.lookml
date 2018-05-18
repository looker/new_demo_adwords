- dashboard: campaign_performance
  title: Campaign Performance
  layout: newspaper
  elements:
  - title: Total Clicks
    name: Total Clicks
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - adevents.total_clicks
    - adevents.click_rate
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
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
    single_value_title: Clicks
    comparison_label: Click Through Rate (CTR)
    listen:
      Campaign Name: campaigns.campaign_name
    row: 12
    col: 6
    width: 6
    height: 4
  - title: Total Impressions
    name: Total Impressions
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - adevents.total_impressions
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
    single_value_title: Impressions
    comparison_label: Weekly Change
    listen:
      Campaign Name: campaigns.campaign_name
    row: 12
    col: 0
    width: 6
    height: 4
  - title: Total Cost
    name: Total Cost
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - adevents.total_cost
    - session_purchase_facts.total_attribution
    limit: 500
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
    single_value_title: Total Cost
    comparison_label: Associated Revenue
    listen:
      Campaign Name: campaigns.campaign_name
    row: 12
    col: 12
    width: 6
    height: 4
  - title: Associated Revenue
    name: Associated Revenue
    model: thelook_adwords
    explore: events
    type: single_value
    fields:
    - session_purchase_facts.total_attribution
    - campaigns.end_date
    fill_fields:
    - campaigns.end_date
    sorts:
    - campaigns.end_date desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
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
    single_value_title: Associated Revenue
    comparison_label: Campaign End Date
    listen:
      Campaign Name: campaigns.campaign_name
    row: 12
    col: 18
    width: 6
    height: 4
  - title: Clicks by Date
    name: Clicks by Date
    model: thelook_adwords
    explore: events
    type: looker_column
    fields:
    - adevents.created_date
    - adevents.total_clicks
    - adevents.click_rate
    fill_fields:
    - adevents.created_date
    filters:
      campaigns.advertising_channel: "-NULL"
    sorts:
    - adevents.created_date
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
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
    hidden_fields: []
    series_types:
      adevents.click_rate: line
      adevents.cost_per_click: line
    y_axes:
    - label: ''
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
      - id: adevents.total_clicks
        name: Total Clicks
        axisId: adevents.total_clicks
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: adevents.click_rate
        name: Click Through Rate (CTR)
        axisId: adevents.click_rate
    listen:
      Campaign Name: campaigns.campaign_name
    row: 16
    col: 12
    width: 12
    height: 7
  - title: Top Performing Keywords
    name: Top Performing Keywords
    model: thelook_adwords
    explore: events
    type: table
    fields:
    - keywords.criterion_name
    - adevents.total_clicks
    - adevents.total_impressions
    - adevents.click_rate
    - adevents.total_cost
    - session_purchase_facts.total_attribution
    filters:
      keywords.criterion_name: "-NULL"
    sorts:
    - session_purchase_facts.total_attribution desc
    limit: 100
    column_limit: 50
    dynamic_fields:
    - table_calculation: profit
      label: Profit
      expression: "${session_purchase_facts.total_attribution}-${adevents.total_cost}"
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: White to Green
        colors:
        - "#FFFFFF"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - adevents.total_cost
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: White to Green
        colors:
        - "#FFFFFF"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - session_purchase_facts.total_attribution
    listen:
      Campaign Name: campaigns.campaign_name
    row: 23
    col: 12
    width: 12
    height: 7
  - title: Keyword Spend vs Revenue
    name: Keyword Spend vs Revenue
    model: thelook_adwords
    explore: events
    type: looker_scatter
    fields:
    - session_purchase_facts.total_attribution
    - keywords.keyword_id
    - adevents.total_cost
    filters:
      campaigns.campaign_id: NOT NULL
      events.traffic_source: Adwords
    sorts:
    - session_purchase_facts.total_attribution desc
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
    - keywords.keyword_id
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
    x_axis_label: Keyword Spend ($)
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
    listen:
      Campaign Name: campaigns.campaign_name
    row: 30
    col: 0
    width: 12
    height: 11
  - title: Keyword Performance
    name: Keyword Performance
    model: thelook_adwords
    explore: events
    type: looker_column
    fields:
    - keywords.criterion_name
    - session_purchase_facts.total_attribution
    - adevents.total_cost
    filters:
      keywords.criterion_name: "-NULL"
    sorts:
    - session_purchase_facts.total_attribution desc
    limit: 50
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
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    x_axis_label: Keyword Name
    y_axes:
    - label: ''
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
      - id: adevents.total_cost_clicks
        name: Cost
        axisId: adevents.total_cost_clicks
      - id: session_purchase_facts.total_attribution
        name: Attribution
        axisId: session_purchase_facts.total_attribution
    series_types:
      adevents.total_cost_clicks: line
      session_purchase_facts.total_attribution: line
    series_labels:
      adevents.total_cost_clicks: Cost
      session_purchase_facts.total_attribution: Attribution
      adevents.total_cost: Total Spend
    hidden_series:
    - adevents.total_cost
    listen:
      Campaign Name: campaigns.campaign_name
    row: 23
    col: 0
    width: 12
    height: 7
  - title: CTR By Time of Day
    name: CTR By Time of Day
    model: thelook_adwords
    explore: events
    type: table
    fields:
    - adevents.click_rate
    - adevents.created_hour_of_day
    - adevents.created_day_of_week
    pivots:
    - adevents.created_day_of_week
    filters:
      adevents.created_day_of_week: ''
      adevents.created_hour_of_day: NOT NULL
    sorts:
    - adevents.created_day_of_week 0
    - adevents.created_hour_of_day
    limit: 500
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: White to Green
        colors:
        - "#FFFFFF"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - adevents.click_rate
    listen:
      Campaign Name: campaigns.campaign_name
    row: 30
    col: 12
    width: 12
    height: 11
  - title: Active Campaign Performance
    name: Active Campaign Performance
    model: thelook_adwords
    explore: events
    type: looker_timeline
    fields:
    - campaigns.campaign_name
    - campaigns.created_date
    - campaigns.end_date
    - session_purchase_facts.total_attribution
    filters:
      campaigns.is_active_now: 'Yes'
    sorts:
    - campaigns.created_date
    limit: 500
    query_timezone: America/Los_Angeles
    barColors:
    - "#1a3412"
    - "#d8ebb8"
    groupBars: true
    labelSize: 10pt
    showLegend: false
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    hidden_fields:
    valueFormat: ''
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    row: 0
    col: 0
    width: 11
    height: 9
  - title: Active Campaign Metrics
    name: Active Campaign Metrics
    model: thelook_adwords
    explore: events
    type: table
    fields:
    - campaigns.campaign_name
    - adevents.total_clicks
    - adevents.total_impressions
    - adevents.click_rate
    - adevents.total_cost
    - session_purchase_facts.total_attribution
    filters:
      campaigns.is_active_now: 'Yes'
    sorts:
    - adevents.total_cost desc
    limit: 50
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: White to Green
        colors:
        - "#FFFFFF"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - adevents.total_cost
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: White to Green
        colors:
        - "#FFFFFF"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - session_purchase_facts.total_attribution
    row: 0
    col: 11
    width: 13
    height: 9
  - title: Campaign Benchmark
    name: Campaign Benchmark
    model: thelook_adwords
    explore: events
    type: looker_line
    fields:
    - campaigns.campaign_benchmark
    - session_purchase_facts.return_on_investment
    - sessions.weeks_since_campaing_start
    pivots:
    - campaigns.campaign_benchmark
    filters:
      sessions.weeks_since_campaing_start: ">0"
    sorts:
    - campaigns.campaign_benchmark 0
    - sessions.weeks_since_campaing_start
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
    x_axis_scale: linear
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    show_null_points: false
    point_style: circle
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: 681 - NA - Search - Competition
        name: 681 - NA - Search - Competition
        axisId: session_purchase_facts.return_on_investment
      - id: Benchmark
        name: Benchmark
        axisId: session_purchase_facts.return_on_investment
      showLabels: true
      showValues: true
      unpinAxis: true
      tickDensity: default
      type: linear
    listen:
      Campaign Name: campaigns.campaign_selector
    row: 16
    col: 0
    width: 12
    height: 7
  - name: Campaign Performance
    type: text
    title_text: Campaign Performance
    row: 9
    col: 0
    width: 24
    height: 3
  filters:
  - name: Campaign Name
    title: Campaign Name
    type: field_filter
    default_value: 671 - NA - Search - Competition
    allow_multiple_values: true
    required: false
    model: thelook_adwords
    explore: events
    listens_to_filters: []
    field: campaigns.campaign_name
