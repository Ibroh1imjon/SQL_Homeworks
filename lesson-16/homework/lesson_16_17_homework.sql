--Easy Tasks(20)

-- 1
select * from vwstaff

-- 2
create view vwitemprices as
select itemid, itemname, price from items

-- 3
create table #temppurchases (
    purchaseid int,
    clientid int,
    staffid int,
    purchasedate date,
    totalamount decimal(10,2),
    status varchar(20)
)
insert into #temppurchases values (1, 1, 1, '2024-01-15', 1270.00, 'completed')

-- 4
declare @currentrevenue decimal(10,2)

-- 5
create function fnsquare(@num int) returns int as begin
    return @num * @num
end

-- 6
create procedure spgetclients as
begin
    select * from clients
end

-- 7
merge into purchases as p
using clients as c
on p.clientid = c.clientid
when matched then
update set p.purchaseid = c.clientid, p.clientid = c.clientid, p.staffid = c.staffid, p.purchasedate = c.purchasedate, p.totalamount = c.totalamount, p.status = c.status
when not matched by target then
insert (purchaseid, clientid, staffid, purchasedate, totalamount, status)
values (c.clientid, c.clientid, c.staffid, c.purchasedate, c.totalamount, c.status)
when not matched by source then
delete


-- 8
create table #staffinfo (
    staffid int,
    fullname varchar(100),
    department varchar(50)
)
insert into #staffinfo values (1, 'alice green', 'sales')

-- 9
create function fnevenodd(@num int) returns varchar(10) as begin
    return case when @num % 2 = 0 then 'even' else 'odd' end
end

-- 10
create procedure spmonthlyrevenue(@month int, @year int) as
begin
    select sum(totalamount) from purchases where month(purchasedate) = @month and year(purchasedate) = @year
end

-- 11
create view vwrecentitemsales as
select itemid, sum(totalamount) as totalsales from purchases where purchasedate >= dateadd(month, -1, getdate()) group by itemid

-- 12
declare @currentdate date = getdate()
print @currentdate

-- 13
create view vwhighquantityitems as
select * from items where stockquantity > 100

-- 14
create table #clientorders (
    orderid int,
    clientid int,
    totalamount decimal(10,2)
)
select c.fullname, p.totalamount from #clientorders co join purchases p on co.clientid = p.clientid

-- 15
create procedure spstaffdetails(@staffid int) as
begin
    select fullname, department from staff where staffid = @staffid
end

-- 16
create function fnaddnumbers(@num1 int, @num2 int) returns int as begin
    return @num1 + @num2
end

-- 17
merge into items as i
using #newitemprices as n
on i.itemid = n.itemid
when matched then
update set i.itemid = n.itemid, i.itemname = n.itemname, i.price = n.price, i.stockquantity = n.stockquantity
when not matched by target then
insert (itemid, itemname, price, stockquantity)
values (n.itemid, n.itemname, n.price, n.stockquantity)
when not matched by source then
delete

-- 18
create view vwstaffsalaries as
select fullname, salary from staff

-- 19
create procedure spclientpurchases(@clientid int) as
begin
    select * from purchases where clientid = @clientid
end

-- 20
create function fnstringlength(@input varchar(255)) returns int as begin
    return len(@input)
end


--Medium tasks(20)

-- 1
create view vwclientorderhistory as
select clientid, purchaseid, purchasedate from purchases

-- 2
create table #yearlyitemsales (
    itemid int,
    totalquantity int,
    totalsales decimal(10,2)
)

-- 3
create procedure spupdatepurchasestatus(@purchaseid int, @newstatus varchar(20)) as
begin
    update purchases set status = @newstatus where purchaseid = @purchaseid
end

-- 4
merge into purchases as p
using clients as c
on p.clientid = c.clientid
when matched then
update set p.purchaseid = c.clientid, p.clientid = c.clientid, p.staffid = c.staffid, p.purchasedate = c.purchasedate, p.totalamount = c.totalamount, p.status = c.status
when not matched by target then
insert (purchaseid, clientid, staffid, purchasedate, totalamount, status)
values (c.clientid, c.clientid, c.staffid, c.purchasedate, c.totalamount, c.status)
when not matched by source then
delete

