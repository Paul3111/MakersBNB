-- this file will be loaded once
-- psql -h 127.0.0.1 makersbnb_test < spec/seeds_init.sql

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    customer_name TEXT,
    customer_email TEXT
);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    owner_name TEXT,
    owner_email TEXT
);

CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    property_name TEXT,
    property_description TEXT,
    property_price FLOAT,
    property_avail_date DATE,
    property_status TEXT,
    owner_id INT,
    constraint fk_owner foreign key(owner_id) references owners(id) on delete cascade
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    booking_date DATE,
    booking_status TEXT,
    property_id INT,
    customer_id INT,
    constraint fk_customer foreign key(customer_id) references customers(id) on delete cascade,
    constraint fk_property foreign key(property_id) references properties(id) on delete cascade
);
