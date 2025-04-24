CREATE DATABASE e-commerce;
USE e-commerce;

CREATE TABLE product_Image (
    imageID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    productID INT NOT NULL,
    imageURL VARCHAR(255) NOT NULL,
    altText VARCHAR(255) NOT NULL,
    isPrimary BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (productID) REFERENCES product(productID)

);

CREATE TABLE color (
    colorID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
   colorName VARCHAR(50) NOT NULL,
    hexCode VARCHAR(7) NOT NULL
    
);

CREATE TABLE product_category (
    categoryID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    categoryName VARCHAR(100) NOT NULL,
    parentCategory INT,
    FOREIGN KEY (parentCategory) REFERENCES product_category(categoryID)
);

CREATE TABLE product (
    productID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(100) NOT NULL,
    brandID INT,
    categoryID INT NOT NULL,
    bestPrice DECIMAL(10, 2) NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (categoryID) REFERENCES product_category(categoryID),
    FOREIGN KEY (brandID) REFREENCES brand(brandID)


);

CREATE TABLE product_item (
    itemID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    productID INT  NOT NULL,
    colorID INT NOT NULL,
    sizeOptionID INT NOT NULL,
    stockKeepingUnit VARCHAR(100) NOT NULL,
    stockQuantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (productID) REFERENCES product(productID),
    FOREIGN KEY (colorID) REFERENCES color(colorID),
    FOREIGN KEY (sizeOptionID) REFERENCES size_option(sizeOptionID)
);

CREATE TABLE brand (
    brandID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    brandName VARCHAR(100) NOT NULL,
    brandLogo VARCHAR(255)


);


CREATE TABLE product_variation(
   variationID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
   productID INT NOT NULL,
   colorID INT,
   sizeCategoryID INT,
   FOREIGN KEY (productID) REFERENCES product(productID),
   FOREIGN KEY (colorID) REFERENCES color(colorID),
    FOREIGN KEY (sizeCategoryID) REFERENCES size_category(sizeCategoryID)
);

CREATE TABLE size_category (
    sizeCategoryID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    categoryName VARCHAR(100) NOT NULL

);

CREATE TABLE size_option (
    sizeOptionID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    sizeCategoryID INT NOT NULL,
    sizeLabel VARCHAR(50) NOT NULL,
    FOREIGN KEY (sizeCategoryID) REFERENCES size_category(sizeCategoryID)
);

CREATE TABLE product_attribute (
    attributeID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    productID INT NOT NULL,
   attributeTypeID INT NOT NULL,
   value TEXT NOT NULL,
    FOREIGN KEY (productID) REFERENCES product(productID),
    FOREIGN KEY (attributeTypeID) REFERENCES attribute_type(attributeTypeID)
);

CREATE TABLE attribute_category (
    attributeCategoryID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    categoryName VARCHAR(100) NOT NULL
);

CREATE TABLE attribute_type (
    attributeTypeID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    typeName VARCHAR(50),
    categoryID INT NOT NULL,
    FOREIGN KEY (categoryID) REFERENCES attribute_category(categoryID)
);


-- 1. Insert into brand
INSERT INTO brand (brandNAme, brandLogo)
VALUES 
('Nike', 'nike-logo.png'),
('Adidas', 'adidas-logo.png');

-- 2. Insert into product_category
INSERT INTO product_category (categoryName, parentCategory)
VALUES 
('Clothing', NULL),
('Shoes', NULL),
('T-Shirts', 1); -- T-Shirts under Clothing

-- 3. Insert into color
INSERT INTO color (colorName, hexCode)
VALUES 
('Black', '#000000'),
('White', '#FFFFFF'),
('Red', '#FF0000');

-- 4. Insert into size_category
INSERT INTO size_category (categoryName)
VALUES 
('Men Sizes'),
('Shoe Sizes');

-- 5. Insert into size_option
INSERT INTO size_option (sizeCategoryID, sizeLabel)
VALUES 
(1, 'S'),
(1, 'M'),
(2, '42'),
(2, '43');

-- 6. Insert into product
INSERT INTO product (name, brandID, categoryID, bestPrice, description)
VALUES 
('Nike Air Max', 1, 2, 250.00, 'Nike Air Max 2023 Sneakers'),
('Adidas Tee', 2, 3, 35.00, 'Comfort-fit T-Shirt for men');

-- 7. Insert into product_image
INSERT INTO product_image (productID, imageURL, altText, isPrimary)
VALUES 
(1, 'airmax.jpg', 'Nike Air Max Shoe', 1),
(2, 'tee.jpg', 'Adidas T-shirt', 1);

-- 8. Insert into product_item
INSERT INTO product_item (productID, colorID, sizeOptionID, stockKeepingUnit, stockQuantity, price)
VALUES 
(1, 1, 3, 'SKU123-AIRMAX-BLK-42', 10, 250.00),
(2, 2, 1, 'SKU124-TEE-WHT-S', 20, 35.00);

-- 9. Insert into product_variation
INSERT INTO product_variation (productID, colorID, sizeCategoryID)
VALUES 
(1, 1, 2),
(2, 2, 1);

-- 10. Insert into attribute_category
INSERT INTO attribute_category (categoryName)
VALUES 
('General Specs'),
('Material Info');

-- 11. Insert into attribute_type
INSERT INTO attribute_type (typeName, categoryID)
VALUES 
('Material', 2),
('Weight', 1);

-- 12. Insert into product_attribute
INSERT INTO product_attribute (productID, attributeTypeID, value)
VALUES 
(1, 1, 'Leather'),
(1, 2, '1.5kg'),
(2, 1, 'Cotton');
