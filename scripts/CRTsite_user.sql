create table site_user
	(username varchar2(14) not null,
	email varchar(30) not null,
	first_name varchar2(14) not null,
	last_name varchar2(14) not null,
	constraint pk_username primary key (username));
