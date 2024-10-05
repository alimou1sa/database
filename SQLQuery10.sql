--Select Distinct Statement
select  distinct ModelId from VehicleDetails;

--Where Statement + AND , OR, NOT
select * 
from VehicleDetails
where MakeID = 2;

select * 
from VehicleDetails
where MakeID = 3 and ModelId = 29;

select * 
from VehicleDetails
where MakeID = 3 Or MakeID = 2;

select * 
from VehicleDetails
where Not (MakeID = 3 Or MakeID = 2);

--"In" Operator
select * 
from VehicleDetails
where BodyID in (16, 15);

--Sorting : Order By
select * 
from VehicleDetails
order by Id;

select * 
from VehicleDetails
order by Id desc;

--Select Top Statement
select top(10) *
from VehicleDetails;

--Select As
select Id as VehicleDetailsId, year as Made 
from VehicleDetails;

--Between Operator
select *
from VehicleDetails
where year between 1990 and 2000;

--Count, Sum, Avg, Min, Max Functions
select count(*)
from VehicleDetails;

select min(ID)
from VehicleDetails;

select max(ID)
from VehicleDetails;

--Group By
select MakeID, count(*)
from VehicleDetails
group by MakeId
order by MakeID;

select ModelID, count(*)
from VehicleDetails
group by ModelID
order by ModelID;

--Having
select MakeID,x=count(*)
from VehicleDetails
group by MakeId
having count(*) between 6 and 8
order by 2;

--Like
select *
from VehicleDetails
where Vehicle_Display_Name like 'AC%'
order by ID;

select *
from VehicleDetails
where Vehicle_Display_Name like 'Acur_ %'
order by ID;


--WildCards
select ID, Vehicle_display_name 
from VehicleDetails
Where Vehicle_display_name like 'Acura RSX 200[36] Base';

--Joins
select m.MakeID, m.Make, v.Engine
from VehicleDetails v
join Makes m
on v.MakeID = m.MakeID
where m.MakeID = 2
order by M.MakeID;

select b.BodyID, b.BodyName, v.NumDoors
from VehicleDetails v
join Bodies b
on v.BodyID = b.BodyID
where  b.BodyID = 2 and v.NumDoors is not null
order by b.BodyID;

--Views
--You can use any qury from the above and make a view :)


--Exists
SELECT ID,Engine
FROM VehicleDetails
WHERE EXISTS (SELECT fueltypeid FROM FuelTypes WHERE  FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID AND fueltypeid  = 1)
order by Id;

--UNION
SELECT Engine FROM VehicleDetails where Id = 1
UNION
SELECT Engine FROM VehicleDetails where Id = 2;

--Case
SELECT Id,
	   MakeId,
	   case when NumDoors is null then 0 else NumDoors end  as 'Number Of Doors'
FROM VehicleDetails
where makeid= 1 or makeid= 4
order by makeid desc;


USE VehicleMakesDB
GO
ALTER AUTHORIZATION ON DATABASE::VehicleMakesDB TO [sa]
GO


select * from VehicleDetails
select * from VehicleMasterDetails
select * from Makes
select * from MakeModels
select * from SubModels
select * from DriveTypes
select * from Bodies



SELECT Makes.Make ,carnumber=COUNT(*) ,(select count(*) from VehicleDetails) as totalvehicles,
persantag=cast( COUNT(*)as float )/ cast ((select count(*) from VehicleDetails)as float)
FROM   VehicleDetails INNER JOIN
Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE (VehicleDetails.Year BETWEEN 1950 AND 2000)
GROUP BY Makes.Make 
order by carnumber desc



select * , cast( carnumber as float )/ cast (totalvehicles as float) as Pers from
(
SELECT Makes.Make ,COUNT(*) as carnumber ,(select count(*) from VehicleDetails) as totalvehicles
FROM   VehicleDetails INNER JOIN
Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE (VehicleDetails.Year BETWEEN 1950 AND 2000)
GROUP BY Makes.Make 

)r1
order by carnumber desc


SELECT Makes.Make, FuelTypes.FuelTypeName,x=count(*)
FROM   Makes INNER JOIN
             VehicleDetails ON Makes.MakeID = VehicleDetails.MakeID INNER JOIN
             FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
			 WHERE (VehicleDetails.Year BETWEEN 1950 AND 2000)
			 group by Makes.Make,FuelTypes.FuelTypeName
			 order by Makes.Make


