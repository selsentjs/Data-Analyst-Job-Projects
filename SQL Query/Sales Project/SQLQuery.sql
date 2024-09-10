

-- Table for owner
CREATE TABLE owner (
	owner_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	owner_name VARCHAR(100) NOT NULL,
    bloodGroup VARCHAR(10),
    age INT,
    designation VARCHAR(50),
    maintenance DECIMAL(10, 2),
    mobile VARCHAR(15),
    email VARCHAR(100),
    alternativeMobile VARCHAR(15),
    plotSize VARCHAR(50),
    floorNo INT,
    owner_block VARCHAR(50),
    Owner_Vehicle1 VARCHAR(50),
    Owner_Vehicle2 VARCHAR(50),
    Owner_CarModel VARCHAR(50),
    Owner_CarNo VARCHAR(20),
    Owner_BikeModel VARCHAR(50),
    Owner_BikeNo VARCHAR(20),
    Owner_totalVehicle INT,
    Owner_Address TEXT,
	owner_HouseNo int,
	Gender varchar(10),
	Purchased_Date DATE,
	is_owner_residing VARCHAR(3),
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE()
);


-- Table for Tenant

CREATE TABLE tenant (
	tenant_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	tenant_name VARCHAR(100) NOT NULL,
    tenant_designation VARCHAR(50),    
    mobile VARCHAR(15),
    email VARCHAR(100),
    alternativeMobile VARCHAR(15),
	AadharNo VARCHAR(20),
    floorNo INT,
	tenant_houseNo INT,
    tenant_block VARCHAR(50),
    tenant_Vehicle1 VARCHAR(50),
    tenant_Vehicle2 VARCHAR(50),
    tenant_CarModel VARCHAR(50),
    tenant_CarNo VARCHAR(20),
    tenant_BikeModel VARCHAR(50),
    tenant_BikeNo VARCHAR(20),
    tenant_totalVehicle INT,
    tenant_Address TEXT,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
	owner_id INT NOT NULL,  -- Foreign key column
    FOREIGN KEY (owner_id) REFERENCES owner(owner_id) ON DELETE CASCADE
);

-- Table for role
CREATE TABLE roles (
	role_id INT PRIMARY KEY IDENTITY(1,1),
	owner_role  VARCHAR(50) NOT NULL,
	Joining_Date DATE,
	Leaving_Date DATE,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
	owner_id INT NOT NULL,  -- Foreign key column
    FOREIGN KEY (owner_id) REFERENCES owner(owner_id) ON DELETE CASCADE
);

-- Table for payment_details
CREATE TABLE payment (
    payment_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),    
    payment_Date DATE,
	payment_status CHAR(3) CHECK (payment_status IN ('Yes', 'No')),
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    owner_id INT NULL,  -- Nullable, as the payment might be made by a tenant
    tenant_id INT NULL, -- Nullable, as the payment might be made by an owner
    FOREIGN KEY (owner_id) REFERENCES owner(owner_id), 
    FOREIGN KEY (tenant_id) REFERENCES tenant(tenant_id) 
);

SELECT * FROM payment;

UPDATE owner
SET is_owner_residing = 'Yes'
WHERE owner_id IN (1, 2, 4, 5, 6, 10, 11, 12, 13, 17, 20, 22, 23, 29, 31, 32, 35, 36, 37, 38, 40, 41);

UPDATE owner
SET is_owner_residing = 'No'
WHERE is_owner_residing IS NULL;

SELECT owner_id,floorNo,owner_HouseNo,is_owner_residing
FROM owner;


-- ----------------------------------------------------------------------------------------

-- INSERT owner's details

INSERT INTO owner(
    owner_name, bloodGroup, age, designation, maintenance, mobile, email, alternativeMobile, plotSize, floorNo, owner_block,
    Owner_Vehicle1, Owner_Vehicle2, Owner_CarModel, Owner_CarNo, Owner_BikeModel, Owner_BikeNo, Owner_totalVehicle, Owner_Address,
    owner_HouseNo, Gender, Purchased_Date
)
VALUES (
    'John doe', 'O+', 45, 'Engineer', 2500, '9876543210', 'john.doe@example.com', '9123456780', '1200 sq ft', 1, 'Block A',
    'Car', 'Bike', 'Honda City', 'KA 12 AB 1234', 'Royal Enfield', 'KA 12 XY 5678', 2, 'Bangalore',
    101, 'Male', '1990-04-20'
);

