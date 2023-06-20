CREATE TABLE customers (
  cus_id INT PRIMARY KEY,
  firstname text,
  lastname  text,
  email text,
  gender text,
  date_of_birth DATE,
  city text
);

INSERT INTO customers VALUES
  (1,'Dew','Kitti','Dew@gmail.com','m','2008-05-11','Thailand'),
  (2,'Dome','Nakarin','Dome@gmail.com','m','2000-12-10','Thailand'),
  (3,'Daike','Kato','Daike@gmail.com','m','2005-09-02','Japan'),
  (4,'Rose','Broken','Rose@gmail.com','f','2010-02-17','Thailand'),
  (5,'Bell','Greenhell','Bell@gmail.com','f','2015-06-24','Thailand');

CREATE TABLE companys (
  company_id INT PRIMARY KEY,
  company_name text,
  company_address text,
  company_email text,
  company_Tel decimal(10,0)
);

INSERT INTO companys VALUES
  (1,'Hatoru','Thailand','Hatoru@hotmail.com',0823456789),
  (2,'Yamoho','Japan','Yamoho@hotmail.com',0812345678);

CREATE TABLE packets (
  packet_id INT PRIMARY KEY,
  packet_name text
);

INSERT INTO packets VALUES
  (1,'small'),
  (2,'medium'),
  (3,'large');

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name text,
  price decimal,
  company_id INT,
  packet_id INT
);

INSERT INTO products VALUES
  (1,'fan',399,1,1),
  (2,'refrigerator',5190,2,2),
  (3,'air conditioner',8999,1,3);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  cus_id INT,
  product_id INT,
  order_date date
);

INSERT INTO orders VALUES
  (1,3,1,'15/12/2021'),
  (2,5,1,'14/12/2021'),
  (3,4,3,'13/12/2021'),
  (4,1,3,'02/12/2021'),
  (5,2,4,'01/12/2021');


/*JOIN Product*/
SELECT 
	product_id,
    product_name,
    price,
    companys.company_name,
    packets.packet_name
from products
JOIN companys ON companys.company_id = products.company_id
join packets ON packets.packet_id = products.packet_id;

/*JOIN cus and Product*/
SELECT 
	customers.firstname,
    customers.lastname,
    products.product_name,
    products.price,
    orders.order_date
    
from orders
JOIN customers ON customers.cus_id = orders.cus_id
JOIN products ON products.product_id = orders.product_id
where order_date between '01/12/2021' and '05/12/2021'
order by 5;