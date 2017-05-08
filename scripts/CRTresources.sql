create table resources
	(crn number(10) not null,
	resource_name varchar(100) not null,
	constraint pk_resource primary key(crn, resource_name),
	constraint fk_crn_resource foreign key (crn) references course(crn) on delete cascade);
