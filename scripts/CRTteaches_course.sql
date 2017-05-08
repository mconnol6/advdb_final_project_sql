create table teaches_course
	(username varchar2(14) not null,
	crn number(10) not null,
	constraint pk_teaches_course primary key(username, crn),
	constraint fk_username_teaches_course foreign key (username) references site_user(username) on delete cascade,
	constraint fk_crn_teaches_course foreign key (crn) references course(crn) on delete cascade);
