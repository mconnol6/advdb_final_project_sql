create table takes_course
	(username varchar2(14) not null,
	crn number(10) not null,
	course_grade number(5,2),
	constraint pk_takes_course primary key(username, crn),
	constraint fk_username_takes_course foreign key (username) references site_user(username) on delete cascade,
	constraint fk_crn_takes_course foreign key (crn) references course(crn) on delete cascade);
