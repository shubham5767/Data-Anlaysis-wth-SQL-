select * from NationalHousing ;
---------------------------
select Saledate, CONVERT(date, SaleDateConverted)
from NationalHousing

select SaleDate,CONVERT (date, SaleDate)
from NationalHousing ;

Update NationalHousing 
set SaleDate = CONVERT (date, SaleDate);

ALTER TABLE NationalHousing 
ADD SaleDateConverted Date;


--Update NationalHousing
--set SaleDateConverted = Convert(Date,SaleDate);

---------------------------
select *
from NationalHousing
where PropertyAddress is null 
order by ParcelID ;

select a.ParcelID ,a.PropertyAddress, b.ParcelID , b.PropertyAddress, isnull (a.PropertyAddress , b.PropertyAddress)
from NationalHousing a 
Join NationalHousing b 
	on a.ParcelID = b.ParcelID 
	AND a.[UniqueID ] <> b.[UniqueID ] 
	where a.PropertyAddress is null ;

update a
set PropertyAddress = isnull (a.PropertyAddress , b.PropertyAddress)
from NationalHousing a 
Join NationalHousing b 
	on a.ParcelID = b.ParcelID 
	AND a.[UniqueID ] <> b.[UniqueID ] 
where a.PropertyAddress is null ;

-----------------------------
select * from NationalHousing ;

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 ,LEN(PropertyAddress))as Address
from NationalHousing ;


-------------------------------------------
ALTER TABLE NationalHousing 
ADD PropertySplitAddress Nvarchar(255) ;


Update NationalHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)

 
ALTER TABLE NationalHousing 
ADD PropertySplitCity Nvarchar(255) ;


Update NationalHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 ,LEN(PropertyAddress))

----------------------------------------
--select 
--Substring(OwnerName,1, CHARINDEX(',', OwnerName)) as Owner_name
--,SUBSTRING(OwnerName,CHARINDEX(',', OwnerName) +1,LEN(OwnerName) )as ownwers
--from NationalHousing
---------------------------------------------
--# Using ParseName 

select 
PARSENAME(REPLACE(OwnerName,',','.'),2) as first_name
,PARSENAME(REPLACE(OwnerName,',','.'),1) as last_name
from NationalHousing

Alter table NationalHousing
Add Owners_name Nvarchar(255); 

update NationalHousing
set OwnerName = PARSENAME(REPLACE(OwnerName,',','.'),2) 

Alter table NationalHousing 
Add owner_l_name Nvarchar(255);

update NationalHousing
set owner_l_name = PARSENAME(REPLACE(OwnerName,',','.'),1) 

select owner_l_name 
from NationalHousing


select Distinct SoldAsVacant , count(SoldAsVacant)
from NationalHousing
group by SoldAsVacant 
order by SoldAsVacant

-----Change Y to Yes and N to No ----

select SoldAsVacant, 
Case 
	WHEN SoldAsVacant = 'N' then 'No'
	when SoldAsVacant = 'Y' then 'Yes'
	else SoldAsVacant end
from NationalHousing 

----------------------------------------------------------
---Remove Duplicates

WITH Sorted as(
select *,
ROW_NUMBER() OVER (
PARTITION by ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference 
			Order by 
			UniqueID ) roe_num
from NationalHousing )
select * from sorted 
where roe_num > 1 ;
--order by ParcelID 

-----DELETE unused columns ----

alter table NationalHousing
Drop column SaleDate, TaxDistrict,Owners_name

---Lets DO some Calculations 

select LandValue,BuildingValue,TotalValue,Bedrooms, (LandValue * BuildingValue) as new_coast
from NationalHousing
where Bedrooms > 2 and Bedrooms < 4
order by new_coast desc

select *
from NationalHousing
where OwnerName is null



Update NationalHousing
set OwnerName = REPLACE(OwnerName,Null,'string')

select *
from NationalHousing ;


