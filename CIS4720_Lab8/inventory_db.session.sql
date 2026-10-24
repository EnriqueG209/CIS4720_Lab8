
-- STEP 6: CREATE INVENTORY TABLE
-- Select the inventory database so the table is created in the right place.
USE inventory_db;

-- Create a table to store information about inventory items.
CREATE TABLE INVENTORY (
    item_id INT NOT NULL,
    item_name VARCHAR(40) NOT NULL,
    category VARCHAR(30),
    quantity INT,
    unit_cost DECIMAL(7,2),
    received_on DATE,
    PRIMARY KEY (item_id)
);

-- Check that all six columns and the primary key were created.
DESCRIBE INVENTORY;


-- STEP 7: INSERT THREE RECORDS
-- Add the three inventory items provided in the assignment.
INSERT INTO INVENTORY
(item_id, item_name, category, quantity, unit_cost, received_on)
VALUES
(1, 'Laser Mouse', 'Peripherals', 25, 18.50, '2026-02-10'),
(2, 'Mechanical Keyboard', 'Peripherals', 12, 64.00, '2026-03-05'),
(3, 'USB Hub', 'Accessories', 40, 22.75, '2026-04-18');

-- Display all inventory records to confirm they were inserted.
SELECT * FROM INVENTORY;


-- STEP 8: SELECT, UPDATE, SELECT
-- Show item IDs, names, and prices before changing anything.
SELECT item_id, item_name, unit_cost
FROM INVENTORY;

-- Change only the keyboard's price to 59.99.
UPDATE INVENTORY
SET unit_cost = 59.99
WHERE item_id = 2;

-- Check the prices again to confirm the keyboard changed.
SELECT item_id, item_name, unit_cost
FROM INVENTORY;


-- STEP 9: CREATE INVENTORY VALUE VIEW
-- Makes a view to show how much each item is worth.
CREATE VIEW INVENTORY_VALUE AS
SELECT
    item_name,
    quantity,
    unit_cost,
    quantity * unit_cost AS total_value
FROM INVENTORY;

-- Display the calculated values from highest to lowest.
SELECT *
FROM INVENTORY_VALUE
ORDER BY total_value DESC;


-- STEP 10: COPY TABLE AND ADD PRIMARY KEY
-- Copy all the original inventory records into another table.
CREATE TABLE INVENTORY_COPY AS
SELECT * FROM INVENTORY;

-- Examine the copied table's structure before adding a key.
SHOW CREATE TABLE INVENTORY_COPY;

-- Add a primary key because the copy did not inherit it.
ALTER TABLE INVENTORY_COPY
ADD PRIMARY KEY (item_id);

-- Checks if the primary key was added.
DESCRIBE INVENTORY_COPY;


-- STEP 11: CREATE DATABASE USER
-- Create a local account for an inventory clerk.
CREATE USER 'stockclerk'@'localhost' IDENTIFIED BY 'Stock#2026';

-- List the MySQL accounts to confirm the new account exists.
SELECT user, host
FROM mysql.user
ORDER BY user;
  