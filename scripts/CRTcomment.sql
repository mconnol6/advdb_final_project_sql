create table comments
	(comment_id number not null,
	repo_id number not null,
	file_path varchar2(300) not null,
	commenter_id varchar2(14) not null,
	content varchar2(300) not null,
	timestamp date not null,
	response varchar2(1000) null,
	resolved number(1) default 0 not null,
	constraint pk_comment primary key(comment_id),
	constraint fk_commentor_comments foreign key (commenter_id) references site_user(username) on delete set null,
	constraint fk_repo_comments foreign key (repo_id) references repo(repo_id) on delete cascade);
	
