CREATE TABLE specialization (
    specialization_id		serial			PRIMARY KEY,
    title 				varchar(220) 	DEFAULT ''::varchar NOT NULL,
    description			text
);

CREATE TABLE vacancy_body (
    vacancy_body_id 		serial 			PRIMARY KEY,
    company_name 			varchar(150) 	DEFAULT ''::varchar NOT NULL,
    name 					varchar(220) 	DEFAULT ''::varchar NOT NULL,
    text 					text,
    area_id 				integer,
    address_id 				integer,
    work_experience 		integer 		DEFAULT 0 NOT NULL,
    compensation_from 		bigint 			DEFAULT 0,
    compensation_to 		bigint 			DEFAULT 0,
    test_solution_required 	boolean 		DEFAULT false NOT NULL,
    work_schedule_type 		integer 		DEFAULT 0 NOT NULL,
    employment_type 		integer 		DEFAULT 0 NOT NULL,
    compensation_gross 		boolean,
    driver_license_types 	varchar(5)[],    
    CONSTRAINT vacancy_body_work_employment_type_validate CHECK ((employment_type = ANY (ARRAY[0, 1, 2, 3, 4]))),
    CONSTRAINT vacancy_body_work_schedule_type_validate CHECK ((work_schedule_type = ANY (ARRAY[0, 1, 2, 3, 4])))
);

CREATE TABLE vacancy (
    vacancy_id 			serial 		PRIMARY KEY,
    creation_time 		timestamp 	NOT NULL,
    expire_time 		timestamp 	NOT NULL,
    employer_id 		integer		DEFAULT 0 NOT NULL,    
    disabled 			boolean 	DEFAULT false NOT NULL,
    visible 			boolean 	DEFAULT true NOT NULL,
    vacancy_body_id 	integer 	DEFAULT 0 NOT NULL,
    CONSTRAINT fk_vacancy_body_id FOREIGN KEY (vacancy_body_id)  REFERENCES vacancy_body  (vacancy_body_id),
    area_id integer
);

CREATE TABLE vacancy_body_specialization (
    vacancy_body_id integer DEFAULT 0 NOT NULL,
    specialization_id integer DEFAULT 0 NOT NULL,
    FOREIGN KEY(vacancy_body_id) REFERENCES vacancy_body(vacancy_body_id),
    FOREIGN KEY(specialization_id) REFERENCES specialization(specialization_id)
);

CREATE TABLE resume (
    resume_id 			serial			PRIMARY KEY,
    title 				varchar(150) 	DEFAULT ''::varchar NOT NULL,
    creation_time 		timestamp 		NOT NULL,
    expire_time 		timestamp 		NOT NULL,
    user_id 			integer 		DEFAULT 0 NOT NULL,    
    disabled 			boolean 		DEFAULT false NOT NULL,
    visible 			boolean 		DEFAULT true NOT NULL,
    resume_data_body_id integer 		DEFAULT 0 NOT NULL,
    area_id 			integer,
    name 				varchar(150) 	DEFAULT ''::varchar NOT NULL,
    gender 				boolean 		DEFAULT false NOT NULL,
    birth_date 			timestamp 		NOT NULL,
    phone 				varchar(30),
    email 				varchar(50),
    update_date 		timestamp,
    text 				text
);

CREATE TABLE response(
    id 					serial			PRIMARY KEY,
    resume_id 			integer			DEFAULT 0 NOT NULL,
    vacancy_id 			integer			DEFAULT 0 NOT NULL,
    response_date 		timestamp 		NOT NULL,
    CONSTRAINT fk_esponse_resume_id FOREIGN KEY (resume_id)  REFERENCES resume (resume_id),
    CONSTRAINT fk_response_vacancy_id FOREIGN KEY (vacancy_id)  REFERENCES vacancy (vacancy_id)
);

CREATE TABLE resume_specialization (        
    resume_id 			integer 	DEFAULT 0 NOT NULL,
    specialization_id 	integer 	DEFAULT 0 NOT null,
    FOREIGN KEY(resume_id) REFERENCES resume(resume_id),
    FOREIGN KEY(specialization_id) REFERENCES specialization(specialization_id)    
);