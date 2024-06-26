/*
    LAST MODIFICATION: 29/06/2024 15:54
    VERSION: 
        1.0 (RESERVAS ESPECIALES)
*/
use notifications;
/*
    roles
*/
insert into roles(name, created_at, updated_at) values 
('ENCARGADO', NOW(), NOW()),		/*ID 1*/
('DOCENTE', NOW(), NOW())			/*ID 2*/
;			
/*
    permissions
	request_reserve => solicitud de reserva o hacer una reserva (DOCENTE - ENCARGADO) 
	reservation_handling => Atender solicitudes de reserva (ENCARGADO)
	notify => Notificaciones (ENCARGADO)
	report => Generar reportes de uso de ambiente (ENCARGADO) 
    block_register => Registro de nuesvos bloques (ENCARGADO)
    block_update => Edicion de bloques (ENCARGADO)
    block_remove => Eliminar un bloque (ENCARGADO)
    environment_register => Registrar ambiente (ENCARGADO)
    environment_update => Editar ambiente (ENCARGADO)
    environment_remove => Eliminar ambiente (ENCARGADO)
    reservation_cancel => Cancelar solicitues de reserva (DOCENTE)
    history => Obtener el historia de solicitudes (DOCENTE)
    special_reservation => Realizar una reserva especial (ENCARGADO)
 */
insert into permissions(name, created_at, updated_at) values
('request_reserve', NOW(), NOW()),			/*ID 1*/
('reservation_handling', NOW(), NOW()),		/*ID 2*/
('notify', NOW(), NOW()),					/*ID 3*/
('report', NOW(), NOW()),					/*ID 4*/
('block_register', NOW(), NOW()),			/*ID 5*/
('block_update', NOW(), NOW()),				/*ID 6*/
('block_remove', NOW(), NOW()),				/*ID 7*/
('environment_register', NOW(), NOW()),		/*ID 8*/
('environment_update', NOW(), NOW()),		/*ID 9*/
('environment_remove', NOW(), NOW()),		/*ID 10*/
('reservation_cancel', NOW(), NOW()),		/*ID 11*/
('history', NOW(), NOW()),		            /*ID 12*/
('special_reservation', NOW(), NOW())		/*ID 13*/
;			
/*
    role_permission
    ENCARGADO 	-> ID 1
    DOCENTE 	-> ID 2
*/
insert into role_permission(role_id, permission_id, created_at, updated_at) values
(1,2,NOW(), NOW()),
(1,3,NOW(), NOW()),
(1,4,NOW(), NOW()),
(1,5,NOW(), NOW()),
(1,6,NOW(), NOW()),
(1,7,NOW(), NOW()),
(1,8,NOW(), NOW()),
(1,9,NOW(), NOW()),
(1,10,NOW(), NOW()),
(1,13,NOW(), NOW()),
(1,1,NOW(), NOW()),
(2,1,NOW(), NOW()),
(2,11,NOW(), NOW()),
(2,12,NOW(), NOW())
;
/*
    some roles: 
*/
insert into person_role(person_id, role_id) values
    (1, 2), 
    (2, 2), 
    (3, 2), 
    (4, 2), 
    (5, 2), 
    (6, 2), 
    (7, 2), 
    (8, 2), 
    (9, 2), 
    (10, 2),
    (11, 2), 
    (12, 2), 
    (13, 2), 
    (14, 2), 
    (15, 2),
    (16, 2),
    (17, 2),
    (18, 2),
    (19, 2),
    (20, 2),
    (21, 2),
    (22, 2),
    (23, 2),
    (24, 2),
    (25, 2),
    (26, 1),
    (27, 1),
    (28, 1),
    (29, 1),
    (30, 1),
    (31, 1)
;
/*
    notification_types
*/
insert into notification_types(description, color) values 
('INFORMATIVO', 'BLANCO'),
('ACEPTADA', 'VERDE'),
('RECHAZADA', 'ROJO'), 
('CANCELADA', 'NARANJA'),
('ADVERTENCIA', 'AMARILLO');

/*
    notification

insert into notifications(title, description, person_id, notification_type_id) values
    ('EJEMPLO', 'HOLA ESTE ES UN EJEMPLO', 1, 1);



    notification_persons

insert into notification_person(person_id, notification_id) values
(1, 1), 
(3, 1), 
(4, 1);
*/

/*
    careers
*/
insert into   careers(name, created_at, updated_at) 
values 
    ('LICENCIATURA EN INGENIERIA INFORMATICA', NOW(), NOW()), 
    ('LICENCIATURA EN INGENIERIA DE SISTEMAS', NOW(), NOW()), 
    ('LICENCIATURA EN ELECTROMECANICA'       , NOW(), NOW())
;
/*
    university_subjects
*/
insert into university_subjects (name, grade, career_id, created_at, updated_at)
values 
    ('INTRODUCCION A LA PROGRAMACION',              'A', 1, NOW(), NOW()), /*ID 1 */  
    ('ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS',    'B', 1, NOW(), NOW()), /*ID 2 */ 
    ('CALCULO I',                                   'A', 2, NOW(), NOW()), /*ID 3 */ 
    ('CALCULO III',                                 'C', 3, NOW(), NOW()), /*ID 4 */ 
    ('ARQUITECTURA DE COMPUTADORAS I',              'B', 1, NOW(), NOW()), /*ID 5 */
    ('ALGORITMOS AVANZADOS',                        'D', 1, NOW(), NOW()), /*ID 6 */
    ('TALLER DE INGENIERIA DE SOFTWARE',            'G', 1, NOW(), NOW()), /*ID 7 */
    ('FISICA GENERAL',                              'A', 1, NOW(), NOW()), /*ID 8 */
    ('INGLES I',                                    'A', 1, NOW(), NOW()), /*ID 9 */
    ('INGLES II',                                   'B', 1, NOW(), NOW()), /*ID 10 */
    /*-----------------------------------------------------------------------------*/
    ('CALCULO NUMERICO',                            'C', 1, NOW(), NOW()), /*ID 11 */
    ('TEORIA DE GRAFOS',                            'C', 1, NOW(), NOW()), /*ID 12 */
    ('PROGRAMACION FUNCIONAL',                      'D', 1, NOW(), NOW()), /*ID 13 */
    ('BASE DE DATOS I',                             'D', 2, NOW(), NOW()), /*ID 14 */
    ('BASE DE DATOS II',                            'E', 2, NOW(), NOW()), /*ID 15 */
    ('INTELIGENCIA ARTIFICIAL I',                   'E', 1, NOW(), NOW())  /*ID 16 */
