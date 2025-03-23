#List All Courses with Their Category Names
/*Question 1: Retrieve a list of courses along with the name of the category
 to which each course belongs*/
 
SELECT c.course_name, cat.category_name
FROM courses c
INNER JOIN categories cat ON c.category_id = cat.category_id;

#Found Number of Courses in Each Category

/*Question 2: For each category, count how many courses exist*/

SELECT cat.category_name, count(c.course_id) 
As Total_Course
FROM categories as cat INNER JOIN courses as c 
on cat.category_id=c.category_id
GROUP BY category_name;

/*Question 3: Retrieve the full names and email addresses
 for all users with the role 'student. '*/
 
SELECT concat(first_name," ",last_name) AS Full_Name,email
FROM user
WHERE role='student';

/*Question 4: For a given course (e.g., course_id = 1),
 list its modules sorted by their order*/
select course_id, module_id,module_order,
module_name from modules
where course_id=1
order by module_order;

/*Question 5: Retrieve all content items for a specific 
module (for example, module_id = 2)*/
select * from content as c 
where module_id=2;

/*Question 6: Calculate the average score of submissions 
for a given assessment (e.g., assessment_id = 1)*/

SELECT avg(score) as average_score,submission_id,assessment_id,
submission_data
FROM assessment_submission
WHERE assessment_id=1
GROUP BY submission_id,assessment_id,
submission_data;

/*Question 7: Retrieve a list of enrollments that shows
 the student’s full name, the course name, and the enrollment date*/

SELECT e.enrollment_id,
concat(u.first_name," ",u.last_name) AS Student_Full_Name,
c.course_name,
e.enrolled_at
FROM enrollments as e INNER JOIN courses as c INNER JOIN user as u
ON e.course_id=c.course_id AND e.user_id=u.user_id
where u.role='student';

 /*Question 8: List the full names and email addresses of
 all users with the role 'instructor'*/
 SELECT concat(first_name," ",last_name) AS Full_Name,
 email FROM user
 where role ='instructor';
 
 /*Question 9: For each assessment, count how many submissions have been made*/

 SELECT assessment_id, COUNT(submission_id) AS submission_count
 FROM assessment_submission
 GROUP BY assessment_id;
 
 /*Question 10: Retrieve, for each assessment, 
 the submission that achieved the highest score*/
 
 SELECT submission_id,assessment_id,max(score) AS Maximum_Score
 FROM assessment_submission 
 GROUP BY assessment_id,submission_id;
 
 /*Question 11: List courses that were created after '2023-04-01'*/
 
 SELECT course_id,course_name,created_at 
 FROM courses 
 WHERE created_at >'2023-04-01';
 
 /*Question 12: Retrieve a list of students 
 who do not have any records in the assessment_submission table*/

SELECT u.user_id, u.first_name, u.last_name
FROM user as u
LEFT JOIN assessment_submission as a ON u.user_id = a.user_id
WHERE u.role = 'student' and a.submission_id IS NULL;

/*note we dont have users dont submit assessment 
so the output is nothing just a column names*/

/*Question 13: Retrieve all content items for 
courses whose category is 'Programming'*/

select c.course_name,cat.category_name,
co.content_id,co.content_type from content as co
inner join courses as c inner join categories as cat
on c.course_id=co.content_id and c.category_id=cat.category_id
where cat.category_name='Programming';
 
 
/*Question 14: List modules that do not have any content items linked to them*/

SELECT m.module_id, m.module_name
FROM modules m
LEFT JOIN content c ON m.module_id = c.module_id
WHERE c.content_id IS NULL;

/*Question 15: For each course, display the course name along with the count of enrollments*/

SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

/*Question 16: Calculate the average score of all assessment submissions 
for each course by joining courses, modules, assessments, and submissions*/

SELECT c.course_name, AVG(s.score) AS avg_score
FROM assessment_submission as s
INNER JOIN assessments as a ON a.assessment_id = s.assessment_id
INNER JOIN modules as m ON a.module_id = m.module_id
INNER JOIN courses as c ON m.course_id = c.course_id
GROUP BY c.course_name;

/*Question 17: Retrieve a list of all users along with the count of courses they are enrolled in*/

SELECT u.user_id,concat(u.first_name," ",u.last_name) as Full_Name,
COUNT(e.course_id) AS Course_Count
FROM user as u INNER JOIN enrollments as e
ON u.user_id=e.user_id
GROUP BY u.user_id;

/*Question 18: Identify the assessment that has the highest average submission score*/
SELECT assessment_id, AVG(score) AS avg_score
FROM assessment_submission
GROUP BY assessment_id
ORDER BY avg_score DESC
LIMIT 1;

/*Question 19: Retrieve a hierarchical list that shows each course, 
its modules, and the content items within each module*/

SELECT c.course_name, m.module_name,m.module_id,
co.title,co.content_id,co.content_type,co.url
FROM courses c
LEFT JOIN modules m ON c.course_id = m.course_id
LEFT JOIN content co ON m.module_id = co.module_id
ORDER BY c.course_name, m.module_order,m.module_id;

/*Question 20: For each course, count the 
total number of assessments available 
by joining courses, modules, and assessments*/

SELECT c.course_id,c.course_name,count(a.assessment_id) as Total_Courses
FROM courses as c INNER JOIN modules as m INNER JOIN assessments as a 
ON c.course_id=m.course_id AND m.module_id=a.module_id
GROUP BY c.course_id,c.course_name;

/*Question 21: Retrieve all enrollment records where the enrollment date falls within May 2023*/

SELECT * FROM enrollments
WHERE enrolled_at BETWEEN '2023-05-01' AND '2023-05-31';

 /*Question 22: For each assessment submission, 
 display the submission details along 
 with the corresponding course name, 
 student name, and assessment name*/
 
SELECT a.submission_id,a.assessment_id,a.user_id,
a.submitted_at,a.score,a.submission_data, 
u.first_name, u.last_name, c.course_name, asmt.assessment_name
FROM assessment_submission as a
INNER JOIN user as u ON a.user_id = u.user_id
INNER JOIN assessments as asmt ON a.assessment_id = asmt.assessment_id
INNER JOIN modules as m ON asmt.module_id = m.module_id
INNER JOIN courses as c ON m.course_id = c.course_id
where u.role ='student';

/*Question 23: Retrieve a list of all users showing their full names and roles*/

SELECT concat(first_name," ",last_name) AS Full_Name,
role FROM user;

/*Question 24: Assuming a passing score is 60 or above, 
calculate the passing percentage for each assessment*/

SELECT assessment_id,
       (SUM(CASE WHEN score >= 60 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS passing_percentage
FROM assessment_submission
GROUP BY assessment_id;

/*we got 100 percentage because all assessment score is greater
than 60 which means all people got passing persentage*/ 

/*Question 25: List the courses for which there are no enrollment records*/

SELECT c.course_id,c.course_name FROM courses AS c
LEFT JOIN enrollments AS e 
ON c.course_id=e.course_id
WHERE enrollment_id IS NULL;

/*Note: all the courses is enrolled so we dont 
receive any output*/