SELECT VehicleDetails.ModelID, VehicleDetails.SubModelID, VehicleDetails.BodyID, VehicleDetails.Vehicle_Display_Name, VehicleDetails.Year, VehicleDetails.DriveTypeID, VehicleDetails.Engine, VehicleDetails.Engine_CC, VehicleDetails.Engine_Cylinders, 
             VehicleDetails.Engine_Liter_Display, VehicleDetails.FuelTypeID, VehicleDetails.NumDoors, VehicleDetails.ID, VehicleDetails.MakeID, FuelTypes.FuelTypeName
FROM   VehicleDetails INNER JOIN
             FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID

			 where FuelTypes.FuelTypeName=N'GAS'


select count(*)from
(
SELECT distinct Makes.Make, FuelTypes.FuelTypeName
FROM   Makes INNER JOIN
             VehicleDetails ON Makes.MakeID = VehicleDetails.MakeID INNER JOIN
             FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
			 
			where ( FuelTypes.FuelTypeName=N'GAS')

)r


SELECT Makes.Make, count(*) as numberveh
FROM   VehicleDetails INNER JOIN
             Makes ON VehicleDetails.MakeID = Makes.MakeID
			 group by Makes.Make
			 having count(*)>20000
			 order by numberveh desc

	

	select Makes.Make from Makes
	where Makes.Make like 'B%'


	select count(*)
	from
	(
SELECT distinct Makes.Make, DriveTypes.DriveTypeName
FROM   Makes INNER JOIN
             VehicleDetails ON Makes.MakeID = VehicleDetails.MakeID INNER JOIN
             DriveTypes ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
			 where DriveTypes.DriveTypeName='FWD'

			 )r



SELECT distinct Makes.Make, DriveTypes.DriveTypeName
FROM   Makes INNER JOIN
             VehicleDetails ON Makes.MakeID = VehicleDetails.MakeID INNER JOIN
             DriveTypes ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID

			 order by Makes.Make asc
			 

			 
SELECT        distinct Makes.Make, DriveTypes.DriveTypeName, Count(*) AS Total
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID

						
Group By Makes.Make, DriveTypes.DriveTypeName
Order By Make ASC, Total Desc




SELECT        distinct Makes.Make, DriveTypes.DriveTypeName, Count(*) AS Total
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID

Group By Makes.Make, DriveTypes.DriveTypeName
Having Count(*) > 10000

Order By Make ASC, Total Desc



select 
	(
	
	
		CAST(	(select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails
		where NumDoors is Null) as float)
		/
		Cast( (select count(*) from VehicleDetails as TotalVehicles) as float)
	
	
	) as PercOfNoSpecifiedDoors


			 
SELECT    distinct    VehicleDetails.MakeID, Makes.Make, SubModelName
FROM            VehicleDetails INNER JOIN
                         SubModels ON VehicleDetails.SubModelID = SubModels.SubModelID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
	
	where SubModelName='Elite'



select * from VehicleDetails
where ( VehicleDetails.Engine_Liter_Display>3) and (VehicleDetails.NumDoors=2)



SELECT VehicleDetails.*, Makes.Make
FROM   VehicleDetails INNER JOIN
             Makes ON VehicleDetails.MakeID = Makes.MakeID
			 where (VehicleDetails.Engine like '%OHV%')and( VehicleDetails.Engine_Cylinders=4)


	

SELECT VehicleDetails.*,Bodies.BodyName
FROM   VehicleDetails INNER JOIN
             Bodies ON VehicleDetails.BodyID = Bodies.BodyID
			 where Bodies.BodyName in( 'Sport UtilIty', 'Coupe', 'Sedan') and Year in(2008,2020)



			 select x='1' 
			 where(
			 exists (select top 1* from VehicleDetails where VehicleDetails.Year=1959)
			)



			select VehicleDetails.Vehicle_Display_Name ,VehicleDetails.NumDoors, 
			description =
			case
			when VehicleDetails.NumDoors =1 then 'one'
			when VehicleDetails.NumDoors =2 then 'two'
			when VehicleDetails.NumDoors =3 then 'three'
			when VehicleDetails.NumDoors =4 then 'four'
		    when VehicleDetails.NumDoors =8 then 'eight'
			when VehicleDetails.NumDoors is null then 'nothing'
			else 'abcdef'
			end
			from VehicleDetails


			select * from (
select VehicleDetails.Vehicle_Display_Name,Year,
age=Year(getDate())-VehicleDetails.Year from VehicleDetails
)r
where r.age between 15 and 25
order by age desc



select min(VehicleDetails.Engine_CC) ,max (VehicleDetails.Engine_CC),avg(VehicleDetails.Engine_CC) from VehicleDetails



select * from VehicleDetails
where Engine_CC= (select  min(VehicleDetails.Engine_CC) from VehicleDetails)


select count(*)
from
(
select * from VehicleDetails
where Engine_CC< (select  avg(VehicleDetails.Engine_CC) from VehicleDetails)
)r


select distinct VehicleDetails.Engine_CC from VehicleDetails
order by Engine_CC desc




select distinct top 3 VehicleDetails.Engine_CC from VehicleDetails
order by Engine_CC desc



select  VehicleDetails.Engine_CC from VehicleDetails
where Engine_CC in 
(   
select distinct top 3 VehicleDetails.Engine_CC from VehicleDetails
order by Engine_CC desc
)



SELECT Makes.Make
FROM   VehicleDetails INNER JOIN
             Makes ON VehicleDetails.MakeID = Makes.MakeID
			 where Engine_CC in (select distinct top 3 VehicleDetails.Engine_CC from VehicleDetails
order by Engine_CC desc)
order by Makes.Make desc





select Engine_CC,

      		case
		   when  Engine_CC between 0 and 1000  then 100
			when Engine_CC between 1001 and 2000  then 200
			when Engine_CC between 2001 and 4000  then 300
			when Engine_CC between 4001 and 6000  then 400
		    when Engine_CC between 6001 and 8000  then 500
		    when Engine_CC between 8001 and 10000  then 600
				else 0
			end as Tax
			
			from 
			(
			select distinct Engine_CC from VehicleDetails
			)r

order by Engine_CC desc




SELECT distinct Makes.Make , sum(NumDoors) 
FROM   VehicleDetails INNER JOIN
             Makes ON VehicleDetails.MakeID = Makes.MakeID

			 group by Make 
		
having Make='Ford'

SELECT Makes.Make,count(*)
FROM   Makes INNER JOIN
             MakeModels ON Makes.MakeID = MakeModels.MakeID
			 	 group by Make



SELECT distinct top (3) Makes.Make, count(*)
FROM   Makes INNER JOIN
             MakeModels ON Makes.MakeID = MakeModels.MakeID
			 	 group by Make
				 order by count(*) desc


SELECT Makes.Make, count(*) as total
FROM   Makes INNER JOIN
             MakeModels ON Makes.MakeID = MakeModels.MakeID
			 	 group by Make
	
				 having count(*) =
				 (
select max(r.total) from
(
SELECT Makes.MakeID  ,count(*) as total
FROM   Makes INNER JOIN
             MakeModels ON Makes.MakeID = MakeModels.MakeID
			 	 group by Makes.MakeID
			
)r
)



SELECT Makes.Make, count(*) as total
FROM   Makes INNER JOIN
             MakeModels ON Makes.MakeID = MakeModels.MakeID
			 	 group by Make
	
				 having count(*) =
				 (
select min(r.total) from
(
SELECT Makes.MakeID  ,count(*) as total
FROM   Makes INNER JOIN
             MakeModels ON Makes.MakeID = MakeModels.MakeID
			 	 group by Makes.MakeID
			
)r
)



select FuelTypes.FuelTypeName from FuelTypes
order by newid()



select 
(
		CAST((select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails
		where NumDoors is Null) as float)
		/
		Cast( (select count(*) from VehicleDetails as TotalVehicles) as float)
) as PercOfNoSpecifiedDoors


	



SELECT        distinct Makes.Make
FROM            VehicleDetails INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE        (VehicleDetails.Engine_CC IN
                             (SELECT DISTINCT TOP (3) Engine_CC
                               FROM            VehicleDetails 
                               ORDER BY Engine_CC DESC)
							 )
Order By Make













