use Course
select * from Teachers

create view getTeachersWithId
as
select * from Teachers where [Id]>3

select * from getTeachersWithId

create view getTeachersWithAge
as
select top 3 * from Teachers where [Age]>18

select * from getTeachersWithAge

create function sayHelloworld()
returns nvarchar(50)
as
begin
return 'Hello World'
end

declare @data nvarchar(30)=(select dbo.sayHelloworld() as 'Data')
print @data

create function dbo.showText(@text nvarchar(50))
returns nvarchar(50)
as
begin
return @text
end
select dbo.showText('Resad') as data

create function dbo.SumOfNums(@num1 int,@num2 int)
returns int
as
begin
return @num1+ @num2
end

declare @id int=(select dbo.SumOfNums(1,2))
select * from Teachers where [Id]=@id


create function dbo.getTeachersCountByAge(@age int)
returns int
as 
begin
declare @count int;
select @count= Count(*) from Teachers where [Age]>@age;
return @count;
end

select * from Teachers
select dbo.getTeachersCountByAge(18) as 'Teachers count'

create function dbo.getAllTeachers()
returns table
as 
return (select * from Teachers)


select * from dbo.getAllTeachers()

create function dbo.searchTeachersByName(@searchText nvarchar(50))
returns table
as
return(
select * from Teachers where [Name] like '%'+@searchText+'%'
)
select * from Teachers
select * from dbo.searchTeachersByName('a')

create procedure usp_ShowText   --user store procedure
as
begin 
print 'salamlar'
end

usp_ShowText
exec usp_ShowText
execute usp_ShowText

create procedure usp_ShowText3
@text nvarchar(50)
as
begin 
print @text
end

usp_ShowText3 'Salaaaam'

execute  usp_ShowText3 'Salaaaam'

exec  usp_ShowText3 'Salaaaam'


create procedure usp_createTeacher
@name nvarchar(100),
@surname nvarchar(100),
@email nvarchar(200),
@age int
as
begin
insert into Teachers ([Name],[Surname],[Email],[Age])
values(@name,@surname,@email,@age)
end


exec usp_createTeacher 'Ismayil','Ceferli','ismayil@gmail.com',24

select * from Teachers
exec usp_createTeacher 'Esgerxan','Bayramov','esgerxan@gmail.com',26


create procedure usp_deleteTeachersById
@id int
as
begin
delete from Teachers where [Id]=@id
end

exec usp_deleteTeachersById 5
select * from Teachers


create function dbo.getTeachersAvgAges(@id int)
returns int
as
begin
declare @avgAge int;
select @avgAge=Avg(age) from Teachers where [Id]>@id
return @avgAge
end

select dbo.getTeachersAvgAges(3)

create procedure usp_changeTeacherNameByCondition
@id int,
@name nvarchar(50)
as 
begin
declare @avgAge int = (select dbo.getTeachersAvgAges(@id))
update Teachers
set[Name]=@name
where[Age]>@avgAge
end

exec usp_changeTeacherNameByCondition 3,'XXX'
select * from Teachers order by [Age]asc

create table TeacherLogs(
[Id] int primary key identity(1,1),
[TeacherId] int,
[Operation] nvarchar(20),
[Date] datetime
)
select * from TeacherLogs
select * from Teachers

--select getdate()

create trigger trg_createTeacherLogs 
on Teachers
after insert
as
begin
   insert into TeacherLogs([TeacherId],[Operation],[Date])
   select [Id],'insert',GetDate() from  inserted
end

exec usp_createTeacher 'Afide','Valiyeva','afide@gmail.com',39

select * from TeacherLogs
select * from Teachers

create trigger trg_deleteTeacherLogs 
on Teachers
after delete
as
begin
   insert into TeacherLogs([TeacherId],[Operation],[Date])
   select [Id],'delete',GetDate() from  deleted
end
select * from TeacherLogs
exec usp_deleteTeachersById 3

--create trigger trg_deleteTeacherLogs 
--on Teachers
--after update
--as
--begin
--   insert into TeacherLogs([TeacherId],[Operation],[Date])
--   select [Id],'update',GetDate() from  deleted
--end