INSERT INTO owner (
    owner_name, bloodGroup, age, designation, maintenance, mobile, email, alternativeMobile, plotSize, floorNo, owner_block,
    Owner_Vehicle1, Owner_Vehicle2, Owner_CarModel, Owner_CarNo, Owner_BikeModel, Owner_BikeNo, Owner_totalVehicle, Owner_Address,
    owner_HouseNo, Gender, Purchased_Date
)
VALUES
    ('Jane Smith', 'A+', 38, 'Doctor', 3000, '9876543211', 'jane.smith@example.com', '9123456781', '1500 sq ft', 1, 'Block A',
    'Car', NULL, 'Maruti Swift', 'KA 12 CD 3456', NULL, NULL, 1, 'Bangalore', 102, 'Male', '1982-06-22'),

    ('Suresh', 'AB+', 33, 'Architect', 3500, '6589741235', 'Suresh@gmail.com', '9801234567', '2200 sq ft', 1, 'Block A',
    'Car', NULL, 'Toyota Camry', 'TN 16 NQ 5467', NULL, NULL, 1, 'Bangalore', 103, 'Male', '2003-09-06'),

    ('Prakash', 'O-', 48, 'Scientist', 2500, '7896245310', 'Prakash@gmail.com', '9776543210', '1200 sq ft', 1, 'Block A',
    'Car', 'Bike', 'Honda Accord', 'KL 03 LM 6754', 'Kawasaki Ninja ZX-10R', 'AP 15 PQ 6789', 2, 'Bangalore', 104, 'Male', '2001-07-14'),

    ('Avinash', 'B+', 54, 'Lawyer', 3200, '9835471026', 'Avinash@gmail.com', '9812345670', '1700 sq ft', 1, 'Block A',
    NULL, 'Bike', NULL, NULL, 'Ducati Panigale V4', 'MH 10 AB 2345', 1, 'Bangalore', 105, 'Male', '1985-01-15'),

    ('Arokyadash', 'B-', 36, 'Accountant', 3200, '8923541078', 'Arokyadash@gmail.com', '9798765432', '1700 sq ft', 1, 'Block A',
    'Car', 'Bike', 'Chevrolet Malibu', 'AP 67 MQ 0987', 'Honda CBR1000RR', 'DL 05 CD 8901', 2, 'Bangalore', 106, 'Male', '1992-03-28'),

    ('Arun kumar', 'AB-', 69, 'Pharmacist', 3500, '8852369741', 'Arunkumar@gmail.com', '9823456781', '2200 sq ft', 1, 'Block A',
    'Car', 'Bike', 'BMW 3 Series', 'MH 20 AB 1234', 'BMW S1000RR', 'KA 12 EF 3456', 2, 'Bangalore', 107, 'Male', '1978-11-04'),

    ('Ajay Mahadevan', 'A+', 78, 'Nurse', 2500, '9685231470', 'AjayMahadevan@gmail.com', '9765432109', '1200 sq ft', 1, 'Block A',
    'Car', NULL, 'Audi A4', 'DL 03 XY 5678', NULL, NULL, 1, 'Bangalore', 108, 'Male', '1999-07-19'),

    ('Prabhu Karthik', 'O+', 60, 'Technician', 3000, '9785214630', 'PrabhuKarthik@gmail.com', '9843210976', '1500 sq ft', 1, 'Block A',
    'Car', 'Bike', 'Mercedes-Benz C-Class', 'KA 05 CD 9876', 'Indian Chief Classic', 'KL 23 IJ 9012', 2, 'Bangalore', 109, 'Male', '1987-10-12'),

    ('Vellandurai', 'O-', 46, 'Professor', 3750, '9903215647', 'Vellandurai@gmail.com', '9734567890', '2400 sq ft', 1, 'Block A',
    'Car', 'Bike', 'Nissan Altima', 'TN 09 PQ 2345', 'KTM 1290 Super Duke R', 'HR 19 KL 3456', 2, 'Bangalore', 110, 'Male', '1995-02-23'),

    ('Ramesh Kannan', 'AB+', 36, 'Designer', 3500, '9802547896', 'RameshKannan@gmail.com', '9812765430', '2200 sq ft', 2, 'Block B',
    'Car', 'Bike', 'Hyundai Sonata', 'KL 07 RS 4567', 'Triumph Street Triple R', 'UP 04 MN 6789', 2, 'Bangalore', 201, 'Male', '2000-06-09'),

    ('Senthil kumar', 'O-', 25, 'Manager', 3750, '9739106666', 'Senthilkumar@gmail.com', '9798654321', '2400 sq ft', 2, 'Block B',
    'Car', 'Bike', 'Subaru Impreza', 'HR 26 ST 8901', 'Moto Guzzi California Touring 1400', 'RJ 11 OP 1234', 2, 'Bangalore', 202, 'Male', '1983-08-31'),

    ('Selva Ragavan', 'B+', 21, 'Analyst', 3200, '9785230145', 'SelvaRagavan@gmail.com', '9865432109', '1700 sq ft', 2, 'Block B',
    'Car', NULL, 'Volkswagen Passat', 'UP 14 UV 3456', 'Aprilia RSV4', 'MP 27 QR 4567', 1, 'Bangalore', 203, 'Male', '1989-12-17'),

    ('Sethu pillai', 'B-', 55, 'Consultant', 3500, '9886502147', 'Sethupillai@gmail.com', '9832109876', '2200 sq ft', 2, 'Block B',
    'Car', 'Bike', 'Lexus ES', 'RJ 17 WX 6789', 'MV Agusta F4', 'WB 35 ST 8901', 2, 'Bangalore', 204, 'Male', '2004-05-21'),

    ('Abirami', 'AB-', 52, 'Researcher', 3650, '9880478965', 'Abirami@gmail.com', '9754321098', '2350 sq ft', 2, 'Block B',
    NULL, 'Bike', NULL, NULL, 'Honda CB500F', 'PB 20 UV 2345', 1, 'Bangalore', 205, 'Female', '1996-09-02'),

    ('Selvakumari', 'A+', 41, 'Developer', 2500, '9823650147', 'Selvakumari@gmail.com', '9845671230', '1200 sq ft', 2, 'Block B',
    'Car', NULL, 'Kia Optima', 'WB 22 ZA 5678', NULL, NULL, 1, 'Bangalore', 206, 'Female', '1990-07-30'),

    ('Priyanka Devan', 'O+', 43, 'Surgeon', 3000, '9874563210', 'PriyankaDevan@gmail.com', '9821345679', '1500 sq ft', 2, 'Block B',
    'Car', 'Bike', 'Mazda6', 'PB 13 CD 6789', 'Yamaha MT-09', 'BR 32 YZ 1234', 2, 'Bangalore', 207, 'Male', '1988-11-10'),

    ('Sreyas', 'O-', 22, 'Therapist', 3500, '9988774452', 'Sreyas@gmail.com', '9712345678', '2200 sq ft', 2, 'Block B',
    'Car', 'Bike', 'Volvo S60', 'OR 15 EF 3456', 'Ducati Monster 1200', 'JH 21 ZA 4567', 2, 'Bangalore', 208, 'Male', '2002-04-25'),

    ('Pandiyan', 'AB+', 27, 'Specialist', 2500, '9658741230', 'Pandiyan@gmail.com', '9876501234', '1200 sq ft', 2, 'Block B',
    NULL, 'Bike', NULL, NULL, 'BMW R1250GS', 'AS 13 CD 8901', 1, 'Bangalore', 209, 'Male', '1991-08-13'),

    ('Prakash Kanth', 'O-', 23, 'Programmer', 3200, '9887021548', 'PrakashKanth@gmail.com', '9743210987', '1700 sq ft', 2, 'Block B',
    'Car', 'Bike', 'Infiniti Q50', 'JH 23 IJ 4567', 'Suzuki V-Strom 650', 'GA 09 EF 2345', 2, 'Bangalore', 210, 'Male', '1994-03-07'),

    ('Anupallavi', 'B+', 25, 'Educator', 3200, '9758463201', 'Anupallavi@gmail.com', '9834567890', '1700 sq ft', 3, 'Block C',
    'Car', 'Bike', 'Acura TLX', 'AS 24 KL 8901', 'KTM Adventure 390', 'CH 28 GH 6789', 2, 'Bangalore', 301, 'Female', '2022-09-18'),

    ('Poornima Raj', 'B-', 26, 'Pilot', 3500, '9857402314', 'PoornimaRaj@gmail.com', '9765412309', '2200 sq ft', 3, 'Block C',
    'Car', 'Bike', 'Genesis G70', 'GA 01 MN 2345', 'Royal Enfield Interceptor 650', 'SK 17 IJ 9012', 2, 'Bangalore', 302, 'Female', '1981-12-26'),

    ('Akash Velan', 'AB-', 28, 'Financial Advisor', 2500, '9876987021', 'AkashVelan@gmail.com', '9812340987', '1200 sq ft', 3, 'Block C',
    NULL, 'Bike', NULL, NULL, 'Indian Scout Sixty', 'TN 26 KL 3456', 1, 'Bangalore', 303, 'Male', '2005-06-14'),

    ('Ajay Kumar', 'A+', 29, 'Engineer', 3000, '9875214630', 'AjayKumar@gmail.com', '9798765431', '1500 sq ft', 3, 'Block C',
    'Car', 'Bike', 'Tesla Model 3', 'SK 34 QR 1234', 'Harley-Davidson Fat Bob', 'KL 06 MN 6789', 2, 'Bangalore', 304, 'Male', '1986-10-08'),

    ('Balamuralidaran', 'O+', 31, 'Operations Manager', 3750, '9876543210', 'Balamuralidaran@gmail.com', '9876123459', '2400 sq ft', 3, 'Block C',
    'Car', NULL, 'Buick Regal', 'TN 19 ST 5678', NULL, NULL, 1, 'Bangalore', 305, 'Male', '2003-04-03'),

    ('Chirtra Devi', 'O-', 34, 'Statistician', 3500, '9865432109', 'ChirtraDevi@gmail.com', '9812346507', '2200 sq ft', 3, 'Block C',
    'Car', 'Bike', 'Land Rover Discovery', 'KL 11 UV 3456', 'Honda CRF250L', 'DL 19 QR 4567', 2, 'Bangalore', 306, 'Female', '1998-02-20'),

    ('Dinesh', 'AB+', 33, 'Marketing Executive', 3750, '9843210987', 'Dinesh@gmail.com', '9723456789', '2400 sq ft', 3, 'Block C',
    'Car', NULL, 'Range Rover Velar', 'MH 15 WX 8901', NULL, NULL, 1, 'Bangalore', 307, 'Male', '1984-12-05'),

    ('Amar khan', 'O-', 32, 'Architect', 3200, '9876123450', 'Amarkhan@gmail.com', '9867123450', '1700 sq ft', 3, 'Block C',
    'Car', 'Bike', 'Ford Mustang', 'DL 21 YZ 2345', 'BMW G310R', 'HR 03 UV 2345', 2, 'Bangalore', 308, 'Male', '1991-07-22'),

    ('Devaraj', 'B+', 36, 'Project Manager', 3500, '9812345678', 'Devaraj@gmail.com', '9754321097', '2200 sq ft', 3, 'Block C',
    'Car', 'Bike', 'Jaguar XE', 'KA 06 ZA 6789', 'Ducati Scrambler Icon', 'UP 13 WX 6789', 2, 'Bangalore', 309, 'Male', '2000-11-11'),

    ('Deepika', 'B-', 39, 'Civil Engineer', 3650, '9798654321', 'Deepika@gmail.com', '9798612345', '2350 sq ft', 3, 'Block C',
    'Car', 'Bike', 'Cadillac ATS', 'HR 09 CD 1234', 'Husqvarna Svartpilen 701', 'RJ 25 YZ 9012', 2, 'Bangalore', 310, 'Female', '1997-03-16'),

    ('Deepa', 'AB-', 38, 'Data Scientist', 3500, '9823456789', 'Deepa@gmail.com', '9821476035', '2200 sq ft', 4, 'Block D',
    'Car', NULL, 'Porsche Panamera', 'UP 32 EF 5678', NULL, NULL, 1, 'Bangalore', 401, 'Female', '2003-08-29'),

    ('Madhavan', 'A+', 47, 'Legal Advisor', 2500, '9765432108', 'Madhavan@gmail.com', '9765432108', '1200 sq ft', 4, 'Block D',
    'Car', 'Bike', 'Chevrolet Malibu', 'RJ 13 GH 8901', 'Honda NC750X', 'WB 17 CD 6789', 2, 'Bangalore', 402, 'Male', '1989-05-04'),

    ('Prabhakaran', 'O+', 45, 'HR Manager', 3200, '9832165470', 'Prabhakaran@gmail.com', '9815678901', '1700 sq ft', 4, 'Block D',
    'Car', 'Bike', 'BMW 3 Series', 'MP 27 IJ 2345', 'Suzuki Boulevard M109R', 'PB 11 EF 8901', 2, 'Bangalore', 403, 'Male', '1990-12-19'),

    ('Devika Ranjan', 'O-', 41, 'Software Developer', 3750, '9873456781', 'DevikaRanjan@gmail.com', '9743125680', '2400 sq ft', 4, 'Block D',
    NULL, 'Bike', NULL, NULL, 'Moto Guzzi V7 III', 'OR 32 GH 1234', 1, 'Bangalore', 404, 'Female', '2001-06-27'),

    ('Abilash', 'AB+', 22, 'Sales Representative', 3000, '9817564320', 'Abilash@gmail.com', '9832109765', '1500 sq ft', 4, 'Block D',
    'Car', 'Bike', 'Mercedes-Benz C-Class', 'PB 14 MN 1234', 'Indian Chieftain Dark Horse', 'BR 09 IJ 4567', 2, 'Bangalore', 405, 'Male', '1982-09-01'),

    ('Xaviour', 'B+', 24, 'Biomedical Scientist', 3000, '9798123456', 'Xaviour@gmail.com', '9765432098', '1500 sq ft', 4, 'Block D',
    'Car', 'Bike', 'Nissan Altima', 'OR 18 OP 5678', 'Yamaha YZF-R3', 'JH 27 KL 8901', 2, 'Bangalore', 406, 'Male', '2023-07-15'),

    ('Zeebha kanam', 'B-', 29, 'Event Planner', 3200, '9867321098', 'Zeebhakanam@gmail.com', '9812765439', '1700 sq ft', 4, 'Block D',
    NULL, 'Bike', NULL, NULL, 'Kawasaki Z650', 'AS 14 MN 2345', 1, 'Bangalore', 407, 'Female', '2004-11-23'),

    ('Mushkan Bai', 'O-', 24, 'Supply Chain Manager', 3650, '9743125689', 'MushkanBai@gmail.com', '9798324561', '2350 sq ft', 4, 'Block D',
    'Car', 'Bike', 'Subaru Impreza', 'JH 25 ST 2345', 'Triumph Bonneville T120', 'GA 21 OP 6789', 2, 'Bangalore', 408, 'Female', '1988-04-09'),

    ('Aruna Balram', 'AB-', 36, 'Content Writer', 3200, '9821476503', 'ArunaBalram@gmail.com', '9843210986', '1700 sq ft', 4, 'Block D',
    'Car', NULL, 'Volkswagen Passat', 'AS 17 UV 6789', NULL, NULL, 1, 'Bangalore', 409, 'Female', '2003-01-30'),

    ('Dinesh kumar', 'AB+', 44, 'Quality Assurance Analyst', 3000, '9820314567', 'Dineshkumar@gmail.com', '9734567901', '1500 sq ft', 4, 'Block D',
    'Car', 'Bike', 'Lexus ES', 'GA 08 WX 1234', 'BMW R nineT', 'SK 25 ST 3456', 2, 'Bangalore', 410, 'Male', '1996-10-17');

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM owner;

