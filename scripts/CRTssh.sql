create table ssh
	(username varchar2(14) not null,
	ssh_key varchar(500),
	ssh_title varchar(30),
	constraint fk_username_ssh foreign key (username) references site_user(username) on delete cascade);
