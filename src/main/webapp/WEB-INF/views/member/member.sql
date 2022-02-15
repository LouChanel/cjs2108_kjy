show tables;

create table member(
	idx	int not null auto_increment,		/* 회원 고유번호 */
	mid varchar(20) not null,						/* 회원 아이디(중복불허) */
	pwd varchar(200) not null,					/* 비밀번호(입력시 8~15자로 제하처리할것) */
	nickName varchar(20) not null,			/* 별명(중복불허) */
	name varchar(20) not null,					/* 성명 */
	gender varchar(10) default '남자',		/* 성별 */
	birthday datetime default now(),		/* 생일 */
	tel varchar(15) not null,						/* 연락처 */
	address varchar(50) default '',			/* 주소 */
	email varchar(50) not null,					/* 이메일(아이디/비밀번호 분실시 필요) */
	visitCnt int default 0,							/* 방문횟수 */
	startDate datetime default now(),		/* 최초 가입일 */
	lastDate datetime default now(),		/* 마지막 접속일 */
	level int default 4,								/* 1:특별회원, 2:우수회원, 3:정회원, 4:준회원, 0:관리자 */
	todayCnt int default 0,							/* 오늘 방문한 횟수 */
	photo varchar(100) default 'noimage.jpg', 	/* 회원사진 */
	primary key(idx, mid)								/* 키본키 : 고유번호, 아이디 */
);

/* drop table member */
desc member;

select * from member;

insert into member values (default,'admin','1234','관리자','관리자',default,default,'010-0000-0000','관리자','admin@admin.com',default,default,default,'0',default,default);