SELECT owner_id,floorNo,owner_houseNo,owner_block,is_owner_residing
FROM owner
WHERE is_owner_residing = 'NO';

SELECT floorNo, tenant_houseNo,tenant_block,owner_id
FROM tenant;

-- --------------------------------------------------------------------------------------------------------
-- INSERT data to tenant table

INSERT into tenant(tenant_name,tenant_designation,mobile,email,alternativeMobile,AadharNo,floorNo,tenant_houseNo,tenant_block,
tenant_Vehicle1,tenant_Vehicle2,tenant_CarModel,tenant_CarNo,tenant_BikeModel,tenant_BikeNo,tenant_totalVehicle,tenant_Address,owner_id
)
VALUES(
'Arivalagan','Engineer','9798765432','Arivalagan@gmail.com','9785230145','1234 5678 9012',1,103,'Block A',
'Car','Bike','Chevrolet Malibu','AP 67 MQ 0987','Royal Enfield','AP 15 PQ 6789',2,'Andra Pradesh',3);

INSERT INTO tenant (tenant_name, tenant_designation, mobile, email, alternativeMobile, AadharNo, floorNo, tenant_houseNo, tenant_block,
tenant_Vehicle1, tenant_Vehicle2, tenant_CarModel, tenant_CarNo, tenant_BikeModel, tenant_BikeNo, tenant_totalVehicle, tenant_Address, owner_id)
VALUES

