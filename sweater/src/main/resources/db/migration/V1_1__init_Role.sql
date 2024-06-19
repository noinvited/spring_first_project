insert into role (role) values ('USER');
insert into role (role) values ('ADMIN');
insert into usr (active, password, username) values (true, '$2a$10$FVrv1MzM.dPrK9/F4IVLZeEe7VFucC7gXqunZkzMG4pWMw3Q3.NQi', 'bekas2003');
insert into usr_role (user_id, id_role) values (1, 1);
insert into usr_role (user_id, id_role) values (1, 2);
