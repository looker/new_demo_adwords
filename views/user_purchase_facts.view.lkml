view: user_purchase_facts {
  derived_table: {
    datagroup_trigger: ecommerce_etl
    sql:
      select user_id, product_category as preferred_category
      from ${user_product_sales.SQL_TABLE_NAME}
      where category_rank = 1
       ;;
  }


  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: preferred_category {
    view_label: "Users"
    type: string
    sql: ${TABLE}.preferred_category ;;
  }

}