-- 5
declare @avgitemsale decimal(10,2)
select @avgitemsale = avg(totalamount) from purchases

-- 6
create view vwitemorderdetails as
select p.purchaseid, i.itemname, p.totalamount from purchases p join items i on p.purchaseid = i.itemid

-- 7
create function fncalcdiscount(@amount decimal(10,2), @percent int) returns decimal(10,2) as begin
    return @amount * @percent / 100
end

-- 8
create procedure spdeleteoldpurchases(@date date) as
begin
    delete from purchases where purchasedate < @date
end

-- 9
merge into staff as s
using #salaryupdates as u
on s.staffid = u.staffid
when matched then
update set s.salary = u.salary
when not matched by target then
insert (staffid, fullname, department, salary)
values (u.staffid, u.fullname, u.department, u.salary)
when not matched by source then
delete

-- 10
create view vwstaffrevenue as
select s.staffid, s.fullname, sum(p.totalamount) as totalrevenue from staff s join purchases p on s.staffid = p.staffid group by s.staffid, s.fullname
e
-- 11
create function fnweekdayname(@date date) returns varchar(10) as begin
    return datename(weekday, @date)
end

-- 12
create table #tempstaff (
    staffid int,
    fullname varchar(100),
    department varchar(50)
)
insert into #tempstaff select staffid, fullname, department from staff

-- 13
declare @clienttotalpurchases int
select @clienttotalpurchases = count(*) from purchases where clientid = 1
print @clienttotalpurchases

-- 14
create procedure spclientdetails(@clientid int) as
begin
    select * from clients where clientid = @clientid
    select * from purchases where clientid = @clientid
end

-- 15
merge into items as i
using delivery as d
on i.itemid = d.itemid
when matched then
update set i.stockquantity = d.quantity
when not matched by target then
insert (itemid, itemname, price, stockquantity)
values (d.itemid, d.itemname, d.price, d.quantity)
when not matched by source then
delete

-- 16
create procedure spmultiply(@num1 int, @num2 int) as
begin
    select @num1 * @num2
end

-- 17
create function fncalctax(@amount decimal(10,2), @taxrate decimal(5,2)) returns decimal(10,2) as begin
    return @amount * @taxrate / 100
end

-- 18
create view vwtopperformingstaff as
select s.staffid, s.fullname, count(p.purchaseid) as totalorders from staff s join purchases p on s.staffid = p.staffid group by s.staffid, s.fullname

-- 19
merge into clients as c
using #clientdatatemp as t
on c.clientid = t.clientid
when matched then
update set c.fullname = t.fullname, c.email = t.email, c.registrationdate = t.registrationdate
when not matched by target then
insert (clientid, fullname, email, registrationdate)
values (t.clientid, t.fullname, t.email, t.registrationdate)
when not matched by source then
delete

-- 20
create procedure sptopitems as
begin
    select top 5 itemid, itemname, sum(totalamount) as totalsales from purchases join items on purchases.purchaseid = items.itemid group by itemid, itemname order by totalsales desc
end


--Difficult Tasks(20)

-- 1
create procedure sptopsalesstaff(@year int) as
begin
    select top 1 s.staffid, s.fullname, sum(p.totalamount) as totalrevenue
    from staff s join purchases p on s.staffid = p.staffid
    where year(p.purchasedate) = @year
    group by s.staffid, s.fullname
    order by totalrevenue desc
end

-- 2
create view vwclientorderstats as
select clientid, count(purchaseid) as totalpurchases, sum(totalamount) as totalvalue from purchases group by clientid

-- 3
merge into purchases as p
using (select itemid, price, stockquantity from items) as i
on p.purchaseid = i.itemid
when matched then
update set p.totalamount = i.price * i.stockquantity
when not matched by target then
insert (purchaseid, clientid, staffid, purchasedate, totalamount, status)
values (i.itemid, null, null, getdate(), i.price * i.stockquantity, 'New')
when not matched by source then
delete;

-- 4
create function fnmonthlyrevenue(@year int, @month int) returns decimal(10,2) as begin
    declare @revenue decimal(10,2)
    select @revenue = sum(totalamount) from purchases where year(purchasedate) = @year and month(purchasedate) = @month
    return @revenue
end

-- 5
create procedure spprocessordertotals(@purchaseid int, @discount decimal(5,2)) as
begin
    update purchases set totalamount = totalamount - (totalamount * @discount / 100) where purchaseid = @purchaseid
    update purchases set status = 'Processed' where purchaseid = @purchaseid
end

-- 6
create table #staffsalesdata as
select s.staffid, s.fullname, sum(p.totalamount) as totalsales from staff s join purchases p on s.staffid = p.staffid group by s.staffid, s.fullname

-- 7
merge into sales as s
using #salestemp as t
on s.saleid = t.saleid
when matched then
update set s.totalamount = t.totalamount
when not matched by target then
insert (saleid, clientid, staffid, totalamount)
values (t.saleid, t.clientid, t.staffid, t.totalamount)
when not matched by source then
delete

-- 8
create procedure spordersbydaterange(@startdate date, @enddate date) as
begin
    select * from purchases where purchasedate between @startdate and @enddate
end

-- 9
create function fncompoundinterest(@principal decimal(10,2), @rate decimal(5,2), @time int) returns decimal(10,2) as begin
    return @principal * power((1 + @rate / 100), @time)
end

-- 10
create view vwquotaexceeders as
select s.staffid, s.fullname, sum(p.totalamount) as totalsales from staff s join purchases p on s.staffid = p.staffid group by s.staffid, s.fullname having sum(p.totalamount) > 10000

-- 11
create procedure spsyncproductstock as
begin
    merge into items as i
    using stocklevels as s
    on i.itemid = s.itemid
    when matched then
    update set i.stockquantity = s.stockquantity
    when not matched by target then
    insert (itemid, itemname, price, stockquantity)
    values (s.itemid, s.itemname, s.price, s.stockquantity)
end

-- 12
merge into staff as s
using externaldata as e
on s.staffid = e.staffid
when matched then
update set s.salary = e.salary
when not matched by target then
insert (staffid, fullname, department, salary)
values (e.staffid, e.fullname, e.department, e.salary);

-- 13
create function fndatediffdays(@startdate date, @enddate date) returns int as begin
    return datediff(day, @startdate, @enddate)
end

-- 14
create procedure spupdateitemprices as
begin
    update items set price = price * 1.1 where itemid in (select itemid from purchases where purchasedate > dateadd(month, -6, getdate()))
    select itemid, itemname, price from items
end

-- 15
merge into clients as c
using #clientdatatemp as t
on c.clientid = t.clientid
when matched then
update set c.fullname = t.fullname, c.email = t.email, c.registrationdate = t.registrationdate
when not matched by target then
insert (clientid, fullname, email, registrationdate)
values (t.clientid, t.fullname, t.email, t.registrationdate)
when not matched by source then
delete;

-- 16
create procedure spregionalsalesreport as
begin
    select region, sum(totalamount) as totalrevenue, avg(totalamount) as avgsale, count(staffid) as totalsalesperstaff
    from purchases join staff on purchases.staffid = staff.staffid
    group by region
end

-- 17
create function fnprofitmargin(@cost decimal(10,2), @price decimal(10,2)) returns decimal(10,2) as begin
    return (@price - @cost) / @price * 100
end

-- 18
create table #tempstaffmerge (
    staffid int,
    fullname varchar(100),
    department varchar(50)
)
merge into staff as s
using #tempstaffmerge as t
on s.staffid = t.staffid
when matched then
update set s.fullname = t.fullname, s.department = t.department
when not matched by target then
insert (staffid, fullname, department)
values (t.staffid, t.fullname, t.department);

-- 19
create procedure spbackupdata as
begin
    insert into backup_purchases select * from purchases
    insert into backup_clients select * from clients
    insert into backup_staff select * from staff
end

-- 20
create procedure sptopsalesreport as
begin
    select top 10 s.staffid, s.fullname, sum(p.totalamount) as totalsales
    from staff s join purchases p on s.staffid = p.staffid
    group by s.staffid, s.fullname
    order by totalsales desc
end

