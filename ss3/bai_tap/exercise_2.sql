use ss2_sales_manager;
insert into customer(customer_name, customer_age) 
values 
  ('Minh Quan', 10), 
  ('Ngoc Oanh', 20), 
  ('Hong Ha', 50);
insert into `order`(
  customer_id, order_date, order_total_price
) 
values 
  (1, '2006-03-21', null), 
  (2, '2006-03-23', null), 
  (1, '2006-03-16', null);
  
insert into product(product_name, product_price) 
values 
  ('May Giat', 3), 
  ('Tu Lanh', 5), 
  ('Dieu Hoa', 7), 
  ('Quat', 1), 
  ('Bep Dien', 2);
  
insert into order_detail 
values 
  (1, 1, 3), 
  (1, 3, 7), 
  (1, 4, 2), 
  (2, 1, 1), 
  (3, 1, 8), 
  (2, 5, 4), 
  (2, 3, 3);
  -- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT 
    `order`.order_id,
    `order`.order_date,
    `order`.order_total_price
FROM
    `order`;
    -- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT 
    customer.customer_name, product.product_name
FROM
    order_detail
        INNER JOIN
    `order` ON `order`.order_id = order_detail.order_id
        INNER JOIN
    customer ON customer.customer_id = `order`.customer_id
        INNER JOIN
    product ON product.product_id = order_detail.product_id;
-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT 
    customer.customer_name
FROM
    customer
        LEFT JOIN
    `order` ON customer.customer_id = `order`.customer_id
WHERE
    `order`.order_id IS NULL;
-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. 
-- Giá bán của từng loại được tính = odQTY*pPrice)
SELECT 
    `order`.order_id,
    `order`.order_date,
    SUM(order_detail.order_qty * product.product_price) AS order_total_price
FROM
    order_detail
        INNER JOIN
    `order` ON `order`.order_id = order_detail.order_id
        INNER JOIN
    product ON product.product_id = order_detail.product_id
GROUP BY `order`.order_id
