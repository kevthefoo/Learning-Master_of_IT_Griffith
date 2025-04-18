DROP DATABASE IF EXISTS company;
CREATE DATABASE IF NOT EXISTS company;
USE company;

/* The COMPANY database schema (based on the textbook) */
/* create structure */

CREATE TABLE IF NOT EXISTS employee (
    name	varchar(20)	not null,
    ssn		char(9)		not null,	/* primary key */
    bdate	date,	
    address	varchar(40),
    sex		char(1),
    salary	decimal(10,2),
    superssn	char(9),			/* references employee */
    dno		int,	         	/* references department */
    PRIMARY KEY (ssn)
);

CREATE TABLE IF NOT EXISTS department (
    dname	varchar(20)	not null,
    dnumber	int	not null,	/* primary key */
    mgrssn	char(9),  	          	/* references employee */
    mgrstartdate date,
    PRIMARY KEY (dnumber),
    UNIQUE (dname)
);

/* add foreign key constraints for employee */

ALTER TABLE employee ADD CONSTRAINT employee_dno
    FOREIGN KEY (dno) REFERENCES  department(dnumber);

ALTER TABLE employee ADD CONSTRAINT employee_superssn
    FOREIGN KEY (superssn) REFERENCES  employee(ssn);

ALTER TABLE department ADD CONSTRAINT department_mgrssn
    FOREIGN KEY (mgrssn) REFERENCES employee(ssn);

CREATE TABLE dept_locations (
    dnumber	int	not null,	/* references department */
    dlocation	varchar(15) 	not null,
    PRIMARY KEY (dnumber,dlocation)
);

ALTER TABLE dept_locations ADD CONSTRAINT dept_locations_dnumber
    FOREIGN KEY (dnumber) REFERENCES department(dnumber);

CREATE TABLE IF NOT EXISTS project (
    pname	varchar(15)	not null,
    pnumber	int	not null,	/* primary key */
    plocation	varchar(15),
    dnum	int 	not null,	/* references department */
    PRIMARY KEY (pnumber),
    UNIQUE (pname)
);

ALTER TABLE project ADD CONSTRAINT project_dnum
    FOREIGN KEY (dnum) REFERENCES department(dnumber);

CREATE TABLE IF NOT EXISTS works_on (
    essn	char(9)         not null,	/* references employee */
    pno		int	not null,	/* references project */
    hours	decimal(3,1), 
    PRIMARY KEY (essn, pno)
);

ALTER TABLE works_on ADD CONSTRAINT works_on_essn
    FOREIGN KEY (essn) REFERENCES employee(ssn);

ALTER TABLE works_on ADD CONSTRAINT works_on_pno
    FOREIGN KEY (pno) REFERENCES project(pnumber);

CREATE TABLE IF NOT EXISTS dependent (
    essn	   char(9)         not null,        /* references employee */
    dependent_name varchar(15)	   not null,
    sex		   char(1),
    bdate	   date,
    relationship   varchar(8),
    PRIMARY KEY    (essn,dependent_name)
);

ALTER TABLE dependent ADD CONSTRAINT dependent_essn
    FOREIGN KEY (essn)  REFERENCES employee(ssn);

