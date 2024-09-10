-- 1. cleaning data in sql queries
SELECT * FROM HousingData;

-- How to correct Date field (Standadize Date format)

ALTER TABLE HousingData
Add SaleDateConverted Date;

UPDATE HousingData
SET SaleDateConverted = CONVERT(Date,SaleDate);

SELECT SaleDateConverted FROM HousingData;

-- -------------------------------------------------------------------------------------------------------------------
-- 2.  populate property address data
-- Note: Here ParcelID and PropertyAddress are repeating and propertyAddress is null. So find that value

SELECT PropertyAddress
FROM HousingData;

SELECT a.ParcelID,a.PropertyAddress, b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress ) 
FROM HousingData a
JOIN HousingData b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is NULL;

-- update that repeating ParcelID and PropertyAddress with NULL data field
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress )
FROM HousingData a
JOIN HousingData b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is NULL;

-- -------------------------------------------------------------------------------------
-- Breaking Address into individual column (Address, City)

SELECT PropertyAddress FROM HousingData;

-- input = 106 BENSON  RD, NASHVILLE - from 1st value to till comma(,) -- and to remove the comma give(-1)
-- output = 106 BENSON  RD,

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) As Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) As City -- to remove comma from City put +1
FROM HousingData;


ALTER TABLE HousingData
Add PropertySplitAddress nvarchar(255)

ALTER TABLE HousingData
Add PropertySplitCity nvarchar(255)


UPDATE HousingData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1);

UPDATE HousingData
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress));


SELECT * FROM HousingData;
-- =========================================================================================

-- Breaking OwnerAddress into individual column (Address, City, State)

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
FROM HousingData;

 -- ALTER TABLE HousingData DROP COLUMN OwnerSplitState;


ALTER TABLE HousingData
Add OwnerSplitAddress nvarchar(255)

ALTER TABLE HousingData
Add OwnerSplitCity nvarchar(255)

ALTER TABLE HousingData
Add OwnerSplitState nvarchar(255)

UPDATE HousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3);

UPDATE HousingData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2);

UPDATE HousingData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1);

SELECT * FROM HousingData;

--=====================================================================================================

-- Change Y and N to Yes and No in 'SoldAsVacant' field (4 fields are there - (Y,N,Yes,No))
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) as Total
From HousingData
GROUP BY SoldAsVacant;

SELECT SoldAsVacant,
CASE 
	WHEN SoldAsVacant ='Y' THEN 'Yes'
	WHEN SoldAsVacant ='N' THEN 'No'
	ELSE SoldAsVacant
END 
FROM HousingData;

-- update these to table
UPDATE HousingData
SET SoldAsVacant = CASE 
	WHEN SoldAsVacant ='Y' THEN 'Yes'
	WHEN SoldAsVacant ='N' THEN 'No'
	ELSE SoldAsVacant
END 

-- -------------------------------------------------------------------------------------------

-- Remove Duplicates
	-- Find duplicate

SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
					UNIQUEID
			) row_num
		FROM HousingData
		ORDER BY ParcelID

	-- DELETE Duplicate
	WITH ROWNUMCTE As (
	SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
					UNIQUEID
			) row_num
		FROM HousingData
	)
	

/*
	SELECT * FROM ROWNUMCTE
	WHERE row_num > 1
	ORDER BY PropertyAddress;
*/
	-- DELETE
	DELETE FROM ROWNUMCTE
	WHERE row_num > 1;
-- ---------------------------------------------------------------------------------------------------------------------

SELECT * FROM HousingData;

-- Delete unused column

ALTER TABLE HousingData
DROP COLUMN OwnerAddress, TaxDistrict,PropertyAddress;

ALTER TABLE HousingData
DROP COLUMN SaleDate;