('Anitha', 'Doctor', '9823456781', 'Anitha@gmail.com', '9886502147', '9876 5432 1098',1, 107, 'Block A',
'Car', 'Bike', 'BMW 3 Series', 'MH 20 AB 1234', 'Honda CRF250L', 'MH 10 AB 2345', 2, 'Maharastra', 7),

('Jayalakshmi', 'Architect', '9765432109', 'Jayalakshmi@gmail.com', '9880478965', '4567 8901 2345', 1,108, 'Block A',
NULL, 'Bike', NULL, NULL, 'Harley-Davidson Fat Bob', 'DL 05 CD 8901', 1, 'Bangalore', 8),

('Parameshwaran', 'Scientist', '9843210976', 'Parameshwaran@gmail.com', '9823650147', '3210 9876 5432', 1, 109, 'Block B',
'Car', NULL, 'Mercedes-Benz C-Class', 'KA 05 CD 9876', NULL, NULL, 1, 'Bangalore', 9),

('Surikanth', 'Lawyer', '9734567890', 'Surikanth@gmail.com', '9874563210', '6543 2109 8765',2, 204, 'Block B',
'Car', NULL, 'Nissan Altima', 'TN 09 PQ 2345', NULL, NULL, 1, 'Bangalore', 14),

('Lavanya S', 'Accountant', '9812765430', 'LavanyaS@gmail.com', '9988774452', '7890 1234 5678',2, 205, 'Block B',
NULL, 'Bike', NULL, NULL, 'Honda CBR1000RR', 'KL 23 IJ 9012', 1, 'Kerala', 15),

('Prabhu', 'Pharmacist', '9798654321', 'Prabhu@gmail.com', '9658741230', '1357 2468 9135', 2, 206, 'Block B',
'Car', 'Bike', 'Subaru Impreza', 'HR 26 ST 8901', 'BMW S1000RR', 'HR 19 KL 3456', 2, 'Bangalore', 16),

('Rajakumar', 'Nurse', '9865432109', 'Rajakumar@gmail.com', '9887021548', '2468 1357 5791',2, 208, 'Block B',
NULL, 'Bike', NULL, NULL, 'Indian Scout Sixty', 'UP 04 MN 6789', 1, 'Utrapradesh', 18),

('Raja', 'Technician', '9832109876', 'Raja@gmail.com', '9758463201', '9087 6543 2109', 2, 209, 'Block B',
'Car', 'Bike', 'Lexus ES', 'RJ 17 WX 6789', 'Indian Chief Classic', 'RJ 11 OP 1234', 2, 'Rajastan', 19),

('Sanjay', 'Professor', '9754321098', 'Sanjay@gmail.com', '9857402314', '4321 0987 6543', 3, 301, 'Block C',
'Car', NULL, 'Tiago EV', 'KA 05 CD 9876', NULL, NULL, 1, 'Bangalore', 21),

('Sarath kumar', 'Designer', '9845671230', 'Sarathkumar@gmail.com', '9876987021', '6789 0123 4567',3, 304, 'Block C',
NULL, 'Bike', NULL, NULL, 'Triumph Street Triple R', 'WB 35 ST 8901', 1, 'Bangalore', 24),

('Saran Dev', 'Manager', '9821345679', 'SaranDev@gmail.com', '9875214630', '8901 2345 6789', 3, 305, 'Block C',
'Car', NULL, 'Mazda6', 'PB 13 CD 6789', NULL, NULL, 1, 'Bangalore', 25),

('Tanusha', 'Analyst', '9712345678', 'Tanusha@gmail.com', '9876543210', '0123 4567 8901',3, 306, 'Block C',
NULL, 'Bike', NULL, NULL, 'Aprilia RSV4', 'PB 20 UV 2345', 1, 'Punjap', 26),

('Kandasamy', 'Consultant', '9876501234', 'Kandasamy@gmail.com', '9865432109', '5678 9012 3456', 3, 307, 'Block C',
'Car', 'Bike', 'Infiniti Q50', 'DL 03 XY 5678', 'MV Agusta F4', 'BR 32 YZ 1234', 2, 'Bangalore', 27),

('Akilandam', 'Researcher', '9743210987', 'Akilandam@gmail.com', '9843210987', '3456 7890 1234', 3, 308, 'Block C',
NULL, 'Bike', NULL, NULL, 'Honda CB500F', 'JH 21 ZA 4567', 1, 'Bangalore', 28),

('Tarun', 'Developer', '9834567890', 'Tarun@gmail.com', '9876123450', '7890 1234 5678', 3,310, 'Block C',
'Car', 'Bike', 'Acura TLX', 'AS 24 KL 8901', 'Royal Enfield Interceptor 650', 'AS 13 CD 8901', 2, 'Bangalore', 30),

('Umesh', 'Surgeon', '9765412309', 'Umesh@gmail.com', '9812345678', '2345 6789 0123', 4, 403, 'Block D',
NULL, 'Bike', NULL, NULL, 'Yamaha MT-09', 'GA 09 EF 2345', 1, 'Gujarat', 33),

('Meenakumari', 'Therapist', '9812340987', 'Meenakumari@gmail.com', '9798654321', '8901 2345 6789', 4, 404, 'Block D',
'Car', NULL, 'Genesis G70', 'GA 01 MN 2345', NULL, NULL, 1, 'Bangalore', 34),

('Neeraj', 'Specialist', '9798765431', 'Neeraj@gmail.com', '9823456789', '6789 0123 4567', 4, 409, 'Block D',
'Car', 'Bike', 'Tesla Model 3', 'SK 34 QR 1234', 'BMW R1250GS', 'SK 17 IJ 9012', 2, 'Bangalore', 39);


SELECT * FROM tenant;

-- ---------------------------------------------------------------------------------------------------------------------------------

-- INSERT data into role table

INSERT INTO roles (owner_role, Joining_Date, Leaving_Date, owner_id)
VALUES
('Secretary', '1990-04-13', '1997-09-25', 11),
('President', '1990-06-12', '1998-07-19', 24),
('Vice-President', '1990-07-06', '2000-08-09', 9),
('Treasurer', '1990-12-26', '2001-08-29', 4),
('Secretary', '1999-12-13', NULL, 14),
('President', '1999-12-16', NULL, 12),
('Vice-President', '2001-05-06', NULL, 10),
('Treasurer', '2003-09-09', NULL, 40);

INSERT INTO roles (owner_role, Joining_Date, owner_id)
SELECT 'Member', '2001-09-10', owner_id
FROM owner
WHERE owner_id NOT IN (SELECT owner_id FROM roles);

SELECT * FROM roles;

-- ----------------------------------------------------------------------------------------------------------------------------

SELECT owner_id,floorNo,owner_houseNo,owner_block,is_owner_residing
FROM owner
WHERE is_owner_residing = 'NO';

-- insert data to payment table

INSERT INTO payment (payment_Date, payment_status, owner_id, tenant_id)
VALUES
();

