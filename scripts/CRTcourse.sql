create table course
	(crn number(10) not null,
	course_no number(5) not null,
	dept varchar2(5) not null,
	course_name varchar2(100) not null,
	constraint pk_crn primary key (crn));
