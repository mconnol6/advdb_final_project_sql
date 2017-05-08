create or replace package body grader_pack
is
	procedure add_user(un site_user.username%type, e site_user.email%type, fname site_user.first_name%type, lname site_user.last_name%type)
	is
	begin
		insert into site_user (username, email, first_name, last_name) 
			values (un, e, fname, lname);
	end;
	
	procedure add_repo(un repo.username%type, r repo.repo_name%type, p repo.repo_path%type, d repo.description%type)
	is
	id repo.repo_id%type;
	begin
		insert into repo(username, repo_name, repo_path, description)
			values (un, r, p, d);
			select repo_id into id
			from repo
			where repo.repo_path = p;
			add_contributor(id,un);
	end;
	
	procedure add_course(c course.crn%type, cno course.course_no%type, d course.dept%type, cn course.course_name%type, un site_user.username%type)
	is
	begin
		insert into course(crn, course_no, dept, course_name)
			values(c, cno, d, cn);
		add_teaches_course(un, c);
	end;
	
	procedure add_teaches_course(un site_user.username%type, c course.crn%type)
	is
	begin
		insert into teaches_course(username, crn)
			values(un, c);
	end;
	
	procedure add_takes_course(un site_user.username%type, c course.crn%type)
	is
	begin
		insert into takes_course(username, crn)
			values(un, c);
	end;
	
	procedure add_ssh_key(un site_user.username%type, key ssh.ssh_key%type, title ssh.ssh_title%type)
	is
	begin
		insert into ssh(username,ssh_key,ssh_title)
			values(un, key, title);
	end;

	procedure add_assignment(c assignment.crn%type, an assignment.assignment_name%type, d assignment.due_date%type, o assignment.outof%type, w assignment.weight%type)
	is
	begin	
		insert into assignment(crn, assignment_name, due_date, outof, weight)
			values(c, an, d, o, w);
	end;
	
	procedure add_resource(c resources.crn%type, rn resources.resource_name%type)
	is
	begin
		insert into resources(crn, resource_name) values(c, rn);
	end;

	function submission_exists(c submission.crn%type, an submission.assignment_name%type, su submission.student_username%type) 
		return boolean
	is
		cnt number;
	begin
		select count(*) into cnt from submission
			where crn = c
			and assignment_name = an
			and student_username = su;

		if (cnt > 0) then
			return true;
		else
			return false;
		end if;
	end;
	
	procedure add_grade(c submission.crn%type, an submission.assignment_name%type, su submission.student_username%type, tu submission.teacher_username%type, g submission.grade%type, gc submission.grade_comment%type)
	is
	begin
		if (submission_exists(c, an, su)) then
			update submission
				set grade = g, teacher_username = tu, grade_comment = gc
				where student_username = su
				and crn = c and assignment_name = an;
		else
			insert into submission(crn, assignment_name, student_username, teacher_username, grade, grade_comment, repo_id)
				values (c, an, su, tu, g, gc, null);
		end if;
	end;
	
	procedure add_comment(rid comments.repo_id%type, fp comments.file_path%type, cid comments.commenter_id%type, c comments.content%type)
	is
		t comments.timestamp%type;
	begin
		select sysdate into t from dual;
		insert into comments(repo_id, file_path, commenter_id, content, timestamp)
		values(rid, fp, cid, c, t);
	end;
	
	procedure get_user(e site_user.email%type, un out site_user.username%type)
	is
	begin
		select username
		into un
		from site_user
		where email = e;

	exception
		when no_data_found then
			un := null;
	end;
	
	procedure get_repo(i repo.repo_id%type, rn out repo.repo_name%type, su out repo.username%type)
	is
	begin

		select repo_name, username
		into rn, su
		from repo
		where repo_id = i;

	exception
		when no_data_found then
			rn := null;
			su := null;
	end;
	
	procedure get_repo_path(id repo.repo_id%type, rp out repo.repo_path%type)
	is
	begin
		select repo_path
		into rp
		from repo
		where repo_id = id;

	exception
		when no_data_found then
			rp := null;
	end;


	procedure add_contributor(r repo.repo_id%type, u site_user.username%type)
	is
	begin
		insert into contributor(repo_id, username)
			values (r, u);
	end;
	
	procedure link_assignment(u site_user.username%type, r repo.repo_id%type, c course.crn%type, an assignment.assignment_name%type)
	is
	begin
		if (submission_exists(c, an, u)) then
			update submission
				set repo_id = r
				where student_username = u
				and crn = c and assignment_name = an;
		else
			insert into submission(crn, assignment_name, student_username, teacher_username, grade, grade_comment, repo_id)
				values (c, an, u, null, null, null, r);
		end if;
	end;

end grader_pack;
/
