select * from
(
select t.username, t.crn
from teaches_course t
where t.username = 'mconnol6'
and t.crn = '8989'
)
union
(
select t.username, t.crn
from takes_course t
where t.username = 'mconnol6'
and t.crn = '8989'
);
