create table if not exists public.message (
    id bigserial not null,
    user_id bigint,
    filename varchar(255),
    tag varchar(255),
    text varchar(2048),
    primary key (id)
);

create table if not exists public.role (
    id bigserial not null,
    role varchar(255),
    primary key (id)
);

create table if not exists public.usr (
    active boolean not null,
    id bigserial not null,
    activation_code varchar(255),
    email varchar(255),
    password varchar(255) not null,
    username varchar(255) not null,
    primary key (id)
);

create table if not exists public.usr_role (
    id_role bigint not null,
    user_id bigint not null,
    primary key (id_role, user_id)
);

alter table if exists message
    add constraint message_user_fk
    foreign key (user_id) references usr (id) match simple on update cascade on delete cascade;

alter table if exists usr_role
    add constraint user_role_role_id_fk
    foreign key (id_role) references role (id) match simple on update cascade on delete cascade;

alter table if exists usr_role
    add constraint user_role_user_fk
    foreign key (user_id) references usr (id) match simple on update cascade on delete cascade;