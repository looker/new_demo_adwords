# Attribution

Check out this article for a great introduction to Attribution: https://segment.com/academy/collecting-data/an-introduction-to-multi-touch-attribution/

In this demo, we've specified three different types of attribution.

  1.  __First Touch Attribution__ - Depends entirely on how the user was first acquired. The channel that the user first came in through the site for the very first time gets full credit for all purchases made by the user.
  Implementation: User Acquisition Source exists as a dimension (site_acquisition_source) in the user_session_fact table. This table is rolled up to the user level.

  2.  __Last Touch Attribution__ - The session that the purchase was made in gets full credit for the purchase.
  Implementation: Session Purchase Source exists as a dimension (purchase_session_source) in the session_purchase_facts table. Details on how the session_purchase_facts table has been built is outlined below.

  3.  __Multi-Touch Linear Attribution__ - Every session leading up to a purchase gets equal weight for the purchase
  Implementation: Session Source exists as a dimension (traffic_source) in the sessions table.


Session Purchase Facts is a PDT that sessionizes the session table based on purchases. It contains dimensions such as sessions_till_purchase and sale_price to help identify how revenue should be distributed back across the table. It is joined back into the sessions table and revenue can be looked at at attributes of the session table, like session.traffice_source, purchase_session_source, etc...
