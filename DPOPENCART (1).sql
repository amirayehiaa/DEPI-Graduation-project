USE opencart;
-- 001 Verify user data is stored correctly
SELECT customer_id, firstname, lastname, email, status
FROM oc_customer
WHERE email = 'maryamalaa938@gmail.com';

-- 009 Verify a new entry is created in the cart table when a logged-in user adds a product to the cart.
SELECT customer_id, firstname, email
FROM oc_customer
WHERE email = 'maryamalaa938@gmail.com';

-- 011 Verify product quantity is updated correctly
SELECT customer_id, product_id, quantity, date_added
FROM oc_cart
WHERE customer_id = 1 AND product_id = 40;
 
 -- 012 Verify the cart entry is removed when a user clicks the 'Remove' button.
 SELECT COUNT(*)
FROM oc_cart
WHERE customer_id = 1 AND product_id = 40;

-- 002 Verify an address is linked to a new customer

SELECT customer_id, email
FROM oc_customer
WHERE email = 'newuser_test@gmail.com'; 
 
 -- 003 Verify login attempt is logged
SELECT email, ip, total, date_added
FROM oc_customer_login
WHERE email = 'maryamalaa938@gmail.com'
ORDER BY date_added DESC
LIMIT 1;

-- 004  Verify profile information is updated
SELECT firstname, email
FROM oc_customer
WHERE customer_id = 1; 

-- 005 Verify only active products are displayed
SELECT p.product_id, pd.name, p.status
FROM oc_product p
JOIN oc_product_description pd ON p.product_id = pd.product_id
WHERE p.status = 1 
LIMIT 15; 

-- 006 Verify products are sorted by price (High > Low)
SELECT p.product_id, pd.name, p.price
FROM oc_product p
JOIN oc_product_description pd ON p.product_id = pd.product_id
WHERE p.status = 1
ORDER BY p.price DESC; -- DESC 

-- 007 Verify product filtering works by category
SELECT p.product_id, pd.name
FROM oc_product p
JOIN oc_product_to_category p2c ON p.product_id = p2c.product_id
JOIN oc_product_description pd ON p.product_id = pd.product_id
WHERE p2c.category_id = 20 AND p.status = 1;

-- 008 Verify search function
SELECT pd.name
FROM oc_product_description pd
WHERE pd.name LIKE '%MacBook%';
 
 -- 010: Add to Cart for Guest User
SELECT session_id, product_id, quantity, date_added
FROM oc_cart
WHERE customer_id = 0
ORDER BY date_added DESC;

-- 013: Verify total price is recalculated (GUEST)
SELECT SUM(p.price * c.quantity) AS calculated_total
FROM oc_cart c
JOIN oc_product p ON c.product_id = p.product_id
WHERE c.customer_id = 0;

-- 015: Verify stock is not decremented for out-of-stock attempt
SELECT quantity
FROM oc_product
WHERE product_id = 40;

-- 016: Verify a new order is created
SELECT order_id, customer_id, total, order_status_id, date_added
FROM oc_order
WHERE customer_id = 1
ORDER BY order_id DESC
LIMIT 1;

-- 017: Verify ordered products are stored
SELECT product_id, name, quantity, price
FROM oc_order_product
WHERE order_id = 1; 

-- 018: Verify product stock is decremented
SELECT quantity FROM oc_product WHERE product_id = 40;

-- 019: Verify customer addresses are saved with the order
SELECT payment_firstname, payment_lastname, payment_address_1, shipping_firstname, shipping_lastname, shipping_address_1

-- 020: Verify order history is logged


-- 021: Add to Wishlist
SELECT customer_id, product_id, date_added
FROM oc_customer_wishlist
WHERE customer_id = 1 AND product_id = 40;

-- 022: Remove from Wishlist
SELECT COUNT(*)
FROM oc_customer_wishlist
WHERE customer_id = 1 AND product_id = 40;

-- 023: Order History
SELECT order_id, total, date_added, order_status_id
FROM oc_order
WHERE customer_id = 1
ORDER BY date_added DESC;

-- 028: Contact Us form
SELECT customer_id, date_added FROM oc_customer ORDER BY customer_id DESC LIMIT 1;
SELECT order_id, date_added FROM oc_order ORDER BY order_id DESC LIMIT 1;

-- 029: Guest Checkout
SELECT COUNT(*) FROM oc_customer WHERE email = 'newuser_test@gmail.com'; 
SELECT order_id, customer_id, total FROM oc_order ORDER BY order_id DESC LIMIT 1;

-- 30 Cart Merge (Guest logs in)
SELECT product_id, quantity FROM oc_cart WHERE customer_id = 1 AND product_id = 40;
SELECT COUNT(*) FROM oc_cart WHERE customer_id = 0 AND product_id = 40; -- guest cart in empty 

