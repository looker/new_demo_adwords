view: user_product_sales {
  derived_table: {
    datagroup_trigger: ecommerce_etl
    sql:
    select user_id, product_category, sum(sale_price) as product_sales, row_number() over(PARTITION BY user_id order by sum(sale_price ) desc ) as category_rank
      from looker-private-demo.ecomm.order_items
      join looker-private-demo.ecomm.inventory_items
      on order_items.inventory_item_id = inventory_items.id
      join looker-private-demo.ecomm.products
      on inventory_items.product_id = products.id
      group by 1,2
       ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_sales {
    type: number
    sql: ${TABLE}.product_sales ;;
  }

  dimension: category_rank {
    type: number
    sql: ${TABLE}.category_rank ;;
  }
}
