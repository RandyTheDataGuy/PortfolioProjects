--Select *
--From PortfolioProject.dbo.NashvilleHousing


Select SaleDate, convert(Date,SaleDate)
From PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing 
SET SaleDate = convert(Date,SaleDate)


Alter TABLE NashvilleHousing
add SaleDateConverted Date;

Update NashvilleHousing 
Set SaleDateConverted = Convert(Date,SaleDate)

Select SaleDateConverted, convert(Date,SaleDate)
From PortfolioProject.dbo.NashvilleHousing


Select PropertyAddress
From PortfolioProject..NashvilleHousing
Where PropertyAddress is null

Select *
From PortfolioProject..NashvilleHousing
Where PropertyAddress is null

Select *
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is null
order by ParcelID 


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress , ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID 
	and a.[UniqueID ] <> b.[UniqueID ] 
where a.PropertyAddress is null

Update a
Set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID 
	and a.[UniqueID ] <> b.[UniqueID ] 
where a.PropertyAddress is null


Select *
From PortfolioProject..NashvilleHousing
Where PropertyAddress is null


Select PropertyAddress 
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is null


Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) as City
From PortfolioProject..NashvilleHousing

Alter TABLE NashvilleHousing
add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing 
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

Alter TABLE NashvilleHousing
add PropertySplitCity Nvarchar(255);

Update NashvilleHousing 
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))

Select *
From PortfolioProject..NashvilleHousing


Select OwnerAddress  
From PortfolioProject..NashvilleHousing


Select
PARSENAME(Replace(OwnerAddress, ',', '.') ,3) as Address
,PARSENAME(Replace(OwnerAddress, ',', '.') ,2) as City
,PARSENAME(Replace(OwnerAddress, ',', '.') ,1) as State
From PortfolioProject..NashvilleHousing


Alter TABLE NashvilleHousing
add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing 
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.') ,3)

Alter TABLE NashvilleHousing
add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing 
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.') ,2)

Alter TABLE NashvilleHousing
add OwnerSplitState Nvarchar(255);

Update NashvilleHousing 
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.') ,1)


Select *
From PortfolioProject..NashvilleHousing


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
group by SoldAsVacant 
order by 2 

Select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes'
When SoldAsVacant = 'N' then 'No'
else SoldAsVacant 
end
From PortfolioProject..NashvilleHousing

Update NashvilleHousing 
Set SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
When SoldAsVacant = 'N' then 'No'
else SoldAsVacant 
End
From PortfolioProject.dbo.NashvilleHousing 


--Remove Duplicates

Select *,
	Row_Number() Over (
	Partition by ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
			Order by
				UniqueID
				) row_num

From PortfolioProject.dbo.NashvilleHousing 
order by ParcelID 



With RowNumCTE as(
Select *,
	Row_Number() Over (
	Partition by ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
			Order by
				UniqueID
				) row_num

From PortfolioProject.dbo.NashvilleHousing 
)

Delete
From RowNumCTE 
where row_num > 1
--order by PropertyAddress 

With RowNumCTE as(
Select *,
	Row_Number() Over (
	Partition by ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
			Order by
				UniqueID
				) row_num

From PortfolioProject.dbo.NashvilleHousing 
)

select *
From RowNumCTE 
where row_num > 1
order by PropertyAddress 



Select *
From PortfolioProject..NashvilleHousing


Alter Table PortfolioProject..NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate





