DROP TABLE IF EXISTS agents, clients, entertainers, engagements;

CREATE TABLE agents
(agent_id int primary key,
agent_first_name varchar(255),
agent_last_name varchar(255),
date_of_hire date,
agent_home_phone varchar(255));

INSERT INTO agents
(agent_id, agent_first_name, agent_last_name, date_of_hire, agent_home_phone)
VALUES (100, 'Mike', 'Hernandez', '05/16/2011', '553-3992'),
(101, 'Greg', 'Johnson', '10/15/2011', '790-3992'),
(102, 'Katherine', 'Ehrlich', '03/01/2012', '551-4993');

CREATE TABLE clients
(client_id int primary key,
agent_id int NOT null REFERENCES agents( agent_id ),
client_first_name varchar(255),
client_last_name varchar(255),
client_home_phone varchar(255));

INSERT INTO clients
(client_id, agent_id, client_first_name, client_last_name, client_home_phone)
VALUES (9000, 100, 'John', 'Smith', '553-3992'),
(9001, 100, 'Stewart', 'Jameson', '553-3992'),
(9002, 101, 'Susan', 'Black', '790-3992'),
(9003, 102, 'Estela', 'Rosales', '551-4993');

# Fails since agent_id 1 does not exist in the agents table.
INSERT INTO clients
(client_id, agent_id, client_first_name, client_last_name, client_home_phone)
VALUES (9345, 1, 'ThisIsA', 'Failure', '804 555 1212');


CREATE TABLE entertainers
(entertainer_id int primary key,
agent_id int NOT null REFERENCES agents( agent_id ),
entertainer_first_name varchar(255),
entertainer_last_name varchar(255));

INSERT INTO entertainers
(entertainer_id, agent_id, entertainer_first_name, entertainer_last_name)
VALUES (3000, 100, 'John', 'Slade'),
(3001, 101, 'Mark', 'Jebavy'),
(3002, 102, 'Teresa', 'Weiss');



drop table if exists engagements;
CREATE TABLE engagements
(client_id int  NOT null REFERENCES clients (client_id),
entertainer_id int NOT null REFERENCES entertainers (entertainer_id),
engagement_date date,
start_time time,
stop_time time);

INSERT INTO engagements
(client_id, entertainer_id, engagement_date, start_time, stop_time)
VALUES (9003, 3001, '04/01/2012', '1:00 PM', '3:30 PM'),
(9002, 3000, '04/13/2012', '9:00 PM', '1:30 AM'),
(9001, 3002, '05/02/2012', '3:00 PM', '6:00 PM');


select * from agents;
select * from clients;
select * from entertainers;
select * from engagements;


SELECT * FROM clients, engagements  WHERE clients.client_id = engagements.client_id;

SELECT * FROM clients
    INNER JOIN engagements on clients.client_id = engagements.client_id;


SELECT agents.agent_first_name, agent_last_name, clients.client_id , client_first_name, client_last_name, 
client_home_phone, engagement_date, start_time,stop_time
FROM clients
    INNER JOIN engagements on clients.client_id = engagements.client_id
    INNER JOIN agents on clients.agent_id = agents.agent_id;

CREATE OR REPLACE VIEW agent_client_engagement_view AS
SELECT agents.agent_first_name, agent_last_name, clients.client_id , client_first_name, client_last_name, 
client_home_phone, engagement_date, start_time,stop_time
FROM clients
    INNER JOIN engagements on clients.client_id = engagements.client_id
    INNER JOIN agents on clients.agent_id = agents.agent_id;
 