-- 037: Verify a product review is stored
SELECT product_id, customer_id, author, rating, status
FROM oc_review
WHERE product_id = 40 AND customer_id = 1
ORDER BY date_added DESC
LIMIT 1;

-- 038: Verify no orphaned records in order_product
SELECT op.order_id
FROM oc_order_product op
LEFT JOIN oc_order o ON op.order_id = o.order_id
WHERE o.order_id IS NULL; 

-- 039: Verify no cart entries for non-existent customers
SELECT c.cart_id, c.customer_id
FROM oc_cart c
LEFT JOIN oc_customer cust ON c.customer_id = cust.customer_id
WHERE c.customer_id != 0 AND cust.customer_id IS NULL;

-- 040: Verify a customer cannot have two default addresses
SELECT customer_id
FROM oc_address
WHERE `default` = 1
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 042: Performance (Top 5 sold products)
SELECT op.product_id, pd.name, SUM(op.quantity) AS total_sold
FROM oc_order_product op
JOIN oc_product_description pd ON op.product_id = pd.product_id
GROUP BY op.product_id
ORDER BY total_sold DESC
LIMIT 5; 

-- 044: Verify password reset token is stored
SELECT email, token, ip, date_added
FROM oc_customer
WHERE email = 'maryamalaa938@gmail.com'
ORDER BY date_added DESC
LIMIT 1;

DESCRIBE oc_customer;

-- 045: Verify newsletter subscription status
SELECT newsletter
FROM oc_customer
WHERE customer_id = 1;

-- ADMIN 
-- 014: Verify coupon discount is applied
SELECT order_id FROM oc_order WHERE customer_id = 1 ORDER BY order_id DESC LIMIT 1;

SELECT coupon_id, amount, date_added FROM oc_coupon_history WHERE order_id = 1;

-- 020: Verify order history is logged
SELECT order_status_id, notify, date_added FROM oc_order_history WHERE order_id = 1 ORDER BY date_added DESC LIMIT 1;

-- 024: Admin adds a new product
SELECT product_id FROM oc_product ORDER BY product_id DESC LIMIT 1; 

SELECT model, price, status FROM oc_product WHERE product_id = 50;
SELECT name FROM oc_product_description WHERE product_id = 50; 

-- 025: Admin deletes a product
SELECT status FROM oc_product WHERE product_id = 45; -- status must=0 after deleting

-- 026: Admin edits product quantity to 999
SELECT quantity FROM oc_product WHERE product_id = 45;

-- 027: Admin links product to a category
SELECT * FROM oc_product_to_category WHERE product_id = 40 AND category_id = 20;

-- 031: Verify special offer price is used
SELECT * FROM oc_product_discount WHERE product_id = 40;

-- 032: Verify product option price is added
SELECT product_id, name, price FROM oc_order_product WHERE order_id = 40;

-- 033: Verify correct pricing for a customer group
SELECT price FROM oc_product_discount WHERE customer_group_id = (SELECT customer_group_id FROM oc_customer WHERE customer_id = 1) AND product_id = 40;

-- 034: Verify the default order status is set
SELECT order_id, order_status_id, date_added FROM oc_order WHERE customer_id = 1 ORDER BY order_id DESC LIMIT 1;

-- 035: Verify tax calculation
SELECT title, value, sort_order
FROM oc_order_total
WHERE order_id = 40 AND code = 'tax';

-- 036: Verify a product review is stored
SELECT product_id, customer_id, author, rating, text, status
FROM oc_review
WHERE product_id = 40 AND customer_id = 1
ORDER BY date_added DESC
LIMIT 1;

-- 043: Verify product stock is restored when an order is canceled
SELECT quantity FROM oc_product WHERE product_id = 40; -- before cancel order(968)
SELECT quantity FROM oc_product WHERE product_id = 40; -- after cancel order

-- 046: Verify a product is only visible on a specific store
SELECT store_id FROM oc_product_to_store WHERE product_id = 45;

-- 047: Verify coupon usage limit is enforced
SELECT COUNT(*) FROM oc_coupon_history WHERE customer_id = 40 AND coupon_id = 4;

-- 048: Verify product attributes are saved correctly when an admin adds them
SELECT product_id, attribute_id, text
FROM oc_product_attribute
WHERE product_id = 40 AND attribute_id = 12;

-- 050:  Verify order total components are stored correctly
SELECT order_id, total FROM oc_order WHERE customer_id = 1 ORDER BY order_id DESC LIMIT 1;
SELECT title, `value`, `code`, sort_order
FROM oc_order_total
WHERE order_id = 6
ORDER BY sort_order;

