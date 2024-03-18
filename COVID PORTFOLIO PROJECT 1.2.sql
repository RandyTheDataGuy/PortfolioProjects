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

-- Creating view to store dat for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) over
(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject. .CovidDeaths dea
Join PortfolioProject. .CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	 --order by 2,3


	Select *
	From PercentPopulationVaccinated 