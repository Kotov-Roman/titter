insert into usr (id, activation_code, active, email, password, username)
values (1,
        null,
        true,
        'poma_k@mail.ru',
        'admin',
        'admin');


insert into user_role (user_id, roles)
values (1, 'USER'),
       (1, 'ADMIN');