;
/*
    teacher_subjects
*/
insert into teacher_subjects (group_number, person_id, university_subject_id, created_at, updated_at)
values 
    (1, 1, 9, NOW(), NOW()),      /* ID 1  |INGLES I - MARIA BENITA*/
    (2, 1, 9, NOW(), NOW()),      /* ID 2  |INGLES I - MARIA BENITA*/
    (3, 2, 9, NOW(), NOW()),      /* ID 3  |INGLES I - PEETERS*/

    (1, 2, 10, NOW(), NOW()),     /* ID 4  |INGLES II - PEETERS*/
    (2, 2, 10, NOW(), NOW()),     /* ID 5  |INGLES II - PEETERS*/

    (1, 14, 1, NOW(), NOW()),     /* ID 6  |INTRODUCCION A LA PROGRAMACION - CARLA*/
    (2, 10, 1, NOW(), NOW()),     /* ID 7  |INTRODUCCION A LA PROGRAMACION - LETI*/
    (3, 11, 1, NOW(), NOW()),     /* ID 8  |INTRODUCCION A LA PROGRAMACION - HERNAN*/
    (4, 12, 1, NOW(), NOW()),     /* ID 9  |INTRODUCCION A LA PROGRAMACION - HENRY*/
    (5, 19, 1, NOW(), NOW()),     /* ID 10 |INTRODUCCION A LA PROGRAMACION - VICTOR HUGO*/
    (6, 14, 1, NOW(), NOW()),     /* ID 11 |INTRODUCCION A LA PROGRAMACION - CARLA*/
    (7, 13, 1, NOW(), NOW()),     /* ID 12 |INTRODUCCION A LA PROGRAMACION - VLADO*/
    (10, 13, 1, NOW(), NOW()),    /* ID 13 |INTRODUCCION A LA PROGRAMACION - VLADO*/

    (1, 15, 2, NOW(), NOW()),     /* ID 14 |ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - ROSEMARY*/
    (2, 10, 2, NOW(), NOW()),     /* ID 15 |ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - LETI*/
    (3, 10, 2, NOW(), NOW()),     /* ID 16 |ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - LETI*/
    (5, 16, 2, NOW(), NOW()),     /* ID 17 |ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - HELDER*/

    (1, 17, 5, NOW(), NOW()),     /* ID 18 |ARQUITECTURA DE COMPUTADORAS I - SAMUEL*/
    (2, 10, 5, NOW(), NOW()),     /* ID 19 |ARQUITECTURA DE COMPUTADORAS I - LETI*/

    (1, 10, 6, NOW(), NOW()),     /* ID 20 |ALGORITMOS AVANZADOS - LETI*/

    (1, 18, 7, NOW(), NOW()),     /* ID 21 |TALLER DE INGENIERIA DE SOFTWARE - CORINA*/
    (2, 10, 7, NOW(), NOW()),     /* ID 22 |TALLER DE INGENIERIA DE SOFTWARE - LETI*/
    
    (1, 4, 3, NOW(), NOW()),      /* ID 23 |CALCULO I - AGUSTIN*/
    
    (1, 12, 8, NOW(), NOW()),     /* ID 24 |FISICA GENERAL - HENRY FRANK*/
    (2, 12, 8, NOW(), NOW()),     /* ID 25 |FISICA GENERAL - HENRY FRANK*/

    /*----------------------------------------------------------------------------------*/

    (1, 20, 11, NOW(), NOW()),    /* ID 26 |CALCULO NUMERICO - DEMETRIO JUCHANI BAZUALDO*/

    (1, 21, 12, NOW(), NOW()),    /* ID 27 |TEORIA DE GRAFOS - YONY RICHARD MONTOYA BURGOS*/

    (1, 22, 13, NOW(), NOW()),    /* ID 28 |PROGRAMACION FUNCIONAL - TATIANA APARICIO YUJA*/

    (2, 23, 14, NOW(), NOW()),    /* ID 29 |BASE DE DATOS I - BORIS CALANCHA NAVIA*/
    (1, 24, 14, NOW(), NOW()),    /* ID 30 |BASE DE DATOS I - VITTER JESUS MEDRANO PEREZ*/

    (1, 22, 15, NOW(), NOW()),    /* ID 31 |BASE DE DATOS II - TATIANA APARICIO YUJA*/
    
    (1, 25, 16, NOW(), NOW())     /* ID 32 |INTELIGENCIA ARTIFICIAL I - TATIANA APARICIO YUJA*/
; 

/*
    block_statuses
*/
insert into block_statuses(name) values
    ('HABILITADO'),
    ('DESHABILITADO'),
    ('ELIMINADO')
;

/*
    blocks
*/
insert into blocks (name, max_floor, block_status_id, max_classrooms)
values 
    ('AULAS INF-LAB',                        0, 1, 20),     /*ID 1*/
    ('EDIFICIO MEMI',                        2, 1, 20),     /*ID 2*/       
    ('EDIFICIO ACADEMICO 2',                 3, 1, 20),     /*ID 3*/    
    ('BLOQUE TRENCITO',                      0, 1, 20),     /*ID 4*/    
    ('BLOQUE CENTRAL - EDIFICIO DECANATURA', 2, 1, 20)      /*ID 5*/    
; 
/*
    classroom_types
*/
insert into classroom_types (description, created_at, updated_at) 
values 
    ('LABORATORIO', NOW(), NOW()), 
    ('AULA',        NOW(), NOW()), 
    ('AUDITORIO',   NOW(), NOW())
;
/*
    classroom_statues
*/
insert into classroom_statuses (name, created_at, updated_at) 
values 
    ('HABILITADO', NOW(), NOW()), 
    ('DESHABILITADO', NOW(), NOW()), 
    ('ELIMINADO', NOW(), NOW())
;

/*
    classroom
*/
insert into classrooms (name, capacity, floor, block_id, classroom_type_id, classroom_status_id, created_at, updated_at)
values 
    ('LABORATORIO DE COMPUTO 1',     50, 0, 1, 1, 1, NOW(), NOW()),          /*ID 1 |AULAS INF-LAB*/ 
    ('LABORATORIO DE COMPUTO 2',     50, 0, 1, 1, 1, NOW(), NOW()),          /*ID 2 |AULAS INF-LAB*/ 
    ('LABORATORIO DE REDES',         25, 0, 1, 1, 1, NOW(), NOW()),          /*ID 3 |AULAS INF-LAB*/ 
    ('LABORATORIO DE DESARROLLO',    25, 0, 1, 1, 1, NOW(), NOW()),          /*ID 4 |AULAS INF-LAB*/ 
    ('LABORATORIO DE MANTENIMIENTO', 25, 0, 1, 1, 1, NOW(), NOW()),          /*ID 5 |AULAS INF-LAB*/ 

    ('LABORATORIO DE COMPUTO 3',  50, 2, 2, 1, 1, NOW(), NOW()),             /*ID 6 |EDIFICIO MEMI*/ 
    ('LABORATORIO DE COMPUTO 4',  50, 2, 2, 1, 1, NOW(), NOW()),             /*ID 7 |EDIFICIO MEMI*/ 
    ('AUDITORIO DE USO MULTIPLE', 75, 2, 2, 3, 1, NOW(), NOW()),             /*ID 8 |EDIFICIO MEMI*/ 

    ('690A', 50, 0, 3, 2, 1, NOW(), NOW()),                /*ID 9  |EDIFICIO ACADEMICO 2*/ 
    ('690B', 50, 0, 3, 2, 1, NOW(), NOW()),                /*ID 10 |EDIFICIO ACADEMICO 2*/ 
    ('690C', 50, 0, 3, 2, 1, NOW(), NOW()),                /*ID 11 |EDIFICIO ACADEMICO 2*/ 
    ('690D', 50, 0, 3, 2, 1, NOW(), NOW()),                /*ID 12 |EDIFICIO ACADEMICO 2*/ 
    ('690E', 50, 0, 3, 2, 1, NOW(), NOW()),                /*ID 13 |EDIFICIO ACADEMICO 2*/ 
    ('690MAT', 50, 0, 3, 2, 1, NOW(), NOW()),              /*ID 14 |EDIFICIO ACADEMICO 2*/ 
    
    ('691A', 100, 1, 3, 2, 1, NOW(), NOW()),               /*ID 15 |EDIFICIO ACADEMICO 2*/ 
    ('691B', 100, 1, 3, 2, 1, NOW(), NOW()),               /*ID 16 |EDIFICIO ACADEMICO 2*/ 
    ('691C', 100, 1, 3, 2, 1, NOW(), NOW()),               /*ID 17 |EDIFICIO ACADEMICO 2*/ 
    ('691D', 100, 1, 3, 2, 1, NOW(), NOW()),               /*ID 18 |EDIFICIO ACADEMICO 2*/ 
    ('691E', 100, 1, 3, 2, 1, NOW(), NOW()),               /*ID 19 |EDIFICIO ACADEMICO 2*/ 
    ('691F', 100, 1, 3, 2, 1, NOW(), NOW()),               /*ID 20 |EDIFICIO ACADEMICO 2*/ 

    ('692A', 100, 2, 3, 2, 1, NOW(), NOW()),               /*ID 21 |EDIFICIO ACADEMICO 2*/ 
    ('692B', 100, 2, 3, 2, 1, NOW(), NOW()),               /*ID 22 |EDIFICIO ACADEMICO 2*/ 
    ('692C', 100, 2, 3, 2, 1, NOW(), NOW()),               /*ID 23 |EDIFICIO ACADEMICO 2*/ 
    ('692D', 100, 2, 3, 2, 1, NOW(), NOW()),               /*ID 24 |EDIFICIO ACADEMICO 2*/ 
    ('692E', 100, 2, 3, 2, 1, NOW(), NOW()),               /*ID 25 |EDIFICIO ACADEMICO 2*/ 
    ('692F', 100, 2, 3, 2, 1, NOW(), NOW()),               /*ID 26 |EDIFICIO ACADEMICO 2*/ 
    ('692G', 75, 2, 3, 2, 1,  NOW(), NOW()),               /*ID 27 |EDIFICIO ACADEMICO 2*/ 
    ('692H', 75, 2, 3, 2, 1,  NOW(), NOW()),               /*ID 28 |EDIFICIO ACADEMICO 2*/ 

    ('693A', 100, 2, 3, 2, 1,        NOW(), NOW()),        /*ID 29 |EDIFICIO ACADEMICO 2*/ 
    ('693B', 100, 2, 3, 2, 1,        NOW(), NOW()),        /*ID 30 |EDIFICIO ACADEMICO 2*/ 
    ('693C', 100, 2, 3, 2, 1,        NOW(), NOW()),        /*ID 31 |EDIFICIO ACADEMICO 2*/ 
    ('693D', 100, 2, 3, 2, 1,        NOW(), NOW()),        /*ID 32 |EDIFICIO ACADEMICO 2*/ 
    ('AUDITORIO 2', 300, 2, 3, 3, 1, NOW(), NOW()),        /*ID 33 |EDIFICIO ACADEMICO 2*/ 

    ('660', 100, 0, 4, 2, 1, NOW(), NOW()),                /*ID 34 |BLOQUE TRENCITO*/ 
    ('661', 100, 0, 4, 2, 1, NOW(), NOW()),                /*ID 35 |BLOQUE TRENCITO*/ 

    ('651', 50, 0, 5, 2, 1, NOW(), NOW()),                 /*ID 36 |BLOQUE CENTRAL - EDIFICIO DECANATURA*/ 
    ('652', 50, 0, 5, 2, 1, NOW(), NOW()),                 /*ID 37 |BLOQUE CENTRAL - EDIFICIO DECANATURA*/ 
    ('655', 50, 0, 5, 2, 1, NOW(), NOW())                  /*ID 38 |BLOQUE CENTRAL - EDIFICIO DECANATURA*/ 
;

/*
    reservation_status
*/
insert into reservation_statuses (status, created_at, updated_at)
values 
    ('ACEPTADO',                NOW(), NOW()),  /*ID 1*/
    ('RECHAZADO',               NOW(), NOW()),  /*ID 2*/  
    ('PENDIENTE',               NOW(), NOW()),  /*ID 3*/ 
    ('CANCELADO',               NOW(), NOW()),  /*ID 4*/
    ('EXPIRADO ACEPTADO',       NOW(), NOW()),  /*ID 5*/
    ('EXPIRADO RECHAZADO',      NOW(), NOW()),  /*ID 6*/
    ('EXPIRADO PENDIENTE',      NOW(), NOW())   /*ID 7*/
; 

/*
    reservation_reasons
*/
insert into reservation_reasons (reason, created_at, updated_at) 
values 
    ('EXAMEN',           NOW(), NOW()), /*ID 1*/ 
    ('CLASES',           NOW(), NOW()), /*ID 2*/
    ('DEFENSA DE TESIS', NOW(), NOW()), /*ID 3*/
    ('PRACTICA',         NOW(), NOW())  /*ID 4*/
;

/*
    time_slot
*/
insert into time_slots(time, created_at, updated_at)
values
    ('06:45:00', NOW(), NOW()), /*ID 1*/
    ('07:30:00', NOW(), NOW()), /*ID 2*/
    ('08:15:00', NOW(), NOW()), /*ID 3*/
    ('09:00:00', NOW(), NOW()), /*ID 4*/
    ('09:45:00', NOW(), NOW()), /*ID 5*/
    ('10:30:00', NOW(), NOW()), /*ID 6*/
    ('11:15:00', NOW(), NOW()), /*ID 7*/
    ('12:00:00', NOW(), NOW()), /*ID 8*/
    ('12:45:00', NOW(), NOW()), /*ID 9*/
    ('13:30:00', NOW(), NOW()), /*ID 10*/
    ('14:15:00', NOW(), NOW()), /*ID 11*/
    ('15:00:00', NOW(), NOW()), /*ID 12*/
    ('15:45:00', NOW(), NOW()), /*ID 13*/
    ('16:30:00', NOW(), NOW()), /*ID 14*/
    ('17:15:00', NOW(), NOW()), /*ID 15*/
    ('18:00:00', NOW(), NOW()), /*ID 16*/
    ('18:45:00', NOW(), NOW()), /*ID 17*/
    ('19:30:00', NOW(), NOW()), /*ID 18*/
    ('20:15:00', NOW(), NOW()), /*ID 19*/
    ('21:00:00', NOW(), NOW()), /*ID 20*/
    ('21:45:00', NOW(), NOW())  /*ID 21*/
; 

/* siempre hay un problema desde aqui <:V
    reservation
*/
insert into reservations (number_of_students, `repeat`, observation, priority, `date`, parent_id, reservation_reason_id, reservation_status_id, created_at, updated_at)
VALUES
    (125, 7, 'Ninguna', 0, '2024-04-23', 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Ninguna', 0, '2024-04-26', 2, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Ninguna', 0, '2024-04-23', 3, 2, 1, NOW(), NOW()),         /*3 INGLES I - GRUPO 2*/
    (125, 7, 'Ninguna', 0, '2024-04-26', 4, 2, 1, NOW(), NOW()),         /*4 INGLES I - GRUPO 2*/

    (125, 7, 'Ninguna', 0, '2024-04-22', 5, 2, 1, NOW(), NOW()),         /*5 INGLES I - GRUPO 3*/
    (125, 7, 'Ninguna', 0, '2024-04-24', 6, 2, 1, NOW(), NOW()),         /*6 INGLES I - GRUPO 3*/

    (80,  7, 'Ninguna', 0, '2024-04-23', 7, 2, 1, NOW(), NOW()),         /*7 INGLES II - GRUPO 1*/
    (80,  7, 'Ninguna', 0, '2024-04-25', 8, 2, 1, NOW(), NOW()),         /*8 INGLES II - GRUPO 1*/

    (80,  7, 'Ninguna', 0, '2024-04-25', 9, 2, 1, NOW(), NOW()),         /*9  INGLES II - GRUPO 2*/
    (80,  7, 'Ninguna', 0, '2024-04-26', 10, 2, 1, NOW(), NOW()),        /*10 INGLES II - GRUPO 2*/

    (150, 7, 'Ninguna', 0, '2024-04-25', 11, 2, 1, NOW(), NOW()),        /*11 INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (150, 7, 'Ninguna', 0, '2024-04-26', 12, 2, 1, NOW(), NOW()),        /*12 INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (150, 7, 'Ninguna', 0, '2024-04-26', 13, 2, 1, NOW(), NOW()),        /*13 INTRODUCCION A LA PROGRAMACION - GRUPO 1*/

    (150, 7, 'Ninguna', 0, '2024-04-22', 14, 2, 1, NOW(), NOW()),        /*14 INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (150, 7, 'Ninguna', 0, '2024-04-24', 15, 2, 1, NOW(), NOW()),        /*15 INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (150, 7, 'Ninguna', 0, '2024-04-26', 16, 2, 1, NOW(), NOW()),        /*16 INTRODUCCION A LA PROGRAMACION - GRUPO 2*/

    (150, 7, 'Ninguna', 0, '2024-04-22', 17, 2, 1, NOW(), NOW()),        /*17 INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (150, 7, 'Ninguna', 0, '2024-04-24', 18, 2, 1, NOW(), NOW()),        /*18 INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (150, 7, 'Ninguna', 0, '2024-04-26', 19, 2, 1, NOW(), NOW()),        /*19 INTRODUCCION A LA PROGRAMACION - GRUPO 3*/

    (150, 7, 'Ninguna', 0, '2024-04-23', 20, 2, 1, NOW(), NOW()),         /*20 INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (150, 7, 'Ninguna', 0, '2024-04-24', 21, 2, 1, NOW(), NOW()),         /*21 INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (150, 7, 'Ninguna', 0, '2024-04-26', 22, 2, 1, NOW(), NOW()),         /*22 INTRODUCCION A LA PROGRAMACION - GRUPO 4*/

    (150, 7, 'Ninguna', 0, '2024-04-24', 23, 2, 1, NOW(), NOW()),         /*23 INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (150, 7, 'Ninguna', 0, '2024-04-25', 24, 2, 1, NOW(), NOW()),         /*24 INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (150, 7, 'Ninguna', 0, '2024-04-27', 25, 2, 1, NOW(), NOW()),         /*25 INTRODUCCION A LA PROGRAMACION - GRUPO 5*/

    (150, 7, 'Ninguna', 0, '2024-04-24', 26, 2, 1, NOW(), NOW()),         /*26 INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (150, 7, 'Ninguna', 0, '2024-04-25', 27, 2, 1, NOW(), NOW()),         /*27 INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (150, 7, 'Ninguna', 0, '2024-04-27', 28, 2, 1, NOW(), NOW()),         /*28 INTRODUCCION A LA PROGRAMACION - GRUPO 6*/

    (150, 7, 'Ninguna', 0, '2024-04-23', 29, 2, 1, NOW(), NOW()),         /*29 INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (150, 7, 'Ninguna', 0, '2024-04-24', 30, 2, 1, NOW(), NOW()),         /*30 INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (150, 7, 'Ninguna', 0, '2024-04-25', 31, 2, 1, NOW(), NOW()),         /*31 INTRODUCCION A LA PROGRAMACION - GRUPO 7*/

    (150, 7, 'Ninguna', 0, '2024-04-23', 32, 2, 1, NOW(), NOW()),         /*32 INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (150, 7, 'Ninguna', 0, '2024-04-25', 33, 2, 1, NOW(), NOW()),         /*33 INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (150, 7, 'Ninguna', 0, '2024-04-25', 34, 2, 1, NOW(), NOW()),         /*34 INTRODUCCION A LA PROGRAMACION - GRUPO 10*/

    (100, 7, 'Ninguna', 0, '2024-04-23', 35, 2, 1, NOW(), NOW()),         /*35 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (100, 7, 'Ninguna', 0, '2024-04-24', 36, 2, 1, NOW(), NOW()),         /*36 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (100, 7, 'Ninguna', 0, '2024-04-26', 37, 2, 1, NOW(), NOW()),         /*37 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/

    (100, 7, 'Ninguna', 0, '2024-04-22', 38, 2, 1, NOW(), NOW()),         /*38 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (100, 7, 'Ninguna', 0, '2024-04-24', 39, 2, 1, NOW(), NOW()),         /*39 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (100, 7, 'Ninguna', 0, '2024-04-25', 40, 2, 1, NOW(), NOW()),         /*40 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/

    (100, 7, 'Ninguna', 0, '2024-04-23', 41, 2, 1, NOW(), NOW()),         /*41 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (100, 7, 'Ninguna', 0, '2024-04-24', 42, 2, 1, NOW(), NOW()),         /*42 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (100, 7, 'Ninguna', 0, '2024-04-25', 43, 2, 1, NOW(), NOW()),         /*43 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/

    (100, 7, 'Ninguna', 0, '2024-04-22', 44, 2, 1, NOW(), NOW()),         /*44 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (100, 7, 'Ninguna', 0, '2024-04-23', 45, 2, 1, NOW(), NOW()),         /*45 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (100, 7, 'Ninguna', 0, '2024-04-25', 46, 2, 1, NOW(), NOW()),         /*46 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/

    (80,  7, 'Ninguna', 0, '2024-04-22', 47, 2, 1, NOW(), NOW()),         /*47 ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (80,  7, 'Ninguna', 0, '2024-04-23', 48, 2, 1, NOW(), NOW()),         /*48 ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/

    (80,  7, 'Ninguna', 0, '2024-04-22', 49, 2, 1, NOW(), NOW()),         /*49 ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (80,  7, 'Ninguna', 0, '2024-04-25', 50, 2, 1, NOW(), NOW()),         /*50 ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/

    (40,  7, 'Ninguna', 0, '2024-04-23', 51, 2, 1, NOW(), NOW()),         /*51 ALGORITMOS AVANZADOS - GRUPO 1*/
    (40,  7, 'Ninguna', 0, '2024-04-25', 52, 2, 1, NOW(), NOW()),         /*52 ALGORITMOS AVANZADOS - GRUPO 1*/
    (40,  7, 'Ninguna', 0, '2024-04-26', 53, 2, 1, NOW(), NOW()),         /*53 ALGORITMOS AVANZADOS - GRUPO 1*/

    (50,  7, 'Ninguna', 0, '2024-04-22', 54, 2, 1, NOW(), NOW()),         /*54 TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (50,  7, 'Ninguna', 0, '2024-04-23', 55, 2, 1, NOW(), NOW()),         /*55 TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/

    (50,  7, 'Ninguna', 0, '2024-04-23', 56, 2, 1, NOW(), NOW()),         /*56 TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (50,  7, 'Ninguna', 0, '2024-04-24', 57, 2, 1, NOW(), NOW()),         /*57 TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    /*-------------------------------------------------------------------------------------------------*/

    (150, 0, 'Ninguna', 0, '2024-07-23', 58, 1, 1, NOW(), NOW()),         /*58 INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6 - CLASSROOMS ID: 5, 8, 14*/
    
    (100, 0, 'Ninguna', 0, '2024-07-24', 59, 1, 1, NOW(), NOW()),         /*59 CALCULO I - GRUPO 1 - CLASSROOMS ID: 20*/
    
    (75,  0, 'Ninguna', 0, '2024-07-25', 60, 1, 1, NOW(), NOW()),         /*60 ARQUITECTURA DE COMPUTADORAS I - GRUPO 1 - CLASSROOMS ID: 28*/
    
    (200, 0, 'Ninguna', 0, '2024-07-26', 61, 1, 3, NOW(), NOW()),         /*61 ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1, 2, 3 - CLASSROOMS ID: 33*/
    (220, 0, 'Ninguna', 0, '2024-07-26', 62, 1, 3, NOW(), NOW()),         /*62 FISICA GENERAL - GRUPO 1, 2 - CLASSROOMS ID: 33*/
    (350, 0, 'Ninguna', 0, '2024-07-26', 63, 1, 3, NOW(), NOW()),         /*63 INTRODUCCION A LA PROGRAMACION - GRUPO 7, 10 - CLASSROOMS ID: 33*/

    (100, 0, 'Ninguna', 0, '2024-07-29', 64, 1, 1, NOW(), NOW()),         /*64 INGLES II - GRUPO 1, 2 - CLASSROOMS ID: 35*/
    
    (50,  0, 'Ninguna', 0, '2024-07-30', 65, 1, 1, NOW(), NOW()),         /*65 TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2 - CLASSROOMS ID: 38*/

    /*-------------------------------------------------------------------------------------------------*/

    (250, 0, 'Ninguna', 0, '2024-06-21', 66, 1, 3, NOW(), NOW()),          /*66 CALCULO NUMERICO - GRUPO 1*/
    (100, 0, 'Ninguna', 0, '2024-06-20', 67, 1, 3, NOW(), NOW()),          /*67 CALCULO NUMERICO - GRUPO 1*/
    (200, 0, 'Ninguna', 0, '2024-05-15', 68, 4, 2, NOW(), NOW()),          /*68 CALCULO NUMERICO - GRUPO 1*/
    (250, 0, 'Ninguna', 0, '2024-05-22', 69, 4, 2, NOW(), NOW()),          /*69 CALCULO NUMERICO - GRUPO 1*/

    (225, 0, 'Ninguna', 0, '2024-06-21', 70, 1, 3, NOW(), NOW()),          /*70 TEORIA DE GRAFOS - GRUPO 1*/
    (100, 0, 'Ninguna', 0, '2024-06-20', 71, 1, 3, NOW(), NOW()),          /*71 TEORIA DE GRAFOS - GRUPO 1*/
    (175, 0, 'Ninguna', 0, '2024-05-15', 72, 1, 1, NOW(), NOW()),          /*72 TEORIA DE GRAFOS - GRUPO 1*/
    (200, 0, 'Ninguna', 0, '2024-05-22', 73, 1, 1, NOW(), NOW()),          /*73 TEORIA DE GRAFOS - GRUPO 1*/
    (80,  0, 'Ninguna', 0, '2024-07-19', 74, 1, 4, NOW(), NOW()),          /*74 TEORIA DE GRAFOS - GRUPO 1*/

    (75,  7, 'Ninguna', 0, '2024-06-07', 75, 2, 2, NOW(), NOW()),          /*75 PROGRAMACION FUNCIONAL - GRUPO 1*/
    (150, 7, 'Ninguna', 0, '2024-06-10', 76, 2, 3, NOW(), NOW()),          /*76 PROGRAMACION FUNCIONAL - GRUPO 1*/
    (175, 0, 'Ninguna', 0, '2024-06-11', 77, 1, 3, NOW(), NOW()),          /*77 PROGRAMACION FUNCIONAL - GRUPO 1*/
    (50,  0, 'Ninguna', 0, '2024-04-24', 78, 3, 4, NOW(), NOW()),          /*78 PROGRAMACION FUNCIONAL - GRUPO 1*/
    (50,  0, 'Ninguna', 0, '2024-04-25', 79, 3, 4, NOW(), NOW()),          /*79 PROGRAMACION FUNCIONAL - GRUPO 1*/

    (90,  0, 'Ninguna', 0, '2024-06-07', 80, 1, 1, NOW(), NOW()),          /*80 BASE DE DATOS I - GRUPO 2*/
    (120, 0, 'Ninguna', 0, '2024-06-10', 81, 1, 3, NOW(), NOW()),          /*81 BASE DE DATOS I - GRUPO 2*/
    (200, 0, 'Ninguna', 0, '2024-06-11', 82, 4, 3, NOW(), NOW()),          /*82 BASE DE DATOS I - GRUPO 1*/
    (150, 0, 'Ninguna', 0, '2024-05-15', 83, 4, 2, NOW(), NOW()),          /*83 BASE DE DATOS I - GRUPO 1*/

    (200, 0, 'Ninguna', 0, '2024-06-05', 84, 1, 3, NOW(), NOW()),          /*84 BASE DE DATOS II - GRUPO 1*/
    (200, 0, 'Ninguna', 0, '2024-06-06', 85, 1, 1, NOW(), NOW()),          /*85 BASE DE DATOS II - GRUPO 1*/

    (300, 0, 'Ninguna', 0, '2024-06-20', 86, 1, 3, NOW(), NOW()),          /*86 INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (200, 7, 'Ninguna', 0, '2024-06-06', 87, 2, 2, NOW(), NOW()),          /*87 INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (100, 0, 'Ninguna', 0, '2024-05-15', 88, 3, 4, NOW(), NOW()),          /*88 INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (75,  0, 'Ninguna', 0, '2024-05-15', 89, 4, 1, NOW(), NOW()),          /*89 INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    /*-------------------------------------------------------------------------------------------------*/

    (100, 0, 'Ninguna', 0, '2024-08-01', 90, 1, 2, NOW(), NOW()),          /*90 INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (150, 0, 'Ninguna', 0, '2024-08-02', 91, 4, 4, NOW(), NOW()),          /*91 BASE DE DATOS II - GRUPO 1*/

    (125, 0, 'Ninguna', 0, '2024-08-06', 92, 1, 2, NOW(), NOW()),          /*92 BASE DE DATOS I - GRUPO 1*/

    (90,  0, 'Ninguna', 0, '2024-08-07', 93, 4, 4, NOW(), NOW()),          /*93 PROGRAMACION FUNCIONAL - GRUPO 1*/

    (100, 0, 'Ninguna', 0, '2024-08-08', 94, 1, 2, NOW(), NOW()),          /*94 TEORIA DE GRAFOS - GRUPO 1*/

    (150, 0, 'Ninguna', 0, '2024-08-09', 95, 1, 4, NOW(), NOW()),          /*95 CALCULO NUMERICO - GRUPO 1*/

    (1000, 0, 'Examen de ingreso', 1, '2024-08-01', 96, 1, 1, NOW(), NOW()),        /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (1000, 0, 'Examen de ingreso', 1, '2024-08-02', 96, 1, 1, NOW(), NOW()),        /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (1000, 0, 'Examen de ingreso', 1, '2024-08-03', 96, 1, 1, NOW(), NOW()),        /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (1000, 0, 'Examen de ingreso', 1, '2024-08-04', 96, 1, 1, NOW(), NOW()),        /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (1000, 0, 'Examen de ingreso', 1, '2024-08-05', 96, 1, 1, NOW(), NOW()),        /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (1000, 0, 'Examen de ingreso', 1, '2024-08-06', 96, 1, 1, NOW(), NOW()),        /*101 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (1000, 0, 'Examen de ingreso', 1, '2024-08-07', 96, 1, 1, NOW(), NOW()),        /*102 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (1000, 0, 'Examen de ingreso', 1, '2024-08-08', 96, 1, 1, NOW(), NOW()),        /*103 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (1000, 0, 'Examen de ingreso', 1, '2024-08-09', 96, 1, 1, NOW(), NOW())         /*104 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
;
/*
lunes:     '2024-04-22'
martes:    '2024-04-23'
miercoles: '2024-04-24'
jueves:    '2024-04-25'
viernes:   '2024-04-26'
sabado:    '2024-04-27'
domingo:   '2024-04-28'
*/

