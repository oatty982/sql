CREATE TABLE country (
  country_external_id INT PRIMARY KEY,
  country_name VARCHAR(255),
  country_en VARCHAR(255),
  is_active BOOLEAN
);

CREATE TABLE province (
  province_external_id INT PRIMARY KEY,
  province_name VARCHAR(255),
  province_en VARCHAR(255),
  is_active BOOLEAN,
  country_external_id INT,
  pre_province VARCHAR(255),
  pre_province_en VARCHAR(255),
  FOREIGN KEY (country_external_id) REFERENCES country(country_external_id)
);

CREATE TABLE district (
  district_external_id INT PRIMARY KEY,
  district_name VARCHAR(255),
  district_en VARCHAR(255),
  province_external_id INT,
  is_active BOOLEAN,
  pre_district VARCHAR(255),
  pre_district_en VARCHAR(255),
  FOREIGN KEY (province_external_id) REFERENCES province(province_external_id)
);

CREATE TABLE sub_district (
  sub_district_external_id INT PRIMARY KEY,
  sub_district_name VARCHAR(255),
  sub_district_en VARCHAR(255),
  is_active BOOLEAN,
  postal_code INT,
  province_external_id INT,
  district_external_id INT,
  pre_sub_district VARCHAR(255),
  pre_sub_district_en VARCHAR(255),
  FOREIGN KEY (province_external_id) REFERENCES province(province_external_id),
  FOREIGN KEY (district_external_id) REFERENCES district(district_external_id)
);

CREATE TABLE "user" (
  user_id INT PRIMARY KEY,
  firstname varchar,
  lastname varchar
);

CREATE TABLE customers (
  cus_id INT PRIMARY KEY,
  user_id INT,
  salutation VARCHAR(255),
  firstname VARCHAR(255),
  lastname VARCHAR(255),
  status VARCHAR(255),
  mobilephone VARCHAR(255),
  email VARCHAR(255),
  line VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES user (user_id);
);

CREATE TABLE companies (
  company_id INT PRIMARY KEY,
  company_name VARCHAR(255),
  created_date VARCHAR(255),
  company_email VARCHAR(255),
  company_tel VARCHAR(255)
);

CREATE TABLE packets (
  packet_id INT PRIMARY KEY,
  packet_name VARCHAR(255)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  packet_id INT,
  company_id INT,
  product_name VARCHAR(255),
  price DECIMAL,
  FOREIGN KEY (packet_id) REFERENCES packets(packet_id),
  FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

CREATE TABLE sales (
  sales_external_id INT PRIMARY KEY,
  cus_id INT,
  company_id INT,
  sales_address_text_c VARCHAR(255),
  sales_province_c INT,
  sales_district_c INT,
  sales_sub_district INT,
  company_address_text_c VARCHAR(255),
  company_province_c INT,
  company_district_c INT,
  company_sub_district INT,
  FOREIGN KEY (cus_id) REFERENCES customers(cus_id),
  FOREIGN KEY (company_id) REFERENCES companies(company_id),
  FOREIGN KEY (sales_province_c) REFERENCES province(province_external_id),
  FOREIGN KEY (sales_district_c) REFERENCES district(district_external_id),
  FOREIGN KEY (sales_sub_district) REFERENCES sub_district(sub_district_external_id),
  FOREIGN KEY (company_province_c) REFERENCES province(province_external_id),
  FOREIGN KEY (company_district_c) REFERENCES district(district_external_id),
  FOREIGN KEY (company_sub_district) REFERENCES sub_district(sub_district_external_id)
);

CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY,
  sales_external_id INT,
  product_id INT,
  value INT,
  FOREIGN KEY (sales_external_id) REFERENCES sales(sales_external_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
