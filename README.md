# LMS CASE STUDY
 Analysed LMS database solved the Questions

#Learning Management System (LMS) SQL Queries

#Overview

This repository contains SQL queries for various data retrieval tasks in a Learning Management System (LMS). The queries cover a wide range of operations, including listing courses, retrieving student and instructor details, analyzing assessments, and managing enrollments.

#Database Schema

The queries assume the following key tables exist in the LMS database:

courses - Stores course details.

categories - Stores course categories.

modules - Stores course modules.

content - Stores module content.

user - Stores user details (students, instructors, admins, etc.).

enrollments - Manages student enrollments in courses.

assessments - Stores assessment details.

assessment_submission - Stores student submissions for assessments.

#SQL Queries Included

List All Courses with Their Category Names

Count the Number of Courses in Each Category

List All Students' Full Names and Email Addresses

Retrieve All Modules for a Specific Course Sorted by Module Order

List All Content Items for a Specific Module

Find the Average Score for a Specific Assessment

List All Enrollments with Student Names and Course Names

Retrieve All Instructors’ Full Names

Count the Number of Assessment Submissions per Assessment

List the Top Scoring Submission for Each Assessment

Retrieve Courses Created After a Specific Date

Find Students Who Have Not Submitted Any Assessments

List the Content for Courses in the 'Programming' Category

Retrieve Modules That Have No Associated Content

List Courses with the Total Number of Enrollments

Find the Average Assessment Submission Score for Each Course

List Users with Their Number of Enrollments

Find the Assessment with the Highest Average Score

List Courses Along with Their Modules and Content in Hierarchical Order

Find the Total Number of Assessments Per Course

List All Enrollments from May 2023

Retrieve Assessment Submission Details Along with Course and Student Information

List All Users with Their Roles

Find the Percentage of Passing Submissions for Each Assessment

Find Courses That Do Not Have Any Enrollments

#Usage

#To run these queries:

Ensure you have a MySQL-compatible database set up with the required schema.

Use a database client (such as MySQL Workbench, PostgreSQL, or SQL Server Management Studio) to execute the queries.

Modify WHERE conditions as needed to filter by specific values.

#Contribution

Feel free to contribute by improving queries, optimizing performance, or adding new queries as needed. Submit a pull request with your changes!

#License

This project is open-source and available for personal and educational use.

https://www.linkedin.com/in/sathyabalakrishnan05