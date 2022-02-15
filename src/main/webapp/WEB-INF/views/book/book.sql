show tables;

create table book (
	idx int not null auto_increment,
	bookCode varchar(20) not null,
	bookName varchar(50) not null,
	name varchar(20) not null,
	shop varchar(40) not null,
	bookDate datetime default now(),
	bookPrice int not null,
	bname varchar(200) not null,
	bsname varchar(200) not null,
	content text,
	primary key (idx)
);

desc book;
drop table book;

select * from book;

create table partMain(
	partMainCode char(1) not null,
	partMainName varchar(20) not null,
	primary key(partMainCode)
);

create table partSub(
	partMainCode char(1) not null,
	partSubCode char(2) not null,
	partSubName varchar(20) not null,
	primary key(partSubCode),
	foreign key(partMainCode) references partMain(partMainCode) on update cascade on delete restrict
);

select * from partMain;
select * from partSub;