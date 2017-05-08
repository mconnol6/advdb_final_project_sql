create table assignment
	(crn number(10) not null,
	assignment_name varchar(100) not null,
	due_date date,
	outof number(5,2),
	weight number(5,2),
	constraint pk_assigment primary key(crn, assignment_name),
	constraint fk_crn_assignment foreign key (crn) references course(crn) on delete cascade);
