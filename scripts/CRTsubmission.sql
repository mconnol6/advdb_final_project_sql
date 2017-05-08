create table submission
	(crn number(10) not null,
	assignment_name varchar2(100) not null,
	student_username varchar2(14) not null,
	teacher_username varchar2(14),
	grade number(5,2),
	grade_comment varchar2(300),
	repo_id number,
	constraint pk_submisison primary key(crn, assignment_name, student_username),
	constraint fk_stud_un_submission foreign key (student_username) references site_user(username) on delete cascade,
	constraint fk_teacher_un_submission foreign key (teacher_username) references site_user(username) on delete set null,
	constraint fk_assign_submission foreign key (crn, assignment_name) references assignment(crn, assignment_name) on delete cascade,
	constraint fk_repo_id_submission foreign key (repo_id) references repo(repo_id) on delete set null);
