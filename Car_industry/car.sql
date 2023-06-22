select firstName,lastName,mobilephone,new_field
from
(
	select *
	from 
	(
		SELECT 	Customers.customerID as cus_id, 
				Customers.firstName, 
				Customers.lastName, 
				Customers.registeredDate,
				Customers.consent,
				ownership.customerID as owner_cus_id, 
				ownership.VIN, 
				ownership.dealerID, 
				ownership.ModelName, 
				ownership.ownershipStartDate,
				complainmobile.*,
				case 
					when complainmobile.mobilephone is null then true
					else false
				end new_field,
				row_number()over(partition by Customers.customerID)::int as dup
		FROM (
		  VALUES
		    ('1', 'John', 'Doe', '2022-04-15', '3'),
		    ('2', 'Jane', 'Smith', '2021-07-23', '0'),
		    ('2', 'Jane', 'Smith', '2021-07-23', '0'),
		    ('2', 'Jane', 'Smith', '2021-07-23', '1'),
		    ('2', 'Jane', 'Smith', '2021-07-23', '0'),
		    ('2', 'Jane', 'Smith', '2021-07-23', '0'),
		    ('2', 'Jane', 'Smith', '2021-07-23', '0'),
		    ('2', 'Jane', 'Smith', '2021-07-23', '0'),
		    ('3', 'Michael', 'Johnson', '2023-01-10', '0'),
		    ('4', 'Emily', 'Williams', '2020-09-05', '1'),
		    ('5', 'Daniel', 'Brown', '2022-11-18', '0'),
		    ('6', 'Olivia', 'Miller', '2021-03-27', '1'),
		    ('7', 'David', 'Davis', '2023-05-02', '0'),
		    ('8', 'Sophia', 'Anderson', '2020-12-08', '0'),
		    ('9', 'Matthew', 'Wilson', '2022-02-14', '1'),
		    ('10', 'Emma', 'Thomas', '2021-09-30', '1'),
		    ('11', 'William', 'Taylor', '2022-08-12', '1'),
		    ('12', 'Ava', 'White', '2023-04-07', '1'),
		    ('13', 'James', 'Jones', '2020-11-24', '0'),
		    ('14', 'Isabella', 'Martin', '2022-01-19', '0'),
		    ('15', 'Joseph', 'Thompson', '2021-06-03', '1'),
		    ('16', 'Mia', 'Clark', '2023-03-16', '0'),
		    ('17', 'Alexander', 'Lewis', '2020-08-01', '1'),
		    ('18', 'Oliver', 'Lee', '2022-10-27', '1'),
		    ('19', 'Sophia', 'Harris', '2021-02-09', '1'),
		    ('20', 'Abigail', 'Walker', '2023-07-14', '1'),
		    ('21', 'Benjamin', 'Hall', '2020-12-31', '1'),
		    ('22', 'Chloe', 'Green', '2022-06-16', '1'),
		    ('23', 'Daniel', 'Baker', '2021-10-08', '1'),
		    ('24', 'Evelyn', 'Adams', '2023-02-22', '1'),
		    ('25', 'Jacob', 'Morris', '2020-05-10', '1'),
		    ('26', 'Grace', 'Nelson', '2022-09-03', '2'),
		    ('27', 'Liam', 'Ward', '2021-01-26', '3'),
		    ('28', 'Emily', 'Turner', '2023-06-09', '1'),
		    ('29', 'Michael', 'Cole', '2020-10-19', '2'),
		    ('30', 'Sofia', 'Morgan', '2022-03-05', '4'),
		    ('31', 'Mason', 'Cooper', '2021-07-18', '5'),
		    ('32', 'Scarlett', 'Richardson', '2023-01-01', '2'),
		    ('33', 'Ethan', 'Murphy', '2020-04-16', '1'),
		    ('34', 'Avery', 'Peterson', '2022-08-29', '0'),
		    ('35', 'Alexander', 'Reed', '2021-12-13', '1'),
		    ('36', 'Amelia', 'Stewart', '2023-05-28', '0'),
		    ('37', 'Henry', 'Cook', '2020-11-04', '2'),
		    ('38', 'Elizabeth', 'Bell', '2022-01-28', '1'),
		    ('39', 'Logan', 'Bailey', '2021-06-12', '5'),
		    ('40', 'Ella', 'Phillips', '2023-02-25', '1'),
		    ('41', 'Sebastian', 'Perry', '2020-05-14', '2'),
		    ('42', 'Lily', 'Bennett', '2022-09-27', '3'),
		    ('43', 'Jackson', 'Griffin', '2021-02-10', '4'),
		    ('44', 'Aria', 'Russell', '2023-07-26', '5'),
		    ('45', 'Jacob', 'Watson', '2020-12-24', '1'),
		    ('46', 'Layla', 'Sanders', '2022-06-09', '7'),
		    ('47', 'Carter', 'Price', '2021-10-01', '8'),
		    ('48', 'Grace', 'Simmons', '2023-02-14', '9'),
		    ('49', 'Owen', 'Foster', '2020-05-03', '0'),
		    ('50', 'Victoria', 'Henderson', '2022-09-17', '1')
		) AS Customers(customerID, firstName, lastName, registeredDate, consent)
		left join (
			SELECT customerID, VIN, dealerID, ModelName, ownershipStartDate
				FROM (
				  VALUES
				    ('1', 'ABC123', '1001', 'Model X', '2022-04-15'),
				    ('2', 'DEF456', '1002', 'Model S', '2021-07-23'),
				    ('3', 'GHI789', '1003', 'Model 3', '2023-01-10'),
				    ('4', 'JKL012', '1004', 'Model Y', '2020-09-05'),
				    ('5', 'MNO345', '1005', 'Model 3', '2022-11-18'),
				    ('6', 'PQR678', '1006', 'Model S', '2021-03-27'),
				    ('7', 'STU901', '1007', 'Model Y', '2023-05-02'),
				    ('8', 'VWX234', '1008', 'Model X', '2020-12-08'),
				    ('9', 'YZA567', '1009', 'Model Y', '2022-02-14'),
				    ('10', 'BCD890', '1010', 'Model 3', '2021-09-30'),
				    ('11', 'EFG123', '1011', 'Model S', '2022-08-12'),
				    ('12', 'HIJ456', '1012', 'Model X', '2023-04-07'),
				    ('13', 'KLM789', '1013', 'Model 3', '2020-11-24'),
				    ('14', 'NOP012', '1014', 'Model Y', '2022-01-19'),
				    ('15', 'QRS345', '1015', 'Model S', '2021-06-03'),
				    ('16', 'TUV678', '1016', 'Model X', '2023-03-16'),
				    ('17', 'WXY901', '1017', 'Model 3', '2020-08-01'),
				    ('18', 'ZAB234', '1018', 'Model Y', '2022-10-27'),
				    ('19', 'CDE567', '1019', 'Model S', '2021-02-09'),
				    ('20', 'FGH890', '1020', 'Model X', '2023-07-14')
				) AS Ownership(customerID, VIN, dealerID, ModelName, ownershipStartDate)
			) as ownership on Customers.customerID = ownership.customerID
		left join (
			SELECT *
				FROM (
				  VALUES 
				  ('1', '0123456789'),
				  ('2', '0123456789'),
				  ('3', '0123456789'),
				  ('4', '0123456789'),
				  ('5', '0123456789'),
				  ('6', '0123456789'),
				  ('7', '0123456789'),
				  ('8', '0123456789'),
				  ('9', '0123456789'),
				  ('10', '0123456789'),
				  ('11', '0123456789'),
				  ('12', '0123456789'),
				  ('13', '0123456789'),
				  ('14', '0123456789')
				) AS complainmobile(customerid, mobilephone)
			) as complainmobile on complainmobile.customerid = Customers.customerID
		WHERE ownershipStartDate::date BETWEEN '2021-01-01' AND '2023-01-01' 
		) as car_ind
	where dup = 1
	and owner_cus_id is not null
	) as a
where consent = '1' or consent = '0'
order by cus_id::int asc