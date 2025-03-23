-- ========================================================
-- 1. Create the Database and Switch to It
-- ========================================================
CREATE DATABASE IF NOT EXISTS lms;
USE lms;

-- ========================================================
-- 2. Create Tables for the LMS Schema
-- ========================================================

-- Categories Table
CREATE TABLE IF NOT EXISTS categories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  description TEXT
);

-- Courses Table
CREATE TABLE IF NOT EXISTS courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(255) NOT NULL,
  description TEXT,
  category_id INT,
  created_at DATETIME,
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- User Table
-- "user" is a reserved word, so we enclose it in backticks.
CREATE TABLE IF NOT EXISTS `user` (
  user_id INT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL,
  created_at DATETIME
);

-- Modules Table
CREATE TABLE IF NOT EXISTS modules (
  module_id INT PRIMARY KEY,
  course_id INT,
  module_name VARCHAR(255) NOT NULL,
  module_order INT,
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Content Table
CREATE TABLE IF NOT EXISTS content (
  content_id INT PRIMARY KEY,
  module_id INT,
  title VARCHAR(255) NOT NULL,
  content_type VARCHAR(50),
  url VARCHAR(255),
  FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

-- Assessments Table
CREATE TABLE IF NOT EXISTS assessments (
  assessment_id INT PRIMARY KEY,
  module_id INT,
  assessment_name VARCHAR(255) NOT NULL,
  assessment_type VARCHAR(50),
  max_score INT,
  FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

-- Assessment Submissions Table
CREATE TABLE IF NOT EXISTS assessment_submission (
  submission_id INT PRIMARY KEY,
  assessment_id INT,
  user_id INT,
  submitted_at DATETIME,
  score INT,
  submission_data TEXT,
  FOREIGN KEY (assessment_id) REFERENCES assessments(assessment_id),
  FOREIGN KEY (user_id) REFERENCES `user`(user_id)
);

-- Enrollments Table
CREATE TABLE IF NOT EXISTS enrollments (
  enrollment_id INT PRIMARY KEY,
  course_id INT,
  user_id INT,
  enrolled_at DATETIME,
  FOREIGN KEY (course_id) REFERENCES courses(course_id),
  FOREIGN KEY (user_id) REFERENCES `user`(user_id)
);

-- ========================================================
-- 3. Insert Extended Sample Data into Each Table
-- ========================================================

-- --- Categories ---
INSERT INTO categories (category_id, category_name, description) VALUES
  (1, 'Programming', 'Courses on software development and coding.'),
  (2, 'Mathematics', 'Courses covering various math topics.'),
  (3, 'Science', 'Courses in physics, chemistry, and biology.'),
  (4, 'History', 'Courses exploring world history and events.'),
  (5, 'Literature', 'Courses on literature and creative writing.'),
  (6, 'Business', 'Courses on business management and strategy.'),
  (7, 'Art', 'Courses on art, design, and creative expression.');

-- --- Courses ---
INSERT INTO courses (course_id, course_name, description, category_id, created_at) VALUES
  (1, 'Introduction to Python', 'Learn Python programming from scratch.', 1, '2023-01-15 09:00:00'),
  (2, 'Calculus I', 'Fundamental concepts of calculus.', 2, '2023-02-20 10:30:00'),
  (3, 'Physics 101', 'Basics of classical mechanics.', 3, '2023-03-10 11:00:00'),
  (4, 'World History', 'Explore the major events in world history.', 4, '2023-04-05 14:00:00'),
  (5, 'Creative Writing', 'Develop your creative writing skills.', 5, '2023-04-10 15:00:00'),
  (6, 'Data Structures and Algorithms', 'Learn fundamental data structures and algorithms.', 1, '2023-05-01 08:00:00'),
  (7, 'Business Management', 'Learn the fundamentals of managing a business.', 6, '2023-05-10 09:00:00'),
  (8, 'Digital Marketing', 'Introduction to digital marketing strategies.', 6, '2023-05-12 09:30:00'),
  (9, 'Graphic Design Basics', 'Learn the basics of graphic design.', 7, '2023-05-15 10:00:00'),
  (10, 'Advanced Python', 'Deep dive into advanced Python topics.', 1, '2023-05-18 10:30:00'),
  (11, 'Modern Art History', 'Study the evolution of modern art.', 7, '2023-05-20 11:00:00');

-- --- Users ---
INSERT INTO `user` (user_id, first_name, last_name, email, password, role, created_at) VALUES
  (1, 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashed_password1', 'student', '2023-04-01 08:45:00'),
  (2, 'Bob', 'Smith', 'bob.smith@example.com', 'hashed_password2', 'student', '2023-04-02 09:15:00'),
  (3, 'Carol', 'Williams', 'carol.williams@example.com', 'hashed_password3', 'instructor', '2023-04-03 10:00:00'),
  (4, 'David', 'Brown', 'david.brown@example.com', 'hashed_password4', 'student', '2023-04-04 10:30:00'),
  (5, 'Emily', 'Davis', 'emily.davis@example.com', 'hashed_password5', 'instructor', '2023-04-05 11:00:00'),
  (6, 'Frank', 'Miller', 'frank.miller@example.com', 'hashed_password6', 'student', '2023-04-06 11:30:00'),
  (7, 'Grace', 'Wilson', 'grace.wilson@example.com', 'hashed_password7', 'student', '2023-04-07 12:00:00'),
  (8, 'Henry', 'Taylor', 'henry.taylor@example.com', 'hashed_password8', 'instructor', '2023-04-08 12:30:00'),
  (9, 'Irene', 'Lopez', 'irene.lopez@example.com', 'hashed_password9', 'student', '2023-04-09 09:45:00'),
  (10, 'Jack', 'Martinez', 'jack.martinez@example.com', 'hashed_password10', 'instructor', '2023-04-10 10:00:00'),
  (11, 'Karen', 'Anderson', 'karen.anderson@example.com', 'hashed_password11', 'student', '2023-04-11 10:15:00'),
  (12, 'Leo', 'Thomas', 'leo.thomas@example.com', 'hashed_password12', 'student', '2023-04-12 10:30:00'),
  (13, 'Mia', 'Jackson', 'mia.jackson@example.com', 'hashed_password13', 'instructor', '2023-04-13 10:45:00');

-- --- Modules ---
-- For Course 1: Introduction to Python
INSERT INTO modules (module_id, course_id, module_name, module_order) VALUES
  (1, 1, 'Python Basics', 1),
  (2, 1, 'Data Structures in Python', 2),
  (3, 1, 'Control Structures and Loops', 3),
  (4, 1, 'Functions and Modules', 4),
-- For Course 2: Calculus I
  (5, 2, 'Limits and Continuity', 1),
  (6, 2, 'Derivatives', 2),
  (7, 2, 'Integrals', 3),
-- For Course 3: Physics 101
  (8, 3, 'Newtonian Mechanics', 1),
  (9, 3, 'Thermodynamics', 2),
  (10, 3, 'Waves and Optics', 3),
-- For Course 4: World History
  (11, 4, 'Ancient Civilizations', 1),
  (12, 4, 'Medieval Times', 2),
  (13, 4, 'Modern History', 3),
-- For Course 5: Creative Writing
  (14, 5, 'Introduction to Creative Writing', 1),
  (15, 5, 'Poetry Techniques', 2),
  (16, 5, 'Fiction Writing', 3),
-- For Course 6: Data Structures and Algorithms
  (17, 6, 'Basic Data Structures', 1),
  (18, 6, 'Sorting Algorithms', 2),
  (19, 6, 'Graph Algorithms', 3),
-- For Course 7: Business Management
  (20, 7, 'Introduction to Business', 1),
  (21, 7, 'Business Strategy', 2),
-- For Course 8: Digital Marketing
  (22, 8, 'Basics of Digital Marketing', 1),
  (23, 8, 'SEO and SEM', 2),
-- For Course 9: Graphic Design Basics
  (24, 9, 'Design Principles', 1),
  (25, 9, 'Photoshop Basics', 2),
-- For Course 10: Advanced Python
  (26, 10, 'Advanced Python Concepts', 1),
  (27, 10, 'Python Performance Optimization', 2),
-- For Course 11: Modern Art History
  (28, 11, 'Modern Art Movements', 1),
  (29, 11, 'Contemporary Artists', 2);

-- --- Content ---
INSERT INTO content (content_id, module_id, title, content_type, url) VALUES
  -- Course 1: Introduction to Python
  (1, 1, 'Welcome to Python', 'video', 'http://example.com/python_welcome.mp4'),
  (2, 1, 'Python Installation Guide', 'document', 'http://example.com/python_install.pdf'),
  (3, 2, 'Lists, Tuples, and Sets', 'video', 'http://example.com/python_lists.mp4'),
  (4, 2, 'Dictionaries Explained', 'document', 'http://example.com/python_dict.pdf'),
  (5, 3, 'Loops in Python', 'video', 'http://example.com/python_loops.mp4'),
  (6, 4, 'Defining Functions', 'document', 'http://example.com/python_functions.pdf'),
  (7, 4, 'Modules and Packages', 'video', 'http://example.com/python_modules.mp4'),
  -- Course 2: Calculus I
  (8, 5, 'Understanding Limits', 'video', 'http://example.com/limits_intro.mp4'),
  (9, 5, 'Continuity in Functions', 'document', 'http://example.com/continuity.pdf'),
  (10, 6, 'Derivative Basics', 'video', 'http://example.com/derivatives_intro.mp4'),
  (11, 7, 'Introduction to Integrals', 'document', 'http://example.com/integrals.pdf'),
  -- Course 3: Physics 101
  (12, 8, 'Newton\'s Laws', 'video', 'http://example.com/newton_laws.mp4'),
  (13, 8, 'Friction and Motion', 'document', 'http://example.com/friction.pdf'),
  (14, 9, 'Thermodynamics Basics', 'video', 'http://example.com/thermodynamics.mp4'),
  (15, 10, 'Wave Properties', 'document', 'http://example.com/waves.pdf'),
  -- Course 4: World History
  (16, 11, 'Egyptian Civilization', 'video', 'http://example.com/egypt.mp4'),
  (17, 12, 'Feudal System', 'document', 'http://example.com/feudal.pdf'),
  (18, 13, 'World Wars Overview', 'video', 'http://example.com/worldwars.mp4'),
  -- Course 5: Creative Writing
  (19, 14, 'The Creative Process', 'video', 'http://example.com/creative_process.mp4'),
  (20, 15, 'Understanding Meter', 'document', 'http://example.com/poetry_meter.pdf'),
  (21, 16, 'Storytelling Basics', 'video', 'http://example.com/storytelling.mp4'),
  -- Course 6: Data Structures and Algorithms
  (22, 17, 'Arrays and Lists', 'video', 'http://example.com/arrays.mp4'),
  (23, 17, 'Stacks and Queues', 'document', 'http://example.com/stacks_queues.pdf'),
  (24, 18, 'Bubble Sort', 'video', 'http://example.com/bubble_sort.mp4'),
  (25, 18, 'Quick Sort', 'document', 'http://example.com/quick_sort.pdf'),
  (26, 19, 'Introduction to Graphs', 'video', 'http://example.com/graphs.mp4'),
  (27, 19, 'Dijkstra\'s Algorithm', 'document', 'http://example.com/dijkstra.pdf'),
  -- Course 7: Business Management
  (28, 20, 'Business Overview Video', 'video', 'http://example.com/business_overview.mp4'),
  (29, 20, 'Business Glossary', 'document', 'http://example.com/business_glossary.pdf'),
  (30, 21, 'Strategy Case Studies', 'document', 'http://example.com/strategy_cases.pdf'),
  -- Course 8: Digital Marketing
  (31, 22, 'Digital Marketing Intro', 'video', 'http://example.com/digital_intro.mp4'),
  (32, 23, 'SEO Basics', 'document', 'http://example.com/seo_basics.pdf'),
  -- Course 9: Graphic Design Basics
  (33, 24, 'Elements of Design', 'video', 'http://example.com/design_elements.mp4'),
  (34, 25, 'Photoshop Tutorial', 'document', 'http://example.com/photoshop_tutorial.pdf'),
  -- Course 10: Advanced Python
  (35, 26, 'Advanced Python Techniques', 'video', 'http://example.com/advanced_python.mp4'),
  (36, 27, 'Optimizing Python Code', 'document', 'http://example.com/py_optimize.pdf'),
  -- Course 11: Modern Art History
  (37, 28, 'Modern Art Movements Overview', 'video', 'http://example.com/modern_art.mp4'),
  (38, 29, 'Artist Profiles', 'document', 'http://example.com/artist_profiles.pdf');

-- --- Assessments ---
INSERT INTO assessments (assessment_id, module_id, assessment_name, assessment_type, max_score) VALUES
  -- Course 1 Assessments
  (1, 1, 'Python Basics Quiz', 'quiz', 100),
  (2, 2, 'Data Structures Quiz', 'quiz', 100),
  (3, 4, 'Functions Assignment', 'assignment', 100),
  -- Course 2 Assessments
  (4, 5, 'Limits Test', 'exam', 100),
  (5, 6, 'Derivatives Quiz', 'quiz', 100),
  (6, 7, 'Integrals Assignment', 'assignment', 100),
  -- Course 3 Assessments
  (7, 8, 'Mechanics Quiz', 'quiz', 100),
  (8, 9, 'Thermodynamics Exam', 'exam', 100),
  (9, 10, 'Waves Test', 'exam', 100),
  -- Course 4 Assessments
  (10, 11, 'Civilizations Quiz', 'quiz', 100),
  (11, 12, 'Feudal System Assignment', 'assignment', 100),
  (12, 13, 'Modern History Exam', 'exam', 100),
  -- Course 5 Assessments
  (13, 14, 'Creative Writing Quiz', 'quiz', 100),
  (14, 15, 'Poetry Analysis', 'assignment', 100),
  (15, 16, 'Fiction Story Assignment', 'assignment', 100),
  -- Course 6 Assessments
  (16, 17, 'Data Structures Quiz', 'quiz', 100),
  (17, 18, 'Sorting Algorithms Test', 'exam', 100),
  (18, 19, 'Graph Algorithms Assignment', 'assignment', 100),
  -- Course 7 Assessments
  (19, 20, 'Business Intro Quiz', 'quiz', 100),
  (20, 21, 'Business Strategy Assignment', 'assignment', 100),
  -- Course 8 Assessments
  (21, 22, 'Digital Marketing Quiz', 'quiz', 100),
  (22, 23, 'SEO Test', 'exam', 100),
  -- Course 9 Assessments
  (23, 24, 'Design Principles Quiz', 'quiz', 100),
  (24, 25, 'Photoshop Basics Assignment', 'assignment', 100),
  -- Course 10 Assessments
  (25, 26, 'Advanced Python Quiz', 'quiz', 100),
  (26, 27, 'Performance Optimization Test', 'exam', 100),
  -- Course 11 Assessments
  (27, 28, 'Modern Art Quiz', 'quiz', 100),
  (28, 29, 'Contemporary Artists Assignment', 'assignment', 100);

-- --- Assessment Submissions ---
INSERT INTO assessment_submission (submission_id, assessment_id, user_id, submitted_at, score, submission_data) VALUES
  -- Course 1 Submissions
  (1, 1, 1, '2023-05-05 10:00:00', 90, 'Quiz answers for Python Basics'),
  (2, 2, 1, '2023-05-06 11:00:00', 85, 'Quiz answers for Data Structures'),
  (3, 3, 1, '2023-05-07 09:30:00', 92, 'Assignment submission for Functions'),
  -- Course 2 Submissions
  (4, 4, 2, '2023-05-05 12:00:00', 88, 'Exam answers for Limits'),
  (5, 5, 2, '2023-05-06 14:00:00', 80, 'Quiz submission for Derivatives'),
  (6, 6, 3, '2023-05-07 15:00:00', 95, 'Assignment submission for Integrals'),
  -- Course 3 Submissions
  (7, 7, 4, '2023-05-08 10:30:00', 89, 'Quiz answers for Mechanics'),
  (8, 8, 4, '2023-05-08 12:00:00', 93, 'Exam answers for Thermodynamics'),
  (9, 9, 5, '2023-05-09 09:00:00', 87, 'Test answers for Waves'),
  -- Course 4 Submissions
  (10, 10, 6, '2023-05-10 11:00:00', 90, 'Quiz answers for Civilizations'),
  (11, 11, 7, '2023-05-11 10:00:00', 85, 'Assignment submission for Feudal System'),
  (12, 12, 7, '2023-05-11 12:00:00', 88, 'Exam submission for Modern History'),
  -- Course 5 Submissions
  (13, 13, 2, '2023-05-12 14:00:00', 92, 'Quiz answers for Creative Writing'),
  (14, 14, 3, '2023-05-13 09:30:00', 90, 'Assignment submission for Poetry Analysis'),
  (15, 15, 4, '2023-05-14 10:00:00', 87, 'Assignment submission for Fiction Story'),
  -- Course 6 Submissions
  (16, 16, 5, '2023-05-15 11:30:00', 95, 'Quiz answers for Data Structures'),
  (17, 17, 6, '2023-05-16 12:00:00', 89, 'Exam submission for Sorting Algorithms'),
  (18, 18, 7, '2023-05-17 14:30:00', 93, 'Assignment submission for Graph Algorithms'),
  -- Course 7 Submissions
  (19, 19, 9, '2023-05-18 10:00:00', 92, 'Quiz answers for Business Intro'),
  (20, 20, 11, '2023-05-19 11:00:00', 88, 'Assignment submission for Business Strategy'),
  -- Course 8 Submissions
  (21, 21, 12, '2023-05-20 09:30:00', 90, 'Quiz answers for Digital Marketing'),
  (22, 22, 13, '2023-05-21 12:00:00', 85, 'Exam submission for SEO'),
  -- Course 9 Submissions
  (23, 23, 2, '2023-05-22 14:00:00', 87, 'Quiz answers for Design Principles'),
  (24, 24, 3, '2023-05-23 10:30:00', 91, 'Assignment submission for Photoshop Basics'),
  -- Course 10 Submissions
  (25, 25, 4, '2023-05-24 11:00:00', 93, 'Quiz answers for Advanced Python'),
  (26, 26, 5, '2023-05-25 12:30:00', 89, 'Exam submission for Performance Optimization'),
  -- Course 11 Submissions
  (27, 27, 6, '2023-05-26 09:00:00', 90, 'Quiz answers for Modern Art'),
  (28, 28, 7, '2023-05-27 10:00:00', 88, 'Assignment submission for Contemporary Artists');

-- --- Enrollments ---
INSERT INTO enrollments (enrollment_id, course_id, user_id, enrolled_at) VALUES
  -- Original enrollments
  (1, 1, 1, '2023-04-10 09:00:00'),
  (2, 2, 1, '2023-04-11 09:15:00'),
  (3, 3, 1, '2023-04-12 09:30:00'),
  (4, 4, 2, '2023-04-13 10:00:00'),
  (5, 5, 2, '2023-04-14 10:15:00'),
  (6, 6, 2, '2023-04-15 10:30:00'),
  (7, 1, 3, '2023-04-16 11:00:00'),
  (8, 2, 4, '2023-04-17 11:15:00'),
  (9, 3, 5, '2023-04-18 11:30:00'),
  (10, 4, 6, '2023-04-19 12:00:00'),
  (11, 5, 7, '2023-04-20 12:15:00'),
  (12, 6, 8, '2023-04-21 12:30:00'),
  (13, 1, 8, '2023-04-22 12:45:00'),
  (14, 3, 7, '2023-04-23 13:00:00'),
  (15, 2, 6, '2023-04-24 13:15:00'),
  -- New enrollments for added courses and users
  (16, 7, 9, '2023-04-25 09:00:00'),
  (17, 7, 10, '2023-04-26 09:15:00'),
  (18, 8, 11, '2023-04-27 09:30:00'),
  (19, 8, 12, '2023-04-28 09:45:00'),
  (20, 9, 13, '2023-04-29 10:00:00'),
  (21, 10, 1, '2023-04-30 10:15:00'),
  (22, 10, 2, '2023-05-01 10:30:00'),
  (23, 11, 3, '2023-05-02 10:45:00'),
  (24, 11, 4, '2023-05-03 11:00:00');
