
create database Coursee
use Coursee

create table Students(
[Id]int primary key identity(1,1),
[Name]nvarchar(50),
[Surname]nvarchar(50),
[Email]nvarchar(50) unique,
[Address]nvarchar(50),
[Age]int 
)
create procedure usp_createStudents
@name nvarchar(50),
@surname nvarchar(50),
@email nvarchar(50),
@address nvarchar(50),
@age int
as
begin
insert into Students([Name],[Surname],[Email],[Address],[Age])
values(@name,@surname,@email,@address,@age)
end

usp_createStudents 'Rashad','Aghayev','rashad@gmail.com','Ordubad',21
usp_createStudents 'Behruz','Eliyev','behruz@gmail.com','Gence',37
usp_createStudents 'Elvin','Memmedli','elvin@gmail.com','Ordubad',19
usp_createStudents 'Ilqar','Sadiqli','ilqar@gmail.com','Ordubad',20


create table StudentsArchive(
[Id]int primary key identity(1,1),
[StudentId]int,
[Date] datetime,
)

alter table StudentsArchive
--add [Surname] nvarchar(50)
--add[Name]nvarchar(50)
add[Email]nvarchar(50)

create procedure usp_deleteStudents
 @id int
 as
 begin
 delete from Students where[Id]=@id;
 end
 

 

 usp_createStudents 'Rashad','aghayev','dhj@gmail.com','ordu',23

 create trigger trg_deleteStudentsArchive 
 on Students
 after delete
 as
 begin
   insert into StudentsArchive([StudentId],[Name],[Surname],[Email],[Date])
   select [Id],[Name],[Surname],[Email],Getdate() from deleted
 end

exec usp_deleteStudents 7
select * from Students
select * from StudentsArchive