/*
    reservation_classrooms
*/
insert into classroom_reservation (reservation_id, classroom_id, created_at, updated_at)
values 
    (1, 30, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (2, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (3, 12, NOW(), NOW()),              /*INGLES I - GRUPO 2*/
    (4, 12, NOW(), NOW()),              /*INGLES I - GRUPO 2*/

    (5, 33, NOW(), NOW()),              /*INGLES I - GRUPO 3*/
    (6, 28, NOW(), NOW()),              /*INGLES I - GRUPO 3*/

    (7,  3, NOW(), NOW()),              /*INGLES II - GRUPO 1*/
    (8, 35, NOW(), NOW()),              /*INGLES II - GRUPO 1*/

    ( 9, 16, NOW(), NOW()),              /*INGLES II - GRUPO 2*/
    (10, 17, NOW(), NOW()),              /*INGLES II - GRUPO 2*/

    (11, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (12, 19, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (13,  8, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/

    (14, 14, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (15, 16, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (16, 14, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/

    (17, 34, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (18, 34, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (19, 34, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/

    (20, 4, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (21, 4, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (22, 4, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/

    (23, 10, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (24,  4, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (25, 17, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/

    (26, 24, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (27, 19, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (28, 35, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/

    (29, 11, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (30, 25, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (31, 20, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/

    (32, 16, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (33, 15, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (34, 16, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/

    (35,  4, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (36,  4, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (37, 11, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/

    (38, 34, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (39, 34, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (40, 35, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/

    (41, 35, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (42, 17, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (43, 11, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/

    (44, 16, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (45, 38, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (46, 32, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/

    (47,  5, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (48, 12, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/

    (49, 16, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (50, 38, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/

    (51, 17, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (52, 12, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (53, 32, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/

    (54, 12, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (55, 13, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/

    (56, 36, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (57,  1, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    /*------------------------------------------------------------------------------*/

    (58, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6*/
    (58, 8, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6*/
    (58, 14, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6*/
    
    (59, 20, NOW(), NOW()),             /*CALCULO I - GRUPO 1*/
    
    (60, 28, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    
    (61, 33, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1, 2, 3*/
    (62, 33, NOW(), NOW()),             /*FISICA GENERAL - GRUPO 1, 2*/
    (63, 33, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7, 10*/
    
    (64, 35, NOW(), NOW()),             /*INGLES II - GRUPO 1, 2*/
    
    (65, 38, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    /*------------------------------------------------------------------------------*/

    (66, 9, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (66, 10, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (66, 11, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (66, 12, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    (67, 3, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/

    (68, 29, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (68, 30, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (68, 31, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    (69, 32, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (69, 33, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    (70, 9, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (70, 10, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (70, 11, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (70, 12, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (71, 3, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/

    (72, 29, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (72, 30, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (72, 31, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (73, 32, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (73, 33, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (74, 26, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (75, 36, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (75, 37, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (76, 21, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (76, 24, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (76, 28, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (77, 34, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (78, 36, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (79, 8, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (80, 36, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/
    (80, 37, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/

    (81, 21, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/
    (81, 24, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/
    (81, 28, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/

    (82, 34, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (82, 35, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/

    (83, 11, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (83, 12, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (83, 13, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (83, 15, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/

    (84, 33, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/

    (85, 29, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (85, 30, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/

    (86, 33, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (87, 29, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (87, 30, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (88, 35, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (88, 36, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (89, 11, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (89, 12, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    /*------------------------------------------------------------------------------*/

    (90, 9, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (90, 10, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (91, 15, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (91, 16, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/

    (92, 13, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (92, 15, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/

    (93, 21, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (94, 26, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (95, 27, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (95, 28, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    /*RESERVACION ESPECIAL POR DIA SE RESERVAN LOS AMBIENTES*/

    (96, 9, NOW(), NOW()),              /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 10, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 11, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 12, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 13, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 14, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 17, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 18, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 19, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 20, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 21, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 22, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 23, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 24, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 25, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 26, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 27, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 28, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 29, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 30, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 31, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 32, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 33, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (97, 9, NOW(), NOW()),              /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 10, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 11, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 12, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 13, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 14, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 15, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 16, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 17, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 18, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 19, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 20, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 21, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 22, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 23, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 24, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 25, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 26, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 27, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 28, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 29, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 30, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 31, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 32, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 33, NOW(), NOW()),             /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (98, 9, NOW(), NOW()),              /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 10, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 11, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 12, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 13, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 14, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 15, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 16, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 17, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 18, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 19, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 20, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 21, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 22, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 23, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 24, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 25, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 26, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 27, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 28, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 29, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 30, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 31, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 32, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 33, NOW(), NOW()),             /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (99, 9, NOW(), NOW()),              /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 10, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 11, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 12, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 13, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 14, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 15, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 16, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 17, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 18, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 19, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 20, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 21, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 22, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 23, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 24, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 25, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 26, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 27, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 28, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 29, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 30, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 31, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 32, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 33, NOW(), NOW()),             /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (100, 9, NOW(), NOW()),             /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 10, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 11, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 12, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 13, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 14, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 15, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 16, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 17, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 18, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 19, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 20, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 21, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 22, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 23, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 24, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 25, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 26, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 27, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 28, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 29, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 30, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 31, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 32, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 33, NOW(), NOW()),            /*100  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (101, 9, NOW(), NOW()),             /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 10, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 11, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 12, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 13, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 14, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 15, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 16, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 17, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 18, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 19, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 20, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 21, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 22, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 23, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 24, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 25, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 26, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 27, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 28, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 29, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 30, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 31, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 32, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 33, NOW(), NOW()),            /*101  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (102, 9, NOW(), NOW()),             /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 10, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 11, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 12, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 13, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 14, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 15, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 16, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 17, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 18, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 19, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 20, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 21, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 22, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 23, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 24, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 25, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 26, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 27, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 28, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 29, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 30, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 31, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 32, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 33, NOW(), NOW()),            /*102  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (103, 9, NOW(), NOW()),             /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 10, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 11, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 12, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 13, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 14, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 15, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 16, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 17, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 18, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 19, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 20, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 21, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 22, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 23, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 24, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 25, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 26, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 27, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 28, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 29, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 30, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 31, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 32, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 33, NOW(), NOW()),            /*103  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (104, 9, NOW(), NOW()),             /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 10, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 11, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 12, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 13, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 14, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 15, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 16, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 17, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 18, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 19, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 20, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 21, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 22, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 23, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 24, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 25, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 26, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 27, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 28, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 29, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 30, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 31, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 32, NOW(), NOW()),            /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 33, NOW(), NOW())             /*104  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
; 
/*
	reservation_teacher_subject
*/
insert into reservation_teacher_subject (reservation_id, teacher_subject_id, created_at, updated_at)
values 
    (1, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (2, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (3, 2, NOW(), NOW()),              /*INGLES I - GRUPO 2*/
    (4, 2, NOW(), NOW()),              /*INGLES I - GRUPO 2*/

    (5, 3, NOW(), NOW()),              /*INGLES I - GRUPO 3*/
    (6, 3, NOW(), NOW()),              /*INGLES I - GRUPO 3*/

    (7, 4, NOW(), NOW()),              /*INGLES II - GRUPO 1*/
    (8, 4, NOW(), NOW()),              /*INGLES II - GRUPO 1*/

    (9, 5, NOW(), NOW()),              /*INGLES II - GRUPO 2*/
    (10, 5, NOW(), NOW()),              /*INGLES II - GRUPO 2*/

    (11, 6, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (12, 6, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (13, 6, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/

    (14, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (15, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (16, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/

    (17, 8, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (18, 8, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (19, 8, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/

    (20, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (21, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (22, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/

    (23, 10, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (24, 10, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (25, 10, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/

    (26, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (27, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (28, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/

    (29, 12, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (30, 12, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (31, 12, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/

    (32, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (33, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (34, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/

    (35, 14, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (36, 14, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (37, 14, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/

    (38, 15, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (39, 15, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (40, 15, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/

    (41, 16, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (42, 16, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (43, 16, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/

    (44, 17, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (45, 17, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (46, 17, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/

    (47, 18, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (48, 18, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/

    (49, 19, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (50, 19, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/

    (51, 20, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (52, 20, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (53, 20, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/

    (54, 21, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (55, 21, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/

    (56, 22, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (57, 22, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    /*-------------------------------------------------------------------------------*/

    (58, 6, NOW(), NOW()),               /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (58, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    
    (59, 23, NOW(), NOW()),              /*CALCULO I - GRUPO 1*/
        
    (60, 18, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    
    (61, 14, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (61, 15, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (61, 16, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    
    (62, 24, NOW(), NOW()),              /*FISICA GENERAL - GRUPO 1*/
    (62, 25, NOW(), NOW()),              /*FISICA GENERAL - GRUPO 2*/
    
    (63, 12, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (63, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    
    (64, 4, NOW(), NOW()),               /*INGLES II - GRUPO 1*/
    (64, 5, NOW(), NOW()),               /*INGLES II - GRUPO 2*/
    
    (65, 22, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    /*-------------------------------------------------------------------------------*/

    (66, 26, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (67, 26, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (68, 26, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (69, 26, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/

    (70, 27, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (71, 27, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (72, 27, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (73, 27, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (74, 27, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/

    (75, 28, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (76, 28, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (77, 28, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (78, 28, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (79, 28, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (80, 29, NOW(), NOW()),              /*BASE DE DATOS I - GRUPO 2*/
    (81, 29, NOW(), NOW()),              /*BASE DE DATOS I - GRUPO 2*/
    (82, 30, NOW(), NOW()),              /*BASE DE DATOS I - GRUPO 1*/
    (83, 30, NOW(), NOW()),              /*BASE DE DATOS I - GRUPO 1*/

    (84, 31, NOW(), NOW()),              /*BASE DE DATOS II - GRUPO 1*/
    (85, 31, NOW(), NOW()),              /*BASE DE DATOS II - GRUPO 1*/

    (86, 32, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (87, 32, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (88, 32, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (89, 32, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    /*-------------------------------------------------------------------------------*/

    (90, 32, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (91, 31, NOW(), NOW()),              /*BASE DE DATOS II - GRUPO 1*/

    (92, 30, NOW(), NOW()),              /*BASE DE DATOS I - GRUPO 1*/

    (93, 28, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (94, 27, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/

    (95, 26, NOW(), NOW())               /*CALCULO NUMERICO - GRUPO 1*/

    /*LAS RESERVACIONES ESPECIALES NO CUENTAN CON UN "reservation_teacher_subject"*/
; 
/*
    time_slot_reservations
*/
insert into reservation_time_slot (reservation_id, time_slot_id, created_at, updated_at)
values
    (1, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (1, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (2, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (2, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (3, 7, NOW(), NOW()),              /*INGLES I - GRUPO 2*/
    (3, 9, NOW(), NOW()),              /*INGLES I - GRUPO 2*/
    (4, 5, NOW(), NOW()),              /*INGLES I - GRUPO 2*/
    (4, 7, NOW(), NOW()),              /*INGLES I - GRUPO 2*/

    (5, 1, NOW(), NOW()),              /*INGLES I - GRUPO 3*/
    (5, 3, NOW(), NOW()),              /*INGLES I - GRUPO 3*/
    (6, 1, NOW(), NOW()),              /*INGLES I - GRUPO 3*/
    (6, 3, NOW(), NOW()),              /*INGLES I - GRUPO 3*/

    (7, 5, NOW(), NOW()),              /*INGLES II - GRUPO 1*/
    (7, 7, NOW(), NOW()),              /*INGLES II - GRUPO 1*/
    (8, 1, NOW(), NOW()),              /*INGLES II - GRUPO 1*/
    (8, 3, NOW(), NOW()),              /*INGLES II - GRUPO 1*/

    ( 9, 5, NOW(), NOW()),              /*INGLES II - GRUPO 2*/
    ( 9, 7, NOW(), NOW()),              /*INGLES II - GRUPO 2*/
    (10, 5, NOW(), NOW()),              /*INGLES II - GRUPO 2*/
    (10, 7, NOW(), NOW()),              /*INGLES II - GRUPO 2*/

    (11, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (11, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (12, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (12, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (13, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    (13, 17, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/

    (14, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (14, 17, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (15, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (15, 17, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (16, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (16, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/

    (17,  9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (17, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (18,  9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (18, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (19,  9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (19, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/

    (20, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (20, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (21, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (21, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (22, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (22, 17, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/

    (23, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (23, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (24, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (24, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (25, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (25, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/

    (26, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (26, 17, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (27, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (27, 17, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (28, 3, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (28, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/

    (29,  9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (29, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (30, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (30, 15, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (31, 3, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (31, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/

    (32, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (32, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (33, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (33, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (34, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (34, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/

    (35, 3, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (35, 5, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (36, 7, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (36, 9, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (37, 3, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (37, 5, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/

    (38,  9, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (38, 11, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (39, 13, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (39, 15, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (40,  9, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (40, 11, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/

    (41, 17, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (41, 19, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (42, 1, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (42, 3, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (43, 9, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (43, 11, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/

    (44,  9, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (44, 11, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (45, 11, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (45, 13, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (46, 11, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (46, 13, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/

    (47, 15, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (47, 17, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (48,  7, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (48,  9, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/

    (49,  9, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (49, 11, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (50,  9, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (50, 11, NOW(), NOW()),              /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/

    (51, 1, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (51, 3, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (52, 1, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (52, 3, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (53, 1, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (53, 3, NOW(), NOW()),              /*ALGORITMOS AVANZADOS - GRUPO 1*/

    (54, 5, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (54, 7, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (55, 5, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (55, 7, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/

    (56, 3, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (56, 5, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (57, 3, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (57, 5, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    /*------------------------------------------------------------------------------*/

    (58, 3, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6*/
    (58, 5, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6*/
    
    (59, 5, NOW(), NOW()),              /*CALCULO I - GRUPO 1*/
    (59, 7, NOW(), NOW()),              /*CALCULO I - GRUPO 1*/
    
    (60, 17, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (60, 19, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    
    (61, 3, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1, 2, 3*/
    (61, 7, NOW(), NOW()),              /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1, 2, 3*/
    
    (62, 3, NOW(), NOW()),              /*FISICA GENERAL - GRUPO 1, 2*/
    (62, 7, NOW(), NOW()),              /*FISICA GENERAL - GRUPO 1, 2*/
    
    (63, 3, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7, 10*/
    (63, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 7, 10*/
    
    (64, 11, NOW(), NOW()),             /*INGLES II - GRUPO 1, 2*/
    (64, 13, NOW(), NOW()),             /*INGLES II - GRUPO 1, 2*/
    
    (65, 1, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (65, 3, NOW(), NOW()),              /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    /*------------------------------------------------------------------------------*/

    (66, 7, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (66, 9, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/

    (67, 5, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (67, 7, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/

    (68, 13, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (68, 15, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    (69, 17, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (69, 21, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    (70, 7, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (70, 9, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/

    (71, 5, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (71, 7, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/

    (72, 13, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (72, 15, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (73, 17, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (73, 21, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (74, 3, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (74, 5, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (75, 9, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (75, 11, NOW(), NOW()),            /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (76, 1, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (76, 3, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (77, 5, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (77, 9, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (78, 19, NOW(), NOW()),            /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (78, 21, NOW(), NOW()),            /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (79, 9, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (79, 13, NOW(), NOW()),            /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (80, 9, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/
    (80, 11, NOW(), NOW()),            /*BASE DE DATOS I - GRUPO 2*/

    (81, 1, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/
    (81, 3, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/    
    
    (82, 5, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (82, 9, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/

    (83, 7, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (83, 9, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/

    (84, 15, NOW(), NOW()),            /*BASE DE DATOS II - GRUPO 1*/
    (84, 17, NOW(), NOW()),            /*BASE DE DATOS II - GRUPO 1*/
    
    (85, 11, NOW(), NOW()),            /*BASE DE DATOS II - GRUPO 1*/
    (85, 13, NOW(), NOW()),            /*BASE DE DATOS II - GRUPO 1*/

    (86, 15, NOW(), NOW()),            /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (86, 17, NOW(), NOW()),            /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    
    (87, 11, NOW(), NOW()),            /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (87, 13, NOW(), NOW()),            /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (88, 5, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (88, 9, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (89, 7, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (89, 9, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    /*------------------------------------------------------------------------------*/

    (90, 3, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (90, 5, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (91, 7, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (91, 9, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/

    (92, 9, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (92, 11, NOW(), NOW()),            /*BASE DE DATOS I - GRUPO 1*/

    (93, 1, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (93, 5, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (94, 3, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (94, 5, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (95, 9, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (95, 11, NOW(), NOW()),            /*CALCULO NUMERICO - GRUPO 1*/

    /*RESERVA ESPECIAL DESDE LAS 8:15 - 15-45*/

    (96, 3, NOW(), NOW()),            /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (96, 13, NOW(), NOW()),           /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (97, 3, NOW(), NOW()),            /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (97, 13, NOW(), NOW()),           /*97  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (98, 3, NOW(), NOW()),            /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 13, NOW(), NOW()),           /*98  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (99, 3, NOW(), NOW()),            /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 13, NOW(), NOW()),           /*99  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (100, 3, NOW(), NOW()),           /*100 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (100, 13, NOW(), NOW()),          /*100 RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (101, 3, NOW(), NOW()),           /*101 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 13, NOW(), NOW()),          /*101 RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (102, 3, NOW(), NOW()),           /*102 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 13, NOW(), NOW()),          /*102 RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (103, 3, NOW(), NOW()),           /*102 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (103, 13, NOW(), NOW()),          /*102 RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (104, 3, NOW(), NOW()),           /*102 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 13, NOW(), NOW())           /*102 RESERVA ESPECIAL - EXAMEN DE INGRESO*/
;