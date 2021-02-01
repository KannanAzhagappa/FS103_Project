/* Create a Customer Table */

CREATE TABLE customer (
customer_id		INT				NOT NULL,
c_first_name	VARCHAR(20)     NOT NULL,
c_last_name		VARCHAR(20)     NOT NULL,
address			VARCHAR(40)     NOT NULL,
city			VARCHAR(40)     NOT NULL,
postal_code     VARCHAR(10)     NOT NULL,
PRIMARY KEY (customer_id)
);

ALTER Table customer
	ADD COLUMN contact_number VARCHAR(15) NOT NULL

`contact_number` varchar(15) not null,

/* Create Indexes for customer Table */

CREATE INDEX customer_c_name_idx ON customer(c_first_name,c_last_name);
CREATE INDEX customer_address_idx ON customer(address,city,postal_code );

/* Create a Sale Representative Table */

CREATE TABLE salesperson (
salesperson_id		INT				NOT NULL,
s_first_name		VARCHAR(20)     NOT NULL,
s_last_name			VARCHAR(20)     NOT NULL,
job_title			VARCHAR(40)     NOT NULL,
PRIMARY KEY (salesperson_id)
);

/* Create Indexes for Sale Representative Table */

CREATE INDEX salesperson_idx ON salesperson(s_first_name,s_last_name,job_title);


/* Create a Vehicles Table */

CREATE TABLE vehicle (
vehicle_id		INT				NOT NULL,
customer_id		INT,
serial_number	VARCHAR(20)     NOT NULL,
make			VARCHAR(20)     NOT NULL,
model			VARCHAR(40)     NOT NULL,
year			INT     		NOT NULL,
colour			VARCHAR(20),
price     		VARCHAR(40),
PRIMARY KEY (vehicle_id),
FOREIGN KEY (customer_id)  REFERENCES customer  (customer_id)  ON DELETE CASCADE
);

ALTER Table vehicle
	ADD COLUMN status VARCHAR(15) NOT NULL

/* Create Indexes for Vehicle Table */

CREATE INDEX vehicle_idx ON vehicle(customer_id,serial_number,make,model,year,colour,price);


/* Create a Sales Invoice Table */

CREATE TABLE salesinvoice (
salesinvoice_id		INT				NOT NULL,
customer_id			INT,
vehicle_id			INT,
salesperson_id		INT,
PRIMARY KEY (salesinvoice_id),
FOREIGN KEY (customer_id)      REFERENCES customer  	(customer_id)      ON DELETE CASCADE,
FOREIGN KEY (vehicle_id)   	   REFERENCES vehicle   	(vehicle_id)   	   ON DELETE CASCADE,
FOREIGN KEY (salesperson_id)   REFERENCES salesperson   (salesperson_id)   ON DELETE CASCADE
);

/* Create Indexes for Sales Invoice Table */

CREATE INDEX salesinvoice_idx ON salesinvoice(salesinvoice_id,customer_id,vehicle_id,salesperson_id);

/* Create a Mechanic Table */

CREATE TABLE mechanic (
mechanic_id			INT				NOT NULL,
m_first_name		VARCHAR(20)     NOT NULL,
m_last_name			VARCHAR(20)     NOT NULL,
job_title			VARCHAR(40)     NOT NULL,
PRIMARY KEY (mechanic_id)
);

/* Create Indexes for Mechanic Table */

CREATE INDEX mechanic_idx ON mechanic(m_first_name,m_last_name,job_title);

/* Create a Parts Table */

CREATE TABLE parts (
parts_id		INT				NOT NULL,
part_name		VARCHAR(20)     NOT NULL,
part_serial		VARCHAR(20)     NOT NULL,
part_type		VARCHAR(20),
part_quality	VARCHAR(20),
part_cost		VARCHAR(20),
PRIMARY KEY (parts_id)
);

/* Create Indexes for Parts Table */

CREATE INDEX parts_idx ON parts(part_name,part_serial,part_type,part_quality,part_cost);

/* Create a Service Type Table */

CREATE TABLE servicetype (
servicetype_id		INT				NOT NULL,
service_name		VARCHAR(20),
service_charge		VARCHAR(20),
PRIMARY KEY (servicetype_id)
);

/* Create Indexes for Service Type Table */

CREATE INDEX servicetype_idx ON servicetype(servicetype_id,service_name,service_charge);

/* Create a Parts Order Table */

CREATE TABLE partsorder (
partsorder_id		INT				NOT NULL,
parts_id			INT,
parts_invoice		VARCHAR(255),
PRIMARY KEY (partsorder_id),
FOREIGN KEY (parts_id)      REFERENCES parts  	(parts_id)   ON DELETE CASCADE
);

/* Create Indexes for Parts Order Table */

CREATE INDEX partsorder_idx ON partsorder(partsorder_id,parts_id,parts_invoice);


/* Create a Service Order Table */

CREATE TABLE serviceorder (
serviceorder_id		INT				NOT NULL,
servicetype_id		INT,
customer_id			INT,
vehicle_id			INT,
mechanic_id			INT,
partsorder_id		INT,
parts_id			INT,
date_of_service		date,
PRIMARY KEY (serviceorder_id),
FOREIGN KEY (servicetype_id)    REFERENCES servicetype  (servicetype_id)	ON DELETE CASCADE,
FOREIGN KEY (customer_id)   	REFERENCES customer   	(customer_id)   	ON DELETE CASCADE,
FOREIGN KEY (vehicle_id)   		REFERENCES vehicle   	(vehicle_id)   		ON DELETE CASCADE,
FOREIGN KEY (mechanic_id)   	REFERENCES mechanic   	(mechanic_id)   	ON DELETE CASCADE,
FOREIGN KEY (partsorder_id)   	REFERENCES partsorder   (partsorder_id)   	ON DELETE CASCADE,
FOREIGN KEY (parts_id)   		REFERENCES parts   		(parts_id)   		ON DELETE CASCADE
);

/* Create Indexes for Service Order Table */

CREATE INDEX serviceorder_idx ON serviceorder(serviceorder_id,servicetype_id,customer_id,vehicle_id,mechanic_id,partsorder_id,date_of_service);

/* Insert customer data */

INSERT INTO customer VALUES
(1001,'Georgi','Facello','Blk 608 SENJA ROAD SINGAPORE','Singapore','670608','+6591544890'),
(1002,'Bezalel','Simmel','Blk 609 SENJA ROAD SINGAPORE','Singapore','670609','+6591544891'),
(1003,'Parto','Bamford','Blk 610 SENJA ROAD SINGAPORE','Singapore','670610','+6591544892'),
(1004,'Chirstian','Koblick','Blk 611 SENJA ROAD SINGAPORE','Singapore','670611','+6591544893'),
(1005,'Kyoichi','Maliniak','Blk 612 SENJA ROAD SINGAPORE','Singapore','670612','+6591544894');

/* Insert Salesperson data */

INSERT INTO salesperson VALUES
(2001,'Saniya', 'Kalloufi', 'Sales Executive'),
(2002,'Sumant', 'Peac', 'Sales Executive'),
(2003,'Duangkaew', 'Piveteau', 'Sales Executive');

/* Insert Vehicle data */

INSERT INTO vehicle VALUES
(3001,1001, 'XD10284567275', 'BMW', '550I', 2020, 'Green', 'SGD $40,000', 'Used'),
(3002,null, 'VW10284567276', 'Volkswagen', 'Golf GTI 2.0L', 2020, 'Red', 'SGD $100,000', 'New'),
(3003,1003, 'VW10284567277', 'Volkswagen', 'Jettaa 1.4 tsi', 2021, 'Orange', 'SGD $140,000', 'New'),
(3004,null,'VW10284567278', 'Volkswagen', 'Jettaa 1.4 tsi', 2021, 'Blue', 'SGD $150,000', 'New'),
(3005,1002,'VW10284567279', 'Volkswagen', 'Polo 1.0 tsi dsg', 2019, 'Grey', 'SGD $100,000', 'Used'),
(3006,1005, 'AU10284567280', 'Audi', 'q2', 2008, 'Yellow', 'SGD $250,000', 'New'),
(3007,null,'AU10284567281', 'Audi', 'q2', 2021, 'Red', 'SGD $240,000', 'New'),
(3008,1004, 'OP10284567282', 'Opel', 'Crossland X', '2018', 'White', 'SGD $110,000', 'Used');

/* Insert Sales Invoice data */

INSERT INTO salesinvoice VALUES
(4001,1001, 3001, 2002),
(4002,1002, 3005, 2002),
(4003,1003, 3003, 2001),
(4004,1004, 3008, 2001),
(4005,1005, 3006, 2003);

/* Insert Mechanic data */

INSERT INTO mechanic VALUES
(5001,'Ramzi', 'Erde', 'Service Mechanic'),
(5002,'Shahaf', 'Famili', 'Service Mechanic'),
(5003,'Bojan', 'Montemayor', 'Service Mechanic');

/* Insert Parts data */

INSERT INTO parts VALUES
(6001,'No parts', 'nil', null, null, null),
(6002,'Battery Box', 'DD43284224', 'Electrical Supply', 'High-Grade', 'SGD $100'),
(6003,'Battery Cable', 'DC43284978', 'Electrical Supply', 'High-Grade', 'SGD $140'),
(6004,'Beam Axle', 'DAX5382653372', 'Suspension', 'High-Grade', 'SGD $390');

/* Insert servicetype data */

INSERT INTO servicetype VALUES
(7001,'Minor', 'SGD $50'),
(7002,'Major', 'SGD $200'),
(7003,'Moderate', 'SGD $110');

/* Insert partsorder data */

INSERT INTO partsorder VALUES
(8001,6002, 'Battery Box replacement'),
(8002,6004, 'Light Beam checks'),
(8003,6001, 'No parts required');

/* Insert serviceorder data */

INSERT INTO serviceorder VALUES
(9001,7001,1001,3001,5001,8003,6001,'2021-01-05'),
(9002,7003,1005,3006,5002,8001,6002,'2021-01-07'),
(9003,7002,1003,3003,5002,8002,6004,'2021-01-01');