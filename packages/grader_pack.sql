create or replace package grader_pack
is
	procedure add_user(un site_user.username%type, e site_user.email%type, fname site_user.first_name%type, lname site_user.last_name%type);
	procedure add_repo(un repo.username%type, r repo.repo_name%type, p repo.repo_path%type, d repo.description%type);
	procedure add_course(c course.crn%type, cno course.course_no%type, d course.dept%type, cn course.course_name%type, un site_user.username%type);
	procedure add_teaches_course(un site_user.username%type, c course.crn%type);
	procedure add_takes_course(un site_user.username%type, c course.crn%type);
	procedure add_assignment(c assignment.crn%type, an assignment.assignment_name%type, d assignment.due_date%type, o assignment.outof%type, w assignment.weight%type);
	procedure add_resource(c resources.crn%type, rn resources.resource_name%type);
	function submission_exists(c submission.crn%type, an submission.assignment_name%type, su submission.student_username%type) 
		return boolean;
	procedure add_grade(c submission.crn%type, an submission.assignment_name%type, su submission.student_username%type, tu submission.teacher_username%type, g submission.grade%type, gc submission.grade_comment%type);
	procedure add_ssh_key(un site_user.username%type, key ssh.ssh_key%type, title ssh.ssh_title%type);	
	procedure add_comment(rid comments.repo_id%type, fp comments.file_path%type, cid comments.commenter_id%type, c comments.content%type);	
	procedure get_user(e site_user.email%type, un out site_user.username%type);
	procedure get_repo(i repo.repo_id%type, rn out repo.repo_name%type, su out repo.username%type);
	procedure get_repo_path(id repo.repo_id%type, rp out repo.repo_path%type);
	procedure add_contributor(r repo.repo_id%type, u site_user.username%type);
	procedure link_assignment(u site_user.username%type, r repo.repo_id%type, c course.crn%type, an assignment.assignment_name%type);
end grader_pack;
/
