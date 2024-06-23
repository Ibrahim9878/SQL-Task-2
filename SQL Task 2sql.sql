Use Employees
/* Database Employees */

/* 1. Get empid, firstname, lastname, country, region, city of all employees from USA. */

Select BusinessEntityID,FirstName,LastName,CountryRegionName,City
From Employees
Where CountryRegionName = 'United States'

/* 2. Get the number of employees for each specialty. */

Select Count(JobTitle),JobTitle
From Employees
Group By JobTitle

/* 3. Count the number of people for each name. */

Select Count(FirstName), FirstName
From Employees
Group By FirstName

/* 4. Get the most common name. */

Select Top(1) FirstName
From Employees
Group By FirstName
Order By COUNT(FirstName) Desc

/* 5. Get the least common name. */

Select Top(1) FirstName
From Employees
Group By FirstName
Order By COUNT(FirstName)

/* 6. Get the top 5 cities where the most workers are. */

Select Top(5) City 
From Employees
Group By City
Order By Count(City) Desc

/* 7. Get the top 5 cities, which have the most unique specialties. */

Select TOP(5) City, COUNT(JobTitle) AS UniqueSpeciality
From Employees
Group By City
Order By Count(JobTitle) 

/* 8. Issue mailing addresses for emailing to all employees who started working on 1/01/2012. */

Select EmailAddress
From Employees
Where StartDate = '2012/01/1'

/* 9. Issue statistics in what year how many employees were employed. */

Select StartDate, Count(StartDate) As HiredEmployees
From Employees
Group By StartDate 

/* 10. Issue statistics in which year how many workers in which countries were employed. */

Select StartDate, Count(StartDate) As HiredEmployees,CountryRegionName
From Employees
Group By StartDate ,CountryRegionName

/* 11. Refresh the Employees table by adding data from the History table to the EndDate column. */

Insert into dbo.Employees(EndDate) Select EndDate From Employees Where EndDate is not null
Select EndDate
From Employees

Select *
From Employees
UPDATE Employees
SET EndDate = (SELECT  Top(1) EndDate
  FROM dbo.History
  WHERE dbo.History.BusinessEntityID = dbo.Employees.BusinessEntityID AND EndDate is not NULL
  Order By EndDate Desc);

/* 12. Issue statistics on how many employees in which year they left. */

Select EndDate,Count(*) As LeftedEmployersCount
From Employees
Where EndDate is not null
Group By EndDate

/* 13. Issue the number of employees who have worked less than a year. */

Select Count(*),EndDate
From Employees
Where (Year(EndDate) - Year(StartDate)) < 1 And EndDate is not null
Group By EndDate