-- first create DB => createdb makersbnb_test
-- then psql -h 127.0.0.1 makersbnb_test < spec/seeds_test.sql

TRUNCATE TABLE customers, owners, properties, bookings RESTART IDENTITY;

INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ('Customer 1', 'customer1@example.com', 'Styrofoam98');
INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ('Customer 2', 'customer2@example.com', 'Decapitate12');
INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ('Customer 3', 'customer3@example.com', 'Nonsense13');
INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ('Customer 4', 'customer4@example.com', 'Giggidy69');

INSERT INTO owners (owner_name, owner_email, owner_password)
VALUES ('Owner 1', 'owner1@example.com', 'Homunculus20');
INSERT INTO owners (owner_name, owner_email, owner_password)
VALUES ('Owner 2', 'owner2@example.com', 'Badgers00');
INSERT INTO owners (owner_name, owner_email, owner_password)
VALUES ('Owner 3', 'owner3@example.com', 'Mollycoddle83');

INSERT INTO properties (property_name, property_description, property_price, property_avail_date, property_status, owner_id)
VALUES ('Property 1', 'One bedroom flat', '50', '2023-04-01', 'available' ,1);
INSERT INTO properties (property_name, property_description, property_price, property_avail_date, property_status, owner_id)
VALUES ('Property 2', 'Two bedroom flat', '80', '2023-04-02', 'taken' ,1);
INSERT INTO properties (property_name, property_description, property_price, property_avail_date, property_status, owner_id)
VALUES ('Property 3', 'Three bedroom flat', '35', '2023-04-03', 'available' ,1);

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



