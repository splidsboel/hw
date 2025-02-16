CREATE SEQUENCE seq_student_id START 1;
CREATE SEQUENCE seq_semester_id START 1;
CREATE SEQUENCE seq_examiner_id START 1;
CREATE SEQUENCE seq_course_id START 1;

--entities
CREATE TABLE Student (
    StudID INT PRIMARY KEY DEFAULT nextval ('seq_student_id'),
    student_name VARCHAR(30) NOT NULL,
    student_email varchar(50) NOT NULL UNIQUE
);

CREATE TABLE Semester (
    SemID INT PRIMARY KEY DEFAULT nextval ('seq_semester_id'),
    year INT NOT NULL,
    season VARCHAR(10) NOT NULL, 
    CHECK (season IN('Autumn', 'Spring'))
);

CREATE TABLE Course(
    CID INT PRIMARY KEY DEFAULT nextval ('seq_course_id'),
    course_name VARCHAR(30) NOT NULL,
    capacity INT,
    CHECK(capacity<301)
);

CREATE TABLE Examiner(
    EID INT PRIMARY KEY DEFAULT nextval ('seq_examiner_id'),
    examiner_name varchar(30) not NULL,
    examiner_email varchar(50) not NULL UNIQUE
);

---relationships
CREATE TABLE takes(
    StudID INT not null,
    CID INT not null,
    SemID INT not null,
    room VARCHAR(100),
    PRIMARY KEY (StudID, CID, SemID),
    FOREIGN KEY (StudID) REFERENCES Student(StudID),
    FOREIGN KEY (CID) REFERENCES Course(CID),
    FOREIGN KEY (SemID) REFERENCES Semester(SemID)
);

CREATE TABLE grades(
    StudID INT not null,
    CID INT not null,
    SemID INT not null,
    EID INT not null,
    grade varchar(30),
    PRIMARY KEY (StudID, CID, SemID, EID),
    FOREIGN KEY (StudID, CID, SemID) REFERENCES takes(StudID, CID, SemID),
    FOREIGN KEY (EID) REFERENCES Examiner(EID)
);

CREATE TABLE starts_in(
    SemID INT not null,
    StudID INT not null,
    PRIMARY KEY (SemID, StudID),
    FOREIGN KEY (StudID) REFERENCES Student(StudID),
    FOREIGN KEY (SemID) REFERENCES Semester(SemID)
);
