Two Tables Design Recipe Template

Copy this recipe template to design and create two related database tables from a specification.
1. Extract nouns from the user stories or specification

# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a space owner,
So I can post my new spaces,
I want to be able to list a new space.

As a space owner,
So I can post my new spaces,
I want to be able to list multiple spaces.

As a space owner,
So I can manage my spaces,
I want to be able to provide a short description of the space and the price per night.

As a space owner,
So I can manage my spaces,
I want to be able to offer a range of dates when the spaces are available.

As a space owner,
So I can hire a space for one night to a customer,
I want to be able to send the request and get it approved by the owner.

As a space owner,
So I can manage the availability dates,
I want to be able to check a date range if the dates overlap (for a specific space). 

As a space owner,
So I can avoid double-bookings,
I want to be able to mark a space as "booked" for a specific date and make the space unavailable for other customers.

Nouns:

owner, customer, property, description, price, avail_date, status (values: pending, approved, rejected)

2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.
TABLES      COLUMNS
properties 	property_name, property_description, property_price, property_avail_date, property_status, owner_id
customers 	customer_name, customer_email
owners      owner_name, owner_email
bookings    property_id, customer_id, booking_date, booking_status

3. Decide the column types.

# EXAMPLE:
# DATE format: 2023-03-11

# Database name: makersbnb_test

Table: properties
id: SERIAL PRIMARY KEY,
property_name: TEXT,
property_description: TEXT,
property_price: FLOAT,
property_avail_date: DATE,
property_status: TEXT,
owner_id: INT

Table: customers
id: SERIAL PRIMARY KEY,
customer_name: TEXT,
customer_email: TEXT

Table: owners
id: SERIAL PRIMARY KEY,
owner_name: TEXT,
owner_email: TEXT

Table: bookings
id: SERIAL PRIMARY KEY,
property_id: INT,
customer_id: INT,
booking_date: DATE,
booking_status: TEXT

4. Decide on The Tables Relationship

Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

    Can one PROPERTY have many OWNER/CUSTOMERS? (No)
    Can one OWNER have many PROPERTIES? (Yes)
    Can one CUSTOMER book many PROPERTIES? (No)

4. Write the SQL.

-- file: seeds_init.sql

CREATE TABLE customers (
    id: SERIAL PRIMARY KEY,
    customer_name: TEXT,
    customer_email: TEXT
);

CREATE TABLE owners (
    id: SERIAL PRIMARY KEY,
    owner_name: TEXT,
    owner_email: TEXT
);

CREATE TABLE bookings (
    id: SERIAL PRIMARY KEY,
    booking_date: DATE,
    booking_status: TEXT,
    property_id: INT,
    customer_id: INT,
    constraint fk_customer foreign key(customer_id) references customers(id) on delete cascade,
    constraint fk_property foreign key(property_id) references properties(id) on delete cascade
);

CREATE TABLE properties (
    id: SERIAL PRIMARY KEY,
    property_name: TEXT,
    property_description: TEXT,
    property_price: FLOAT,
    property_avail_date: DATE,
    property_status: TEXT,
    owner_id: INT,
    constraint fk_owner foreign key(owner_id) references owners(id) on delete cascade
);

5. Create the tables.

psql -h 127.0.0.1 makersbnb_test < spec/seeds_init.sql