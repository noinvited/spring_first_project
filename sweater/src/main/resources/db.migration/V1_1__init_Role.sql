insert into role (id, role) values (1, 'USER');
insert into role (id, role) values (2, 'ADMIN');
insert into usr (id, active, password, username) values (1, true, '$2a$10$FVrv1MzM.dPrK9/F4IVLZeEe7VFucC7gXqunZkzMG4pWMw3Q3.NQi', 'bekas2003');
insert into usr_role (user_id, id_role) values (1, 1);
insert into usr_role (user_id, id_role) values (1, 2);
