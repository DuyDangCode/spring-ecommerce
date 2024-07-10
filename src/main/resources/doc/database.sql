CREATE DATABASE SpringEcommerce;
USE SpringEcommerce;

CREATE TABLE Roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  roleName VARCHAR(20) NOT NULL
);

CREATE TABLE Users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  fullName VARCHAR(100) DEFAULT "",
  phoneNumber VARCHAR(10) NOT NULL,
  address VARCHAR(200) DEFAULT "",
  password VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  createAt TIMESTAMP,
  updateAt TIMESTAMP,
  isActive TINYINT(1) DEFAULT 0,
  isDelete TINYINT(1) DEFAULT 0,
  dateOfBirth DATE,
  facebookAccountId INT DEFAULT 0,
  googleAccountId INT DEFAULT 0,
  roleId INT,
  FOREIGN KEY (roleId) REFERENCES Roles(id)
);

CREATE TABLE Tokens (
  id INT PRIMARY KEY AUTO_INCREMENT,
  token VARCHAR(255) UNIQUE NOT NULL,
  tokenType VARCHAR(50) NOT NULL,  -- Corrected typo: 'tokeType' to 'tokenType'
  expirationDate TIMESTAMP,
  revoked TINYINT(1) NOT NULL,
  expired TINYINT(1) NOT NULL,
  userId INT,
  createAt TIMESTAMP,
  updateAt TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES Users(id)  -- Corrected 'userID' to 'userId'
);

CREATE TABLE SocialAccounts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  providerName VARCHAR(20) NOT NULL,
  providerId VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL,
  username VARCHAR(100) NOT NULL,
  createAt TIMESTAMP,
  updateAt TIMESTAMP,
  userId INT,
  FOREIGN KEY (userId) REFERENCES Users(id)  -- Corrected 'userID' to 'userId'
);

CREATE TABLE Categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  categoryName VARCHAR(100) NOT NULL,
  isDelete TINYINT(1) DEFAULT 0,
  createAt TIMESTAMP,
  updateAt TIMESTAMP
);

CREATE TABLE Products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  productName VARCHAR(100) NOT NULL,
  productPrice FLOAT NOT NULL CHECK(productPrice >= 0),  -- Corrected column name in CHECK constraint
  productThumb VARCHAR(300) DEFAULT "",
  description LONGTEXT DEFAULT "",
  createAt TIMESTAMP,
  updateAt TIMESTAMP,
  categoryId INT,
  isDelete TINYINT(1) DEFAULT 0,
  FOREIGN KEY (categoryId) REFERENCES Categories(id)
);

CREATE TABLE Vouchers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  voucherName VARCHAR(200) NOT NULL,
  voucherValue FLOAT NOT NULL,
  voucherType ENUM("fixed_amount", "percentage"),
  createAt TIMESTAMP,
  updateAt TIMESTAMP,
  isDelete TINYINT(1) DEFAULT 0
);

CREATE TABLE Inventories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  productId INT,
  FOREIGN KEY (productId) REFERENCES Products(id),
  productQuantity INT CHECK(productQuantity >= 0) DEFAULT 0,  -- Corrected column name 'productQuanlity' to 'productQuantity'
  location VARCHAR(200) DEFAULT "",
  createAt TIMESTAMP,
  updateAt TIMESTAMP,
  isDelete TINYINT(1) DEFAULT 0
);

CREATE TABLE Orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  userId INT,
  FOREIGN KEY (userId) REFERENCES Users(id),
  fullName VARCHAR(100) DEFAULT "",
  email VARCHAR(100) DEFAULT "",
  phoneNumber VARCHAR(20) NOT NULL,
  address VARCHAR(200) DEFAULT "",
  shippingAddress VARCHAR(200) NOT NULL,
  shippingMethod VARCHAR(100) NOT NULL,
  paymentMethod VARCHAR(100) NOT NULL,
  trackingNumber VARCHAR(100) NOT NULL,
  shippingFee FLOAT CHECK(shippingFee >= 0),
  shippingDate DATE,
  note VARCHAR(100) DEFAULT "",
  orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
  createAt TIMESTAMP,
  updateAt TIMESTAMP,
  orderStatus ENUM("pending", "processing", "shipped", "delivered", "cancelled") DEFAULT "pending",
  totalMoney FLOAT CHECK(totalMoney >= 0),
  isDelete TINYINT(1) DEFAULT 0
);

CREATE TABLE OrderDetail (
  id INT PRIMARY KEY AUTO_INCREMENT,
  orderId INT,  -- Corrected column name 'oderId' to 'orderId'
  FOREIGN KEY (orderId) REFERENCES Orders(id),
  productId INT,
  FOREIGN KEY (productId) REFERENCES Products(id),
  orderDetailPrice FLOAT CHECK(orderDetailPrice >= 0),
  productQuantity INT CHECK(productQuantity > 0),  -- Corrected column name 'productQuanlity' to 'productQuantity'
  totalMoney FLOAT CHECK(totalMoney >= 0)
);

CREATE TABLE ApiKey (
  key VARCHAR(200) PRIMARY KEY,
  status TINYINT(1) DEFAULT 1,
  isDelete TINYINT(1) DEFAULT 1
);
