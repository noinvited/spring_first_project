create table message (
    id bigserial not null,
    user_id bigint,
    filename varchar(255),
    tag varchar(255),
    text varchar(2048),
    primary key (id)
);

create table role (
    id bigserial not null,
    role varchar(255),
    primary key (id)
);

create table usr (
    active boolean not null,
    id bigserial not null,
    activation_code varchar(255),
    email varchar(255),
    password varchar(255) not null,
    username varchar(255) not null,
    primary key (id)
);

create table usr_role (
    id_role bigserial not null,
    user_id bigserial not null
);

alter table if exists message
    add constraint message_user_fk
    foreign key (user_id) references usr match simple on update cascade on delete cascade;

alter table if exists usr_role
    add constraint user_role_role_id_fk
    foreign key (id_role) references role match simple on update cascade on delete cascade;

alter table if exists usr_role
    add constraint user_role_user_fk
    foreign key (user_id) references usr match simple on update cascade on delete cascade;