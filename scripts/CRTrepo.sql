create table repo
	(repo_id number not null,
	username varchar2(14) not null,
	repo_name varchar2(50) not null,
	repo_path varchar2(100) not null,
	description varchar(300) null,
	constraint pk_repo primary key(repo_id),
	constraint fk_username_repo foreign key (username) references site_user(username) on delete set null);
