create table contributor
	(username varchar2(14) not null,
	repo_id number not null,
	constraint pk_contributor primary key(username, repo_id),
	constraint fk_username_contributor foreign key (username) references site_user(username) on delete cascade,
	constraint fk_repo_contributor foreign key (repo_id) references repo(repo_id) on delete cascade);
	
