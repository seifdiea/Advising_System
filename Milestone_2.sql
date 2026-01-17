
CREATE DATABASE Advising_Team_77;

GO


use Advising_Team_77;
GO

CREATE PROC CreateAllTables
AS
BEGIN

CREATE TABLE Advisor (
    advisor_id INT IDENTITY(5000,1) PRIMARY KEY,
    name VARCHAR(40),
    email VARCHAR(40) UNIQUE,
    office VARCHAR(40),
    password VARCHAR(40)
);

CREATE TABLE Student (
    student_id INT IDENTITY(10000,1) PRIMARY KEY,
    f_name VARCHAR(40),
    l_name VARCHAR(40),
    gpa DECIMAL(3, 2),
    faculty VARCHAR(40),
    email VARCHAR(40) UNIQUE NOT NULL,
    major VARCHAR(40),
    password VARCHAR(40) NOT NULL,
    financial_status AS dbo.financial_status_derived(student_id),
    semester INT,
    acquired_hours INT NOT NULL,
    assigned_hours INT,
    advisor_id INT,
    FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
    CONSTRAINT assigned_hours_limit CHECK(assigned_hours<35),
    CONSTRAINT gpa_bounds CHECK(gpa>=0.7 AND gpa<=5),
    CONSTRAINT acquired_hours_lower_bound CHECK(acquired_hours>=34)
);


CREATE TABLE STUDENT_PHONE (
    student_id INT, 
    phone_number VARCHAR(40),
    PRIMARY KEY (phone_number, student_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE Course (
    course_id INT IDENTITY(2000,1) PRIMARY KEY, 
    name VARCHAR(40), 
    major VARCHAR(40), 
    is_offered BIT,
    credit_hours INT,
    semester INT
);

CREATE TABLE PreqCourse_course (
    prerequisite_course_id INT,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id) ,
    FOREIGN KEY (prerequisite_course_id) REFERENCES Course(course_id),
    CONSTRAINT not_equal CHECK (course_id <> prerequisite_course_id),
    PRIMARY KEY (prerequisite_course_id, course_id)
);


CREATE TABLE Instructor(
    instructor_id INT IDENTITY(3000,1) PRIMARY KEY,
    name VARCHAR(40), 
    email VARCHAR(40) UNIQUE NOT NULL, 
    faculty VARCHAR(40), 
    office VARCHAR(40)
);

CREATE TABLE Instructor_Course (
    course_id INT,
    instructor_id INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id),
    PRIMARY KEY (course_id, instructor_id)
);

CREATE TABLE Student_Instructor_Course_Take (
    student_id INT,
    course_id INT,
    instructor_id INT,
    semester_code VARCHAR(40),
    exam_type VARCHAR(40) DEFAULT 'Normal',
    grade VARCHAR(40) DEFAULT NULL,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id),
    PRIMARY KEY (student_id, course_id, semester_code),
    CHECK(exam_type IN('Normal', 'First_makeup','Second_makeup'))
);

CREATE TABLE Semester (
    semester_code VARCHAR(40) PRIMARY KEY,
    start_date DATE,
    end_date DATE
);

CREATE TABLE Course_Semester (
    course_id INT,
    semester_code VARCHAR(40),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (semester_code) REFERENCES Semester(semester_code),
    PRIMARY KEY (course_id, semester_code)
);


CREATE TABLE Slot (
    slot_id INT IDENTITY(1,1) PRIMARY KEY,
    day VARCHAR(40),
    time VARCHAR(40),
    location VARCHAR(40),
    course_id INT,
    instructor_id INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

CREATE TABLE Graduation_Plan (
    plan_id int IDENTITY(80000,1),
    semester_code varchar(40),
    semester_credit_hours int,
    expected_grad_date date,
    advisor_id int,
    student_id int,
    PRIMARY KEY (plan_id, semester_code),
    FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE GradPlan_Course (
    plan_id int,
    semester_code varchar(40),
    course_id int,
    PRIMARY KEY (plan_id, semester_code, course_id),
    FOREIGN KEY (plan_id) REFERENCES Graduation_Plan(plan_id),
    FOREIGN KEY (semester_code) REFERENCES Graduation_Plan(semester_code)
);

CREATE TABLE Request (
    request_id int IDENTITY(7000,1) PRIMARY KEY,
    type varchar(40),
    comment varchar(40),
    status varchar(40) DEFAULT 'pending',
    credit_hours int,
    student_id int,
    advisor_id int,
    course_id int,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    CHECK (status IN ('pending', 'accepted', 'rejected'))
);

CREATE TABLE MakeUp_Exam (
    exam_id int PRIMARY KEY IDENTITY(1,1),
    date datetime,
    type varchar(40) DEFAULT 'Normal',
    course_id int,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    CHECK (type IN ('Normal', 'First_makeup','Second_makeup'))
);

CREATE TABLE Exam_Student (
    exam_id int,
    student_id int,
    course_id int,
    PRIMARY KEY (exam_id, student_id),
    FOREIGN KEY (exam_id) REFERENCES MakeUp_Exam(exam_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Payment (
    payment_id int PRIMARY KEY,
    amount int,
    deadline datetime,
    n_installments INT DEFAULT 0,
    status varchar(40) DEFAULT 'notPaid',
    fund_percentage decimal,
    start_date datetime,
    student_id int,
    semester_code varchar(40),
    CHECK(status IN ('Paid', 'notPaid') ),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (semester_code) REFERENCES Semester(semester_code),
    Constraint con_n_installments CHECK (n_installments = DATEDIFF(MONTH, start_date, deadline))
);

CREATE TABLE Installment (
    payment_id int,
    deadline datetime,
    amount int,
    status varchar(40) DEFAULT 'notPaid',
    start_date datetime,
    CHECK(status IN ('Paid', 'notPaid') ),
    PRIMARY KEY (payment_id, deadline),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
);
END
GO


CREATE PROC DropALLTables
AS

DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Student_Phone;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS PreqCourse_course;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS Instructor_Course;
DROP TABLE IF EXISTS Student_Instructor_Course_Take;
DROP TABLE IF EXISTS Semester;
DROP TABLE IF EXISTS Course_Semester;
DROP TABLE IF EXISTS Advisor;
DROP TABLE IF EXISTS Slot;
DROP TABLE IF EXISTS Graduation_Plan;
DROP TABLE IF EXISTS GradPlan_Course;
DROP TABLE IF EXISTS Request;
DROP TABLE IF EXISTS MakeUp_Exam;
DROP TABLE IF EXISTS Exam_Student;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Installment;

GO
CREATE PROC clearAllTables
AS

TRUNCATE TABLE Student;
TRUNCATE TABLE Student_Phone;
TRUNCATE TABLE Course;
TRUNCATE TABLE PreqCourse_course;
TRUNCATE TABLE Instructor;
TRUNCATE TABLE Instructor_Course;
TRUNCATE TABLE Student_Instructor_Course_Take;
TRUNCATE TABLE Semester;
TRUNCATE TABLE Course_Semester;
TRUNCATE TABLE Advisor;
TRUNCATE TABLE Slot;
TRUNCATE TABLE Graduation_Plan;
TRUNCATE TABLE GradPlan_Course;
TRUNCATE TABLE Request;
TRUNCATE TABLE MakeUp_Exam;
TRUNCATE TABLE Exam_Student;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Installment;

GO

CREATE VIEW view_Students
AS

SELECT *
FROM Student 

GO

CREATE VIEW view_Course_prerequisites
AS

SELECT c1.*, c2.*
FROM ((Course c1 LEFT JOIN PreqCourse_course pc ON c1.course_id = pc.course_id)
    LEFT JOIN Course c2 on c2.course_id = pc.prerequisite_course_id)

GO

CREATE VIEW Instructors_AssignedCourses
AS

SELECT i.*, c.*
FROM ((Instructor i LEFT JOIN Instructor_Course ic on i.instructor_id = ic.instructor_id)
    LEFT JOIN Course c on c.course_id = ic.course_id)
GO

CREATE VIEW Student_Payment
AS

SELECT p.*, s.f_name, s.l_name, s.faculty, s.email, s.major, s.financial_status, s.semester, s.acquired_hours,s.assigned_hours 
FROM Payment p INNER JOIN Student s ON p.student_id = s.student_id

GO

CREATE VIEW Courses_Slots_Instructor
AS

SELECT s.course_id as 'CourseID', c.name AS 'Course.name', s.slot_id AS 'Slot ID' , s.day 'Slot Day' , s.time AS 'Slot Time',
s.location AS 'Slot Location' , s.instructor_id , i.name AS 'Slot s Instructor name'
FROM (Slot s RIGHT JOIN Course c ON c.course_id = s.course_id) LEFT JOIN Instructor i ON i.instructor_id = s.instructor_id

GO

CREATE VIEW Courses_MakeupExams
AS

SELECT c.name AS 'Course’s name', c.semester AS 'Course’s semester', CONCAT(m.type,' exam with an exam id ', m.exam_id, ' on ', m.date) AS 'MakeUp_Exam details'
FROM Course C INNER JOIN MakeUp_Exam m ON c.course_id = m.course_id

GO

CREATE VIEW Students_Courses_transcript
AS

SELECT sict.student_id AS 'Student id', s.f_name AS 'student name', sict.course_id AS 'course id', c.name AS 'course name',
       sict.exam_type AS 'exam type', sict.grade AS 'course grade', sict.semester_code AS 'semester', i.name AS 'Instructor’s name'
FROM (((Student s LEFT JOIN Student_Instructor_Course_Take sict ON s.student_id = sict.student_id)
    LEFT JOIN Course c ON c.course_id = sict.course_id) LEFT JOIN Instructor i ON i.instructor_id = sict.instructor_id)

GO

CREATE VIEW Semster_offered_Courses
AS

SELECT c.course_id AS 'Course id', c.name AS 'Course name', cs.semester_code AS 'Semester Code'
FROM ((Course_Semester cs INNER JOIN Course c ON c.course_id = cs.course_id)
    INNER JOIN Semester s ON s.semester_code = cs.semester_code)


GO

CREATE VIEW Advisors_Graduation_Plan
AS

SELECT CONCAT(' Plan ID:', gp.plan_id,
         ', Semester Code:', gp.semester_code,
         ', Semester Credit Hours:', gp.semester_credit_hours,
         ', Expected Graduation Date:', gp.expected_grad_date,
         ', Student ID:', gp.student_id) AS 'Graduation Plan Details', a.advisor_id AS 'Advisor id', a.name AS 'Advisor name'
FROM Graduation_Plan gp INNER JOIN advisor a ON gp.advisor_id = a.advisor_id

Go

CREATE PROCEDURE Procedures_StudentRegistration
    @first_name VARCHAR(40),
    @last_name VARCHAR(40),
    @password VARCHAR(40),
    @faculty VARCHAR(40),
    @email VARCHAR(40),
    @major VARCHAR(40),
    @semester INT,
    @student_id INT OUTPUT
AS

    INSERT INTO Student (
        f_name,
        l_name,
        password,
        faculty,
        email,
        major,
        semester
    )
    VALUES (
        @first_name,
        @last_name,
        @password,
        @faculty,
        @email,
        @major,
        @semester
    );

    SET @student_id = SCOPE_IDENTITY();
    SELECT @student_id

GO

CREATE PROCEDURE Procedures_AdvisorRegistration
    @advisor_name VARCHAR(40),
    @password VARCHAR(40),
    @email VARCHAR(40),
    @office VARCHAR(40),
    @advisor_id INT OUTPUT
AS

    INSERT INTO Advisor (
        name,
        password,
        email,
        office
    )
    VALUES (
        @advisor_name,
        @password,
        @email,
        @office
    );

    SET @advisor_id = SCOPE_IDENTITY();
    SELECT @advisor_id;
   
GO


CREATE PROCEDURE Procedures_AdminListStudents

AS

SELECT *
FROM Student

GO


CREATE PROCEDURE Procedures_AdminListAdvisors


AS

SELECT *
From Advisor

GO

CREATE PROCEDURE AdminListStudentsWithAdvisors

AS

SELECT s.*, a.name, a.email, a.office, a.password
FROM Student s LEFT JOIN Advisor a ON s.advisor_id = a.advisor_id

GO

CREATE PROCEDURE AdminAddingSemester
    @semester_code VARCHAR(40),
    @start_date DATE,
    @end_date DATE
AS

    INSERT INTO Semester (
        semester_code,
        start_date,
        end_date
    )
    VALUES (
        @semester_code,
        @start_date,
        @end_date
    );

GO


CREATE PROCEDURE Procedures_AdminAddingCourse
    @course_name VARCHAR(40),
    @major VARCHAR(40),
    @offered BIT,
    @credit_hours INT,
    @semester INT
AS

    INSERT INTO Course (
        name,
        major,
        is_offered,
        credit_hours,
        semester
    )
    VALUES (
        @course_name,
        @major,
        @offered,
        @credit_hours,
        @semester
    );

GO


CREATE PROCEDURE Procedures_AdminLinkInstructor
    @InstructorId INT,
    @CourseId INT,
    @SlotId INT
AS
BEGIN
    INSERT INTO Instructor_Course VALUES(@CourseId, @InstructorId);

    UPDATE Slot
    SET instructor_id = @InstructorId, course_id = @CourseId
    WHERE slot_id = @SlotId

END

GO

CREATE PROCEDURE Procedures_AdminLinkStudent
    @InstructorId INT,
    @StudentId INT,
    @CourseId INT,
    @SemesterCode VARCHAR(40)
AS
BEGIN
    INSERT INTO Student_Instructor_Course_Take(student_id, course_id, instructor_id, semester_code)
    VALUES (@StudentId, @CourseId, @InstructorId, @SemesterCode)
END

GO

CREATE PROCEDURE Procedures_AdminLinkStudentToAdvisor
    @StudentID INT,
    @AdvisorID INT
AS
BEGIN
    UPDATE Student
    SET advisor_id = @AdvisorID
    WHERE student_id = @StudentID
END

GO

CREATE PROCEDURE Procedures_AdminAddExam
    @Type VARCHAR(40),
    @Date DATETIME,
    @CourseID INT
AS
BEGIN
    INSERT INTO MakeUp_Exam (type, date, course_id)
    VALUES (@Type, @Date, @CourseID)
END

GO

CREATE PROCEDURE Procedures_AdminIssueInstallment
    @PaymentId INT
AS
BEGIN
    -- Declare variables
    DECLARE @InstallmentCount INT
    DECLARE @InstallmentAmount DECIMAL
    DECLARE @PaymentAmount DECIMAL
    DECLARE @PaymentDeadline DATETIME
    DECLARE @nextStartDate DATETIME

    -- Get payment details
    SELECT @InstallmentCount = n_installments,
           @PaymentAmount = amount,
           @PaymentDeadline = deadline,
           @nextStartDate = start_date
    FROM Payment
    WHERE payment_id = @PaymentId

    -- Calculate installment amount
    SET @InstallmentAmount = @PaymentAmount / @InstallmentCount

    -- Generate installments
    DECLARE @InstallmentNumber INT = 1

    WHILE @InstallmentNumber <= @InstallmentCount
    BEGIN
        -- Calculate installment deadline based on the number of months between start date and deadline
        DECLARE @InstallmentDeadline DATETIME = DATEADD(MONTH, 1, @nextStartDate)

        -- Insert installment record
        INSERT INTO Installment (payment_id, deadline, amount, status, start_date)
        VALUES (@PaymentId, @InstallmentDeadline, @InstallmentAmount, 'not paid', @nextStartDate)

        SET @InstallmentNumber = @InstallmentNumber + 1
        SET @nextStartDate = DATEADD(MONTH, 1, @nextStartDate)
    END
END

GO

CREATE PROCEDURE Procedures_AdminDeleteCourse
    @CourseID INT
AS
BEGIN
    UPDATE PreqCourse_course
    SET course_id = null
    WHERE prerequisite_course_id = @CourseID OR course_id = @CourseID

    UPDATE Instructor_Course
    SET course_id = null
    WHERE course_id = @CourseID

    UPDATE Student_Instructor_Course_Take
    SET course_id = null
    WHERE course_id = @CourseID

    UPDATE Course_Semester
    SET course_id = null
    WHERE course_id = @CourseID

    UPDATE SLOT
    SET course_id = null
    WHERE course_id = @CourseID

    UPDATE GradPlan_Course
    SET course_id = null
    WHERE course_id = @CourseID

    UPDATE Request
    SET course_id = null
    WHERE course_id = @CourseID

    UPDATE MakeUp_Exam
    SET course_id = null
    WHERE course_id = @CourseID

    DELETE FROM Course
    WHERE course_id = @CourseID
END

GO


--TO BE REVISED!!
CREATE PROCEDURE Procedure_AdminUpdateStudentStatus
    @StudentID INT
AS
BEGIN
    -- Check if the student has any unpaid installments with a passed deadline
    IF EXISTS (
        SELECT 1
        FROM Installment AS I
        WHERE I.student_id = @StudentID
            AND I.status = 'notPaid'
            AND I.deadline < GETDATE()
    )
    BEGIN
        -- Update the student's status to blocked (status = 0)
        UPDATE Student
        SET financial_status = 0
        WHERE student_id = @StudentID
    END
    ELSE
    BEGIN
        -- Update the student's status to active (status = 1)
        UPDATE Student
        SET financial_status = 1
        WHERE student_id = @StudentID
    END
END

GO

CREATE FUNCTION financial_status_derived (@StudentID INT)
RETURNS BIT
AS
BEGIN
    DECLARE @IsBlocked BIT = 1; -- Default to active

    IF EXISTS (
        SELECT 1
        FROM Student AS s
        INNER JOIN Installment AS i ON s.student_id = i.student_id
        WHERE s.student_id = @StudentID
        AND i.status = 'notPaid'
        AND i.deadline < GETDATE()
    )
        SET @IsBlocked = 0; -- Student is blocked

    RETURN @IsBlocked;
END;

GO

CREATE VIEW all_Pending_Requests AS
SELECT CONCAT('req_id: ', R.request_id,
              ' type: ', R.type,
              ' comment: ', R.comment,
              ' credit hours: ', R.credit_hours,
              ' course id: ', R.course_id) AS 'Pending requests details', CONCAT(S.f_name , ' ' , S.l_name) AS 'initiated student name', A.name AS 'Related advisor name'
FROM Request R
INNER JOIN Student S ON R.student_id = S.student_id
INNER JOIN Advisor A ON R.advisor_id = A.advisor_id
WHERE R.status = 'Pending';

GO

CREATE PROCEDURE Procedures_AdminDeleteSlots
@current_semester VARCHAR(40)
AS
BEGIN
    DELETE FROM Slot
    WHERE course_id IN (
        SELECT course_id
        FROM Course c INNER JOIN Course_Semester cs ON c.course_id = cs.course_id
        WHERE c.is_offered = 0
        AND cs.semester_code = @current_semester
    );
END;

GO

CREATE FUNCTION [FN_AdvisorLogin] (@ID INT, @password VARCHAR(40))
RETURNS BIT
AS
BEGIN
    
    DECLARE @success BIT;
    
    IF EXISTS(
    SELECT 1
    FROM Advisor
    WHERE advisor_id = @ID
    AND password = @password
    ) 
        SET @success = 1 
    ELSE
        SET @success = 0
    
    
    RETURN @success;
END;


GO

CREATE PROCEDURE Procedures_AdvisorCreateGP (
    @semester_code VARCHAR(40),
    @expected_graduation_date DATE,
    @sem_credit_hours INT,
    @advisor_id INT,
    @student_id INT
)
AS
BEGIN
    IF((SELECT acquired_hours FROM Student WHERE student_id = @student_id)>157)
        BEGIN
        INSERT INTO Graduation_Plan (semester_code, semester_credit_hours, expected_grad_semester, advisor_id, student_id)
        VALUES (@semester_code, @sem_credit_hours, @expected_graduation_date, @advisor_id, @student_id)
        END
END

GO


CREATE PROCEDURE Procedures_AdvisorAddCourseGP (
    @student_id INT,
    @semester_code VARCHAR(40),
    @course_name VARCHAR(40)
)
AS
BEGIN
    DECLARE @course_id INT;
    DECLARE @plan_id INT;
    -- Get the course ID based on the course name
    SELECT @course_id = course_id
    FROM Course
    WHERE name = @course_name;

    --WHAT if the same semster code and studnet have multiple plan ids?
    SELECT @plan_id = plan_id
    FROM Graduation_Plan
    WHERE student_id = @student_id AND semester_code = @semester_code

    -- Insert the course into the specified graduation plan
    INSERT INTO GradPlan_Course (plan_id, semester_code, course_id)
    VALUES(@plan_id, @semester_code, @course_id)
    
END;

GO

CREATE PROCEDURE Procedures_AdvisorUpdateGP (
    @expected_grad_date DATE,
    @studentID INT
)
AS
BEGIN

    UPDATE Graduation_Plan
    SET expected_grad_date = @expected_grad_date
    WHERE student_id = @studentID
END;

GO

CREATE PROCEDURE Procedures_AdvisorDeleteFromGP (
    @studentID INT,
    @semester_code VARCHAR(40),
    @courseID INT
)
AS
BEGIN
    DELETE FROM GradPlan_Course
    WHERE plan_id IN (
        SELECT plan_id
        FROM Graduation_Plan
        WHERE student_id = @studentID
    )
    AND semester_code = @semester_code
    AND course_id = @courseID
END;

GO

CREATE FUNCTION [FN_Advisors_Requests] (@advisorID INT)
RETURNS TABLE
AS
RETURN
    SELECT R.*
    FROM Request R
    INNER JOIN Advisor A ON R.advisor_id = A.advisor_id
    WHERE A.advisor_id = @advisorID;
    

GO

CREATE PROCEDURE Procedures_AdvisorApproveRejectCHRequest (
    @RequestID INT,
    @CurrentSemesterCode VARCHAR(40)
)
AS
BEGIN
    DECLARE @status VARCHAR(40);
    DECLARE @gpa DECIMAL(3,2);
    DECLARE @ch INT;
    DECLARE @ch_total INT;
    DECLARE @sid INT;
    DECLARE @prop_ch INT;
    DECLARE @assi_hours INT

    SELECT @sid = s.student_id, @gpa = s.gpa, @ch = r.credit_hours, @assi_hours = s.assigned_hours
    FROM STUDENT s INNER JOIN Request r ON s.student_id = r.student_id
    WHERE r.request_id = @RequestID and r.type = 'credit_hours';


    
    SET @prop_ch = @ch + @assi_hours;
    
    --A student can only add hours if
    --he/she is NOT under probation. 
    --A student can add up to 3 credit hours but must also be below the 34
    --credit hours threshold.
    IF (@gpa > 3.7 OR @ch>3 OR @prop_ch>34)
        SET @status = 'Rejected';
    ELSE
    BEGIN
        SET @status = 'Approved';
        UPDATE Payment
        SET amount = amount + (@ch*1000), status = 'notPaid'
        WHERE  student_id = @sid AND deadline = (SELECT TOP 1 deadline 
                                                 FROM Paymnet
                                                 WHERE deadline>=GETDATE() AND Payment.student_id = @sid
                                                 ORDER BY DATEDIFF(day, deadline, GETDATE())) 
                            
       
        UPDATE STUDENT
        SET assigned_hours = assigned_hours+@ch
        WHERE student_id = @sid

        UPDATE INSTALLMENT
        SET amount = amount + (@ch*1000), status = 'notPaid'
        WHERE payment_id IN (SELECT payment_id FROM Payment WHERE student_id = @sid) AND 
        deadline = (SELECT TOP 1 i.deadline
                    FROM Installment i INNER JOIN Payment p ON p.payment_id = i.payment_id
                    WHERE deadline>=GETDATE() AND p.student_id = @sid
                    ORDER BY DATEDIFF(day, i.deadline, GETDATE())
                    )
    END
    -- Update the request status
    UPDATE Request
    SET status = @status
    WHERE request_id = @RequestID;
END;

GO

CREATE PROCEDURE Procedures_AdvisorViewAssignedStudents
    @AdvisorID int,
    @Major varchar(40)
AS
BEGIN
    SELECT s.student_id AS 'Student id', s.f_name + ' ' + s.l_name AS 'Student Name', s.major AS 'Student major', c.name AS 'Course name'
    FROM Student s
    INNER JOIN Student_Instructor_Course_Take sic ON s.student_id = sic.student_id
    INNER JOIN Course c ON sic.course_id = c.course_id
    WHERE s.advisor_id = @AdvisorID AND s.major = @Major
END

GO


CREATE PROCEDURE Procedures_AdvisorApproveRejectCourseRequest
    @RequestID int,
    @current_semester_code VARCHAR(40)
AS
BEGIN
    DECLARE @sid INT, @gpa DECIMAL(3,2), @ch INT, @assi_hours int;
    DECLARE @prop_ch INT;
    DECLARE @cch INT;
    DECLARE @courseID int;
    DECLARE @status VARCHAR(40)

    -- Get the student's information and requested course details
    SELECT @sid = s.student_id, @gpa = s.gpa, @assi_hours = s.assigned_hours, @courseID = r.course_id
    FROM STUDENT s
    INNER JOIN Request r ON s.student_id = r.student_id
    WHERE r.request_id = @RequestID AND r.type = 'course';

    -- Check if the requested course's prerequisites are taken
    IF EXISTS (
        SELECT p.prerequisite_course_id
        FROM PreqCourse_course p
        WHERE p.course_id = (
            SELECT course_id
            FROM Request
            WHERE request_id = @RequestID
        )
        EXCEPT
        SELECT course_id
        FROM Student_Instructor_Course_Take
        WHERE student_id = @sid
    )
    BEGIN
        -- Prerequisites are not taken, reject the course request
        SET @status = 'Rejected'
    
        
    END
    ELSE 
    BEGIN

        SELECT @cch = credit_hours
        FROM Course
        WHERE course_id =@courseID
    
        SET @prop_ch = @assi_hours - @cch
        -- Student has enough assigned hours, approve the course request
        
        IF(@prop_ch >= 0)
        BEGIN
            SET @status = 'Accepted'

            INSERT INTO Student_Instructor_Course_Take(student_id, course_id, semester_code)
            VALUES(@sid, @courseID, @current_semester_code)

            UPDATE Student
            SET assigned_hours = @prop_ch
            WHERE student_id = @sid

        END
        ELSE
        BEGIN
            SET @status = 'Rejected'
        END

    END

     UPDATE Request
     SET status = @status
     WHERE request_id = @RequestID;
    
END

GO



CREATE PROCEDURE Procedures_AdvisorViewPendingRequests
    @AdvisorID int
AS
BEGIN
    SELECT r.request_id, r.type, r.comment, r.status, r.credit_hours, s.student_id, s.f_name + ' ' + s.l_name AS student_name
    FROM Request r
    INNER JOIN Student s ON r.student_id = s.student_id
    WHERE r.advisor_id = @AdvisorID AND r.status = 'pending'
END

GO

CREATE FUNCTION [FN_StudentLogin]
    (@StudentID int, @Password varchar(40))
RETURNS bit
AS
BEGIN
    DECLARE @Success bit

    IF EXISTS (SELECT 1 FROM Student WHERE student_id = @StudentID AND password = @Password)
        SET @Success = 1
    ELSE
        SET @Success = 0

    RETURN @Success
END

GO

CREATE PROCEDURE Procedures_StudentAddMobile
    @StudentID int,
    @MobileNumber varchar(40)
AS
BEGIN
    INSERT INTO Student_Phone (student_id, phone_number)
    VALUES (@StudentID, @MobileNumber);
END

GO

CREATE FUNCTION [FN_SemesterAvailableCourses]
    (@SemesterCode varchar(40))
RETURNS TABLE
AS
RETURN
(
    SELECT c.course_id, c.name, c.major, c.credit_hours
    FROM Course c
    INNER JOIN Course_Semester cs ON c.course_id = cs.course_id
    WHERE cs.semester_code = @SemesterCode AND c.is_offered = 1
);

GO

CREATE PROCEDURE Procedures_StudentSendingCourseRequest
    @StudentID int,
    @CourseID int,
    @Type varchar(40),
    @Comment varchar(40)
AS
BEGIN
    INSERT INTO Request (type, comment, credit_hours, student_id, advisor_id, course_id)
    VALUES (@Type, @Comment, (SELECT credit_hours FROM Course WHERE course_id = @CourseID), @StudentID, (SELECT advisor_id FROM Student WHERE student_id = @StudentID), @CourseID);
END

GO

CREATE PROCEDURE Procedures_StudentSendingCHRequest
    @StudentID INT,
    @credit_hours INT, 
    @type varchar (40),
    @comment varchar (40)

AS

     INSERT INTO Request (type, comment, credit_hours, student_id, advisor_id, course_id)
     VALUES (@type, @comment, @credit_hours, @StudentID, (SELECT advisor_id FROM Student WHERE student_id = @StudentID), null);


GO

CREATE FUNCTION [FN_StudentViewGP]
(@student_ID INT)
RETURNS TABLE

AS
RETURN(SELECT gp.student_id AS 'Student Id', s.f_name + ' ' + s.l_name AS 'Student_name' ,gp.plan_id AS 'graduation Plan Id',
               gpc.course_id AS 'Course id', c.name AS 'Course name', gp.semester_code AS 'Semester code', 
               gp.expected_grad_date AS 'expected graduation date', gp.semester_credit_hours AS 'Semester credit hours',
               gp.advisor_id AS 'advisor id'
       FROM Graduation_Plan gp INNER JOIN GradPlan_Course gpc ON gp.plan_id = gpc.plan_id
       INNER JOIN Student s ON gp.student_id = s.student_id
       INNER JOIN Course c ON c.course_id = gpc.course_id
       WHERE gp.student_id = @student_id)

GO

CREATE FUNCTION [FN_StudentUpcoming_installment]
(@StudentID INT)
RETURNS DATETIME

AS
BEGIN
DECLARE @deadline DATETIME;

SELECT @deadline = i.deadline
FROM Installment i  INNER JOIN Payment p ON p.payment_id = i.payment_id
WHERE p.student_id = @StudentID AND i.status = 'notPaid' AND i.deadline = (SELECT TOP 1 i.deadline
                                                                           FROM Installment i1 INNER JOIN Payment p1 ON p1.payment_id = i1.payment_id
                                                                           WHERE i1.deadline>=GETDATE() AND p1.student_id = @StudentID AND i.status = 'notPaid'
                                                                           ORDER BY DATEDIFF(day, i.deadline,GETDATE()))

RETURN @deadline;

END

GO

CREATE FUNCTION [FN_StudentViewSlot]
(@CourseID INT, @InstructorID INT)
RETURNS TABLE

AS
RETURN
    SELECT s.slot_id AS 'Slot ID', s.location AS 'location', s.time AS 'time', s.day AS 'day', c.name AS 'Course name', i.name AS 'Instructor name'
    FROM Slot s INNER JOIN Course c ON c.course_id = s.course_id
    INNER JOIN Instructor i ON s.instructor_id = i.instructor_id
    WHERE s.course_id = @CourseID AND s.instructor_id = @InstructorID

GO



--Even courses’ makeup exams are offered at the end of the Spring semester and before the start of the
--Winter semester. Odd courses makeup exams are offered at the end of the Winter semester and before
--the start of the Spring semester

--Is it similar to the guc system where we only can register for makeups when it is offered in the end of the current semester or the beginiing of the next semester?
CREATE PROCEDURE Procedures_StudentRegisterFirstMakeup
    @StudentID int, 
    @courseID int, 
    @studentCurrent_semester varchar (40)
AS
BEGIN
DECLARE @exam_id INT;

IF (
    (((@studentCurrent_semester LIKE 'W%') AND EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND semester_code LIKE 'W%'))
    OR ((@studentCurrent_semester LIKE 'S%R1') AND EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND semester_code LIKE 'S__'))
    OR ((@studentCurrent_semester LIKE 'S__') AND EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND semester_code LIKE 'S__'))
    OR ((@studentCurrent_semester LIKE 'S%R2') AND EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND semester_code LIKE 'S__')))
    AND ((SELECT grade FROM Student_Instructor_Course_Take WHERE student_id=@StudentID AND course_id=@courseID AND exam_type='Normal') IN('FF', 'F', null))
    AND (NOT EXISTS (SELECT 1 FROM Student_Instructor_Course_Take WHERE student_id=@StudentID AND course_id=@courseID AND exam_type <> 'Normal'))
    )
    BEGIN
    SELECT @exam_id = me.exam_id
    FROM MakeUp_Exam me, Semester s
    WHERE me.course_id = @courseID AND me.type = 'First_makeup' AND me.date = (SELECT TOP 1 me1.date
                                                                               FROM MakeUp_Exam me1, Semester s1
                                                                               WHERE me1.date>=GETDATE() AND  me1.course_id = @courseID 
                                                                                     AND me1.type = 'First_makeup'
                                                                                     AND s1.semester_code=@studentCurrent_semester
                                                                               ORDER BY DATEDIFF(day, s1.end_date, me1.date))
    INSERT INTO Exam_Student(exam_id, student_id, course_id)
    VALUES(@exam_id, @StudentID, @courseID)

    INSERT INTO Student_Instructor_Course_Take(student_id, course_id, instructor_id, semester_code, exam_type, grade)
    VALUES(@StudentID, @courseID, null, @studentCurrent_semester, 'First_makeup', null)
    END
END
GO


--A student is eligible for the second makeup of a
--course if and only if he/she failed or did not attend the first makeup and also has a maximum of TWO
--failed courses per all odd or even semesters.
CREATE FUNCTION [FN_StudentCheckSMEligiability]
(@CourseID int, @StudentID int)
RETURNS BIT

AS
BEGIN
DECLARE @eligible BIT
DECLARE @n_failed_even INT
DECLARE @n_failed_odd INT
DECLARE @n_failed INT

    SELECT @n_failed_odd=COUNT(*)
    FROM Student_Instructor_Course_take
    WHERE (grade IN('FF','F', 'FA')) AND student_id = @StudentID AND 
    (semester_code LIKE 'W%' OR semester_code LIKE 'S%R1')
    


    SELECT @n_failed_even=COUNT(*)
    FROM Student_Instructor_Course_take
    WHERE (grade IN('FF','F', 'FA')) AND student_id = @StudentID AND 
    (semester_code LIKE 'S__' OR semester_code LIKE 'S%R2')

    IF(EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND (semester_code LIKE 'W%' OR semester_code LIKE 'S%R1') ))
        SET @n_failed = @n_failed_odd
    ELSE
        SET @n_failed = @n_failed_even



IF ( ((SELECT grade FROM Student_Instructor_Course_Take WHERE student_id=@StudentID AND course_id=@courseID AND exam_type='First_makeup') IN('FF', 'FA','F', null))
     AND (@n_failed<=2)
    )
    SET @eligible = 1
ELSE
    SET @eligible = 0



RETURN @eligible
END
GO

CREATE PROCEDURE Procedures_StudentRegisterSecondMakeup
    @StudentID int, 
    @courseID int, 
    @studentCurrent_semester varchar (40)
AS
BEGIN
DECLARE @exam_id INT;

IF ( dbo.FN_StudentCheckSMEligiability(@courseID,@StudentID) = 1
    AND (((@studentCurrent_semester LIKE 'W%') AND EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND semester_code LIKE 'W%'))
    OR ((@studentCurrent_semester LIKE 'S%R1') AND EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND semester_code LIKE 'S__'))
    OR ((@studentCurrent_semester LIKE 'S__') AND EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND semester_code LIKE 'S__'))
    OR ((@studentCurrent_semester LIKE 'S%R2') AND EXISTS(SELECT 1 FROM Course_Semester WHERE course_id = @courseID AND semester_code LIKE 'S__')))
    ) 
    BEGIN

    SELECT @exam_id = me.exam_id
    FROM MakeUp_Exam me, Semester s
    WHERE me.course_id = @courseID AND me.type = 'Second_makeup' AND me.date = (SELECT TOP 1 me1.date
                                                                               FROM MakeUp_Exam me1, Semester s1
                                                                               WHERE me1.date>=GETDATE() AND  me1.course_id = @courseID 
                                                                                     AND me1.type = 'Second_makeup'
                                                                                     AND s1.semester_code=@studentCurrent_semester
                                                                               ORDER BY DATEDIFF(day, s1.end_date, me1.date))
    
    INSERT INTO Exam_Student(exam_id, student_id, course_id)
    VALUES(@exam_id, @StudentID, @courseID)

    INSERT INTO Student_Instructor_Course_Take(student_id, course_id, instructor_id, semester_code, exam_type, grade)
    VALUES(@StudentID, @courseID, null, @studentCurrent_semester, 'Second_makeup', null)

    END
    



END
GO


--Required courses: A course is considered required (according to a certain student) if it is unattended or failed.
--Failed course: Student failed in this course before and is not eligible for the 2nd makeup.
--Unattended Course: A mandatory course from previous semesters that the student did not take before (Must be a course from a semester less than student’s current semester).

CREATE PROCEDURE Procedures_ViewRequiredCourses
    @StudentID INT, 
    @Current_semester_code VARCHAR (40)
AS
BEGIN
    DECLARE @s_major VARCHAR(40)
    DECLARE @s_semester INT

    SELECT @s_major = major, @s_semester = semester
    FROM Student
    WHERE student_id = @StudentID


    SELECT c.*
    FROM Course C INNER JOIN Student_Instructor_Course_Take sict ON c.course_id=sict.course_id
    WHERE sict.student_id=@StudentID AND (
              (dbo.FN_StudentCheckSMEligiability(c.course_id,@StudentID)=0 AND 
            (SELECT grade FROM Student_Instructor_Course_Take WHERE student_id=@StudentID AND exam_type='Normal') IN('FF', 'FA','F', null))
            OR
            c.course_id IN ((SELECT course_id
                            FROM Course
                            WHERE major = @s_major AND semester<@s_semester) EXCEPT (SELECT course_id FROM Student_Instructor_Course_Take WHERE student_id=@StudentID))
            )
            

END
GO

--Optional Courses: courses from the current semester or upcoming semesters (Student is allowed to take the optional course if he/she satisfied their prerequisites).

CREATE PROCEDURE Procedures_ViewOptionalCourse
    @StudentID int, 
    @Current_semester_code Varchar (40)
AS
SELECT c.*
FROM Course_Semester cs
INNER JOIN Course c ON c.course_id = cs.course_id
INNER JOIN PreqCourse_course prc ON prc.course_id = c.course_id
INNER JOIN Student_Instructor_Course_Take sict ON sict.course_id = c.course_id
INNER JOIN Student s ON s.student_id = sict.student_id
WHERE (cs.semester_code = @Current_semester_code OR c.semester > s.semester)
      AND s.student_id = @StudentID
      AND c.course_id IN (
          SELECT prc.prerequisite_course_id
          FROM PreqCourse_course prc
          WHERE prc.course_id = c.course_id
          EXCEPT
          SELECT sict.course_id
          FROM Student_Instructor_Course_Take sict
          WHERE sict.student_id = @StudentID and sict.grade not in('FF', 'FA', 'F')
      )

GO

CREATE PROCEDURE Procedures_ViewMS
    @StudentID int
AS

Declare @Major varchar(40)
Select @Major = s.major
From Student s
Where s.student_id = @StudentID

SELECT course_id
    FROM Course c
    WHERE major = @Major
        AND NOT EXISTS (
            SELECT 1
            FROM Student_Instructor_Course_Take sict
            WHERE sict.course_id = c.course_id
                AND sict.student_id = @StudentID
        )

GO

CREATE PROCEDURE Procedures_ChooseInstructor
    @StudentID int, 
    @InstructorID int, 
    @CourseID int

AS

INSERT INTO Instructor_Course(course_id, instructor_id)
VALUES(@CourseID, @InstructorID)

UPDATE Student_Instructor_Course_Take
SET instructor_id = @InstructorID
WHERE student_id=@StudentID AND course_id = @CourseID


GO