ALTER TABLE Course
   Add ( CONSTRAINT CrossReferenceConstraint
         FOREIGN KEY (crossListId) REFERENCES Course(id)
       );

ALTER TABLE Student
   Add ( CONSTRAINT MentorConstraint
         FOREIGN KEY (mentorId) REFERENCES Student(id)
       );

	
