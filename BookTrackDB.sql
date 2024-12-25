-- Step 1: Create a Sequence
CREATE SEQUENCE BookID_Seq START WITH 1 INCREMENT BY 1;

-- Step 2: Create the Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR2(255) NOT NULL,
    Author VARCHAR2(255) NOT NULL,
    Genre VARCHAR2(100),
    PublishedYear NUMBER(4),
    CopiesAvailable INT DEFAULT 0
);

-- Step 3: Create a Trigger for Auto-Increment
CREATE OR REPLACE TRIGGER Books_BookID_Trigger
BEFORE INSERT ON Books
FOR EACH ROW
BEGIN
    :NEW.BookID := BookID_Seq.NEXTVAL;
END;
/
-- Create the Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR2(100) NOT NULL,
    LastName VARCHAR2(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    MembershipDate DATE NOT NULL,
    MembershipStatus VARCHAR2(10) DEFAULT 'Active'
);

-- Create a Sequence for MemberID
CREATE SEQUENCE MemberID_Seq START WITH 1 INCREMENT BY 1;

-- Create a Trigger for Auto-Incrementing MemberID
CREATE OR REPLACE TRIGGER Members_MemberID_Trigger
BEFORE INSERT ON Members
FOR EACH ROW
BEGIN
    :NEW.MemberID := MemberID_Seq.NEXTVAL;
END;
/
CREATE TABLE LendingRecords (
    LendingID INT PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    Status VARCHAR2(10) DEFAULT 'Borrowed',
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);

-- 4. Librarians Table
CREATE TABLE Librarians (
    LibrarianID INT PRIMARY KEY,
    FirstName VARCHAR2(100) NOT NULL,
    LastName VARCHAR2(100) NOT NULL,
    HireDate DATE NOT NULL,
    Email VARCHAR2(255) UNIQUE NOT NULL
);
-- 5. LibraryBranches Table
CREATE TABLE LibraryBranches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR2(150) NOT NULL,
    Location VARCHAR2(255) NOT NULL
);
-- 6. BooksInBranches Table
CREATE TABLE BooksInBranches (
    BranchID INT NOT NULL,
    BookID INT NOT NULL,
    Copies INT DEFAULT 0,
    PRIMARY KEY (BranchID, BookID),
    FOREIGN KEY (BranchID) REFERENCES LibraryBranches(BranchID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);