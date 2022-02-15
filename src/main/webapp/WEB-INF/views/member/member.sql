show tables;

create table member(
	idx	int not null auto_increment,		/* ȸ�� ������ȣ */
	mid varchar(20) not null,						/* ȸ�� ���̵�(�ߺ�����) */
	pwd varchar(200) not null,					/* ��й�ȣ(�Է½� 8~15�ڷ� ����ó���Ұ�) */
	nickName varchar(20) not null,			/* ����(�ߺ�����) */
	name varchar(20) not null,					/* ���� */
	gender varchar(10) default '����',		/* ���� */
	birthday datetime default now(),		/* ���� */
	tel varchar(15) not null,						/* ����ó */
	address varchar(50) default '',			/* �ּ� */
	email varchar(50) not null,					/* �̸���(���̵�/��й�ȣ �нǽ� �ʿ�) */
	visitCnt int default 0,							/* �湮Ƚ�� */
	startDate datetime default now(),		/* ���� ������ */
	lastDate datetime default now(),		/* ������ ������ */
	level int default 4,								/* 1:Ư��ȸ��, 2:���ȸ��, 3:��ȸ��, 4:��ȸ��, 0:������ */
	todayCnt int default 0,							/* ���� �湮�� Ƚ�� */
	photo varchar(100) default 'noimage.jpg', 	/* ȸ������ */
	primary key(idx, mid)								/* Ű��Ű : ������ȣ, ���̵� */
);

/* drop table member */
desc member;

select * from member;

insert into member values (default,'admin','1234','������','������',default,default,'010-0000-0000','������','admin@admin.com',default,default,default,'0',default,default);