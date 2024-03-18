--Select *
--From PortfolioProject. .CovidDeaths
--order by 3,4

--Select *
--From PortfolioProject. .CovidVaccinations
--Order by 3,4


-- Select Data That we are going to be using

--Select Location, date, total_cases, new_cases, total_deaths, population
--From PortfolioProject. .CovidDeaths
--Order by 1,2

-- Looking at total cases vs total deaths
-- shows likelyhood of dying if contracted covid in your country
--Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--From PortfolioProject. .CovidDeaths
--where location like '%states%'
--Order by 1,2


-- Looking at total cases vs population

--Select Location, date, population, total_cases, (total_cases/population)*100 as PopulationPercentage
--From PortfolioProject. .CovidDeaths
----where location like '%states%'
--Order by 1,2


--highest infection rate to population by country

--Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 as PopulationPercentage
--From PortfolioProject. .CovidDeaths
----where location like '%states%'
--Group by Location, Population
--Order by PopulationPercentage desc


----Highest Death Count per population
--Select Location, MAX(cast (total_deaths as int)) as TotalDeathCount 
--From PortfolioProject. .CovidDeaths
--Where continent is not null
----where location like '%states%'
--Group by Location, Population
--Order by TotalDeathCount desc

-- Lets break it down by continent

--Select location, MAX(cast (total_deaths as int)) as TotalDeathCount 
--From PortfolioProject. .CovidDeaths
--Where continent is null
--Group by location
--Order by TotalDeathCount desc

-- Visualization view point, Global numbers

--Select location, MAX(cast (total_deaths as int)) as TotalDeathCount 
--From PortfolioProject. .CovidDeaths
--Where continent is null
--Group by location
--Order by TotalDeathCount desc


---- Global Numbers
----Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(New_Deaths as int))/Sum(New_cases)*100 as DeathPercentage
----From PortfolioProject. .CovidDeaths
----where continent is not null
------group by date
----Order by 1,2


---- looking at total population vs vaccinations

--With PopvsVAC (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
--as
--(
--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--SUM(convert(int,vac.new_vaccinations)) over
--(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--From PortfolioProject. .CovidDeaths dea
--Join PortfolioProject. .CovidVaccinations vac
--	On dea.location = vac.location
--	and dea.date = vac.date
--	where dea.continent is not null
--	-- order by 2,3
--	)

--	Select *, (RollingPeopleVaccinated/Population)*100
--	From PopvsVAC


	DROP Table if exists #PercentPopluationVaccinated

	Create Table #PercentPopluationVaccinated
	(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
	)

	Insert into #PercentPopulationVaccinated
	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) over
(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject. .CovidDeaths dea
Join PortfolioProject. .CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	--where dea.continent is not null
	-- order by 2,3

	Select *, (RollingPeopleVaccinated/Population)*100
	From #PercentPopluationVaccinated