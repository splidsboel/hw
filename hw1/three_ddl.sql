CREATE SEQUENCE seq_student_id START 1;
CREATE SEQUENCE seq_semester_id START 1;
CREATE SEQUENCE seq_examiner_id START 1;
CREATE SEQUENCE seq_course_id START 1;

CREATE TABLE Student (
    StudID INT PRIMARY KEY DEFAULT nextval ('seq_student_id'),
    student_name VARCHAR(30) NOT NULL,
    email varchar(50) NOT NULL,
    FOREIGN KEY (SemID) INT REFERENCES Semester(SemID)
);

CREATE TABLE Semester (
    SemID INT PRIMARY KEY DEFAULT nextval ('seq_semester_id'),
    year INT NOT NULL,
    season VARCHAR(10) NOT NULL, 
    CHECK (season IN('Autumn', 'Spring'))
)

CREATE TABLE Course(
    CID INT PRIMARY KEY DEFAULT nextval ('seq_course_id'),
    course_name VARCHAR(30) NOT NULL,
    capacity INT,
    CHECK(capacity<301)
)

CREATE TABLE Examiner(
    
)

drop table Student;

show tables;

pragma table_info;