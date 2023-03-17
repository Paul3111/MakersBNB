-- first create DB => createdb makersbnb_test
-- then psql -h 127.0.0.1 makersbnb_test < spec/seeds_test.sql

TRUNCATE TABLE customers, owners, properties, bookings RESTART IDENTITY;

INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ('Roger Parson', 'roger@parsontech.com', 'Styrofoam98');
INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ('Horace Umarell', 'hozza@bizzo.com', 'Decapitate12');
INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ('Dick McTracey', 'richo@traceytech.com', 'Nonsense13');
INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ('Bertha Orangedottir', 'berty@fruity.com', 'Giggidy69');

INSERT INTO owners (owner_name, owner_email, owner_password)
VALUES ('Magnus Raikonenn', 'magnus@magtech.com', 'Homunculus20');
INSERT INTO owners (owner_name, owner_email, owner_password)
VALUES ('Patrice Horrobin', 'patrice@propertymoguls.com', 'Badgers00');
INSERT INTO owners (owner_name, owner_email, owner_password)
VALUES ('Niamph Cohen', 'neve@magic.com', 'Mollycoddle83');

INSERT INTO properties (property_name, property_description, property_price, property_avail_date, property_status, owner_id)
VALUES ('The Old Loft', 'One bedroom flat', '50', '2023-04-01', 'available' ,1);
INSERT INTO properties (property_name, property_description, property_price, property_avail_date, property_status, owner_id)
VALUES ('Lake View', 'Two bedroom flat', '80', '2023-04-02', 'taken' ,1);
INSERT INTO properties (property_name, property_description, property_price, property_avail_date, property_status, owner_id)
VALUES ('Nelson Penthouse', 'Three bedroom flat', '35', '2023-04-03', 'available' ,1);

INSERT INTO bookings (booking_date, booking_status, property_id, customer_id)
VALUES ('2023-04-01','pending','1','1');
INSERT INTO bookings (booking_date, booking_status, property_id, customer_id)
VALUES ('2023-04-03','pending','1','2');
INSERT INTO bookings (booking_date, booking_status, property_id, customer_id)
VALUES ('2023-04-01','rejected','1','3');
INSERT INTO bookings (booking_date, booking_status, property_id, customer_id)
VALUES ('2023-04-01','pending','2','2');
INSERT INTO bookings (booking_date, booking_status, property_id, customer_id)
VALUES ('2023-04-05','pending','3','2');



