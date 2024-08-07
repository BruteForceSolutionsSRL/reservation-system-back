/*
    LAST MODIFICATION: 26/07/2024 20:30
    VERSION: 
        2.0 (RESERVAS ESPECIALES + GESTION ACADEMICA)
*/
use test3;
/*
    constants
*/
insert into constants(identifier, value) values
    ('AUTOMATIC_RESERVATION', '1'),
    ('MAXIMAL_RESERVATIONS_PER_GROUP', '5')
;
/*
    roles
*/
insert into roles(name, created_at, updated_at) values 
('ENCARGADO', NOW(), NOW()),        /*ID 1*/
('DOCENTE', NOW(), NOW())           /*ID 2*/
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
('request_reserve', NOW(), NOW()),          /*ID 1*/
('reservation_handling', NOW(), NOW()),     /*ID 2*/
('notify', NOW(), NOW()),                   /*ID 3*/
('report', NOW(), NOW()),                   /*ID 4*/
('block_register', NOW(), NOW()),           /*ID 5*/
('block_update', NOW(), NOW()),             /*ID 6*/
('block_remove', NOW(), NOW()),             /*ID 7*/
('environment_register', NOW(), NOW()),     /*ID 8*/
('environment_update', NOW(), NOW()),       /*ID 9*/
('environment_remove', NOW(), NOW()),       /*ID 10*/
('reservation_cancel', NOW(), NOW()),       /*ID 11*/
('history', NOW(), NOW()),                  /*ID 12*/
('special_reservation', NOW(), NOW()),       /*ID 13*/
('switch_constants', NOW(), NOW()),         /*ID 14*/
('academic_management', NOW(), NOW()),       /*ID 15*/
('academic_periods', NOW(), NOW())       /*ID 16*/
;           
/*
    role_permission
    ENCARGADO   -> ID 1
    DOCENTE     -> ID 2
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
(1,14,NOW(),NOW()),
(1,15,NOW(),NOW()),
(1,16,NOW(),NOW()),
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
    (26, 2),
    (27, 2),
    (28, 2),
    (29, 2),
    (30, 2),
    (31, 2),
    (32, 2),
    (33, 2),
    (34, 2),
    (35, 2),
    (36, 2),
    (37, 2),
    (38, 2),
    (39, 2),
    (40, 2),
    (41, 2),
    (42, 2),
    (43, 2),
    (44, 2),
    (45, 2),
    (46, 2),
    (47, 2),
    (48, 2),
    (49, 2),
    (50, 2),
    (51, 2),
    (52, 2),
    (53, 1),
    (54, 1),
    (55, 1),
    (56, 1),
    (57, 1),
    (58, 1),
    (59, 1)
;
/*
    notification_types
*/
insert into notification_types(description) values 
('INFORMATIVO'),
('ACEPTADA'),
('RECHAZADA'), 
('CANCELADA'),
('ADVERTENCIA')
;
/*
    departments
*/
insert into departments(name) 
value 
    ('DEPARTAMENTO DE INFORMATICA - SISTEMAS')
;
/*
    time_slot
*/
insert into time_slots(time, created_at, updated_at)
values
    ('06:30:00', NOW(), NOW()), /*ID 1*/
    ('06:45:00', NOW(), NOW()), /*ID 2*/
    ('07:00:00', NOW(), NOW()), /*ID 3*/
    ('07:15:00', NOW(), NOW()), /*ID 4*/
    ('07:30:00', NOW(), NOW()), /*ID 5*/
    ('07:45:00', NOW(), NOW()), /*ID 6*/
    ('08:00:00', NOW(), NOW()), /*ID 7*/
    ('08:15:00', NOW(), NOW()), /*ID 8*/
    ('08:30:00', NOW(), NOW()), /*ID 9*/
    ('08:45:00', NOW(), NOW()), /*ID 10*/
    ('09:00:00', NOW(), NOW()), /*ID 11*/
    ('09:15:00', NOW(), NOW()), /*ID 12*/
    ('09:30:00', NOW(), NOW()), /*ID 13*/
    ('09:45:00', NOW(), NOW()), /*ID 14*/
    ('10:00:00', NOW(), NOW()), /*ID 15*/
    ('10:15:00', NOW(), NOW()), /*ID 16*/
    ('10:30:00', NOW(), NOW()), /*ID 17*/
    ('10:45:00', NOW(), NOW()), /*ID 18*/
    ('11:00:00', NOW(), NOW()), /*ID 19*/
    ('11:15:00', NOW(), NOW()), /*ID 20*/
    ('11:30:00', NOW(), NOW()), /*ID 21*/
    ('11:45:00', NOW(), NOW()), /*ID 22*/
    ('12:00:00', NOW(), NOW()), /*ID 23*/
    ('12:15:00', NOW(), NOW()), /*ID 24*/
    ('12:30:00', NOW(), NOW()), /*ID 25*/
    ('12:45:00', NOW(), NOW()), /*ID 26*/
    ('13:00:00', NOW(), NOW()), /*ID 27*/
    ('13:15:00', NOW(), NOW()), /*ID 28*/
    ('13:30:00', NOW(), NOW()), /*ID 29*/
    ('13:45:00', NOW(), NOW()), /*ID 30*/
    ('14:00:00', NOW(), NOW()), /*ID 31*/
    ('14:15:00', NOW(), NOW()), /*ID 32*/
    ('14:30:00', NOW(), NOW()), /*ID 33*/
    ('14:45:00', NOW(), NOW()), /*ID 34*/
    ('15:00:00', NOW(), NOW()), /*ID 35*/
    ('15:15:00', NOW(), NOW()), /*ID 36*/
    ('15:30:00', NOW(), NOW()), /*ID 37*/
    ('15:45:00', NOW(), NOW()), /*ID 38*/
    ('16:00:00', NOW(), NOW()), /*ID 39*/
    ('16:15:00', NOW(), NOW()), /*ID 40*/
    ('16:30:00', NOW(), NOW()), /*ID 41*/
    ('16:45:00', NOW(), NOW()), /*ID 42*/
    ('17:00:00', NOW(), NOW()), /*ID 43*/
    ('17:15:00', NOW(), NOW()), /*ID 44*/
    ('17:30:00', NOW(), NOW()), /*ID 45*/
    ('17:45:00', NOW(), NOW()), /*ID 46*/
    ('18:00:00', NOW(), NOW()), /*ID 47*/
    ('18:15:00', NOW(), NOW()), /*ID 48*/
    ('18:30:00', NOW(), NOW()), /*ID 49*/
    ('18:45:00', NOW(), NOW()), /*ID 50*/
    ('19:00:00', NOW(), NOW()), /*ID 51*/
    ('19:15:00', NOW(), NOW()), /*ID 52*/
    ('19:30:00', NOW(), NOW()), /*ID 53*/
    ('19:45:00', NOW(), NOW()), /*ID 54*/
    ('20:00:00', NOW(), NOW()), /*ID 55*/
    ('20:15:00', NOW(), NOW()), /*ID 56*/
    ('20:30:00', NOW(), NOW()), /*ID 57*/
    ('20:45:00', NOW(), NOW()), /*ID 58*/
    ('21:00:00', NOW(), NOW()), /*ID 59*/
    ('21:15:00', NOW(), NOW()), /*ID 60*/
    ('21:30:00', NOW(), NOW()), /*ID 61*/
    ('21:45:00', NOW(), NOW()), /*ID 62*/
    ('22:00:00', NOW(), NOW()), /*ID 63*/
    ('22:15:00', NOW(), NOW()), /*ID 64*/
    ('22:30:00', NOW(), NOW()), /*ID 65*/
    ('22:45:00', NOW(), NOW())  /*ID 66*/
;
/*
    faculties
*/
insert into faculties(name, time_slot_id) values
    ('FACULTAD DE CIENCIAS Y TECNOLOGIA - FCYT', 2)
; 
/*
    academic_managements
*/
insert into academic_managements(name, initial_date, end_date) values 
    ('Gestion 2024', '2024-04-01', '2024-09-01') /*ID 1 - I-2024*/
;
/*
    academic_periods
*/
insert into academic_periods(name, initial_date, end_date, activated, faculty_id, academic_management_id, initial_date_reservations) values
    ('I-2024', '2024-04-01', '2024-09-01', 1, 1, 1, '2024-04-01') /*ID 1 - I-2024*/
;
/*
    careers
*/
insert into   study_plans (name, created_at, updated_at) 
values 
    ('LICENCIATURA EN INGENIERIA INFORMATICA', NOW(), NOW()), 
    ('LICENCIATURA EN INGENIERIA DE SISTEMAS', NOW(), NOW()), 
    ('LICENCIATURA EN ELECTROMECANICA'       , NOW(), NOW())
;
/*
    study_plans_academic_period
*/
insert into study_plan_academic_period (study_plan_id, academic_period_id) values 
    (1, 1), 
    (2, 1), 
    (3, 1)
;
/*
    university_subjects
*/
insert into university_subjects (department_id, id, name, created_at)
values 
    (1, 1803001, 'INGLES I',                                            NOW()), /*ID 1 */  
    (1, 2006063, 'FISICA GENERAL',                                      NOW()), /*ID 2 */ 
    (1, 2008019, 'ALGEBRA I',                                           NOW()), /*ID 3 */ 
    (1, 2008054, 'CALCULO I',                                           NOW()), /*ID 4 */ 
    (1, 2010010, 'INTRODUCCION A LA PROGRAMACION',                      NOW()), /*ID 5 */
    (1, 1803002, 'INGLES II',                                           NOW()), /*ID 6 */
    (1, 2008022, 'ALGEBRA II',                                          NOW()), /*ID 7 */
    (1, 2008056, 'CALCULO II',                                          NOW()), /*ID 8 */
    (1, 2010003, 'ELEMENTOS DE PROGRAMACION Y ESTRUCTURAS DE DATOS',    NOW()), /*ID 9 */
    (1, 2010013, 'ARQUITECTURA DE COMPUTADORAS I',                      NOW()), /*ID 10 */
    (1, 2010200, 'PROGRAMACION',                                        NOW()), /*ID 11 */
    (1, 2008060, 'CALCULO NUMERICO',                                    NOW()), /*ID 12 */
    (1, 2008140, 'LOGICA',                                              NOW()), /*ID 13 */
    (1, 2010014, 'ARQUITECTURA DE COMPUTADORAS II',                     NOW()), /*ID 14 */
    (1, 2010037, 'TEORIA DE GRAFOS',                                    NOW()), /*ID 15 */
    (1, 2010041, 'ORGANIZACION Y METODOS',                              NOW()),  /*ID 16 */
    (1, 2010206, 'METODOS Y TECNICAS DE PROGRAMACION',                  NOW()),  /*ID 17 */
    (1, 2008029, 'PROBABILIDAD Y ESTADISTICA',                          NOW()),  /*ID 18 */
    (1, 2010005, 'TALLER DE PROGRAMACION EN BAJO NIVEL',                NOW()),  /*ID 19 */
    (1, 2010015, 'BASE DE DATOS I',                                     NOW()),  /*ID 20 */
    (1, 2010018, 'SISTEMAS DE INFORMACION I',                           NOW()),  /*ID 21 */
    (1, 2010038, 'PROGRAMACION FUNCIONAL',                              NOW()),  /*ID 22 */
    (1, 2010197, 'ALGORITMOS AVANZADOS',                                NOW()),  /*ID 23 */
    (1, 2010016, 'BASE DE DATOS II',                                    NOW()),  /*ID 24 */
    (1, 2010017, 'TALLER DE SISTEMAS OPERATIVOS',                       NOW()),  /*ID 25 */
    (1, 2010022, 'SISTEMAS DE INFORMACION II',                          NOW()),  /*ID 26 */
    (1, 2010040, 'TEORIA DE AUTOMATAS Y LENGUAJES DE FORMALES',         NOW()),  /*ID 27 */
    (1, 2010042, 'GRAFICACION POR COMPUTADORA',                         NOW()),  /*ID 28 */
    (1, 2010201, 'INTELIGENCIA ARTIFICIAL I',                           NOW()),  /*ID 29 */
    (1, 2010020, 'INGENIERIA DE SOFTWARE',                              NOW()),  /*ID 30 */
    (1, 2010047, 'REDES DE COMPUTADORAS',                               NOW()),  /*ID 31 */
    (1, 2010049, 'ESTRUCTURA Y SEMANTICA DE LENGUAJES DE PROGRAMACION', NOW()),  /*ID 32 */
    (1, 2010053, 'TALLER DE BASE DE DATOS',                             NOW()),  /*ID 33 */
    (1, 2010202, 'INTELIGENCIA ARTIFICIAL II',                          NOW()),  /*ID 34 */
    (1, 2010203, 'PROGRAMACION WEB',                                    NOW()),  /*ID 35 */
    (1, 2010019, 'SIMULACION DE SISTEMAS',                              NOW()),  /*ID 36 */
    (1, 2010024, 'TALLER DE INGENIERIA DE SOFTWARE',                    NOW()),  /*ID 37 */
    (1, 2010100, 'ARQUITECTURA DE SOFTWARE',                            NOW()),  /*ID 38 */
    (1, 2010204, 'INTERACCION HUMANO COMPUTADOR',                       NOW()),  /*ID 39 */
    (1, 2010205, 'TECNOLOGIA DE REDES AVANZADAS',                       NOW()),  /*ID 40 */
    (1, 2010035, 'APLICACION DE SISTEMAS OPERATIVOS',                   NOW()),  /*ID 41 */
    (1, 2010102, 'EVALUACION Y AUDITORIA DE SISTEMAS',                  NOW()),  /*ID 42 */
    (1, 2010214, 'TALLER DE GRADO I',                                   NOW()),  /*ID 43 */
    (1, 2010066, 'PROCESOS AGILES',                                     NOW()),  /*ID 44 */
    (1, 2010178, 'ENTORNOS VIRTUALES DE APRENDIZAJE',                   NOW()),  /*ID 45 */
    (1, 2010188, 'SERVICIOS TELEMATICOS',                               NOW()),  /*ID 46 */
    (1, 2010189, 'RECONOCIMIENTO DE VOZ',                               NOW()),  /*ID 47 */
    (1, 2010209, 'SEGURIDAD DE SISTEMAS',                               NOW()),  /*ID 48 */
    (1, 2010215, 'TALLER DE GRADO II',                                  NOW()),  /*ID 49 */
    (1, 2010216, 'CLOUD COMPUTING',                                     NOW()),  /*ID 50 */
    (1, 2010217, 'BUSSINESS INTELLIGENCE Y BIG DATA',                   NOW()),  /*ID 51 */
    (1, 2010218, 'CIENCIA DE DATOS Y MACHINE LEARNING',                 NOW())  /*ID 52 */
;
/**
    study_plan_university_subject
*/
insert into study_plan_university_subject (study_plan_id, university_subject_id, grade)
values
    (1, 1803001,  'A'), /* INFORMATICA - INGLES I */
    (1, 2006063,  'A'), /* INFORMATICA - FISICA GENERAL */
    (1, 2008019,  'A'), /* INFORMATICA - ALGEBRA I */
    (1, 2008054,  'A'), /* INFORMATICA - CALCULO I */
    (1, 2010010,  'A'), /* INFORMATICA - INTRODUCCION A LA PROGRAMACION */
    (1, 1803002,  'B'), /* INFORMATICA - INGLES II */
    (1, 2008022,  'B'), /* INFORMATICA - ALGEBRA II */
    (1, 2008056,  'B'), /* INFORMATICA - CALCULO II */
    (1, 2010003,  'B'), /* INFORMATICA - ELEMENTOS DE PROGRAMACION Y EST. DE DATOS */
    (1, 2010013, 'B'), /* INFORMATICA - ARQUITECTURA DE COMPUTADORAS I */
    (1, 2010200, 'B'), /* INFORMATICA - PROGRAMACION */
    (1, 2008060, 'C'), /* INFORMATICA - CALCULO NUMERICO */
    (1, 2008140, 'C'), /* INFORMATICA - LOGICA */
    (1, 2010014, 'C'), /* INFORMATICA - ARQUITECTURA DE COMPUTADORAS II */
    (1, 2010037, 'C'), /* INFORMATICA - TEORIA DE GRAFOS */
    (1, 2010041, 'C'), /* INFORMATICA - ORGANIZACION Y METODOS */
    (1, 2010206, 'C'), /* INFORMATICA - METODOS Y TECNICAS */
    (1, 2008029, 'D'), /* INFORMATICA - PROBABILIDAD Y ESTADISTICA */
    (1, 2010005, 'D'), /* INFORMATICA - TALLER DE PROG. BAJO NIVEL */
    (1, 2010015, 'D'), /* INFORMATICA - BASE DE DATOS I */
    (1, 2010018, 'D'), /* INFORMATICA - SISTEMAS DE INFORMACION I */
    (1, 2010038, 'D'), /* INFORMATICA - PROGRAMACION FUNCIONAL */
    (1, 2010197, 'D'), /* INFORMATICA - ALGORITMOS AVANZADOS */
    (1, 2010016, 'E'), /* INFORMATICA - BASE DE DATOS II */
    (1, 2010017, 'E'), /* INFORMATICA - TALLER DE SISTEMAS OPERATIVOS */
    (1, 2010022, 'E'), /* INFORMATICA - SISTEMAS DE INFORMACION II */
    (1, 2010040, 'E'), /* INFORMATICA - TEORIA DE AUTOMATAS */
    (1, 2010042, 'E'), /* INFORMATICA - GRAFICACION POR COMPUTADORAS */
    (1, 2010201, 'E'), /* INFORMATICA - INTELIGENCIA ARTIFICIAL I */
    (1, 2010020, 'F'), /* INFORMATICA - INGENIERIA DE SOFTWARE */
    (1, 2010047, 'F'), /* INFORMATICA - REDES DE COMPUTADORAS */
    (1, 2010049, 'F'), /* INFORMATICA - ESTRUCTURA Y SEMANTICA */
    (1, 2010053, 'F'), /* INFORMATICA - TALLER DE BASE DE DATOS */
    (1, 2010202, 'F'), /* INFORMATICA - INTELIGENCIA ARTIFICIAL II */
    (1, 2010203, 'F'), /* INFORMATICA - PROGRAMACION WEB */
    (1, 2010019, 'G'), /* INFORMATICA - SIMULACION DE SISTEMAS */
    (1, 2010024, 'G'), /* INFORMATICA - TALLER DE INGENIERIA DE SOFTWARE */
    (1, 2010100, 'G'), /* INFORMATICA - ARQUITECTURA DE SOFTWARE */
    (1, 2010204, 'G'), /* INFORMATICA - INTERACCION HUMANO COMPUTADOR */
    (1, 2010205, 'G'), /* INFORMATICA - REDES AVANZADAS */
    (1, 2010035, 'G'), /* INFORMATICA - APLICACION DE SISTEMAS OPERATIVOS */
    (1, 2010102, 'H'), /* INFORMATICA - EVALUACION Y AUDITORIA DE SISTEMAS */
    (1, 2010214, 'H'), /* INFORMATICA - TALLER DE GRADO I */
    (1, 2010066, 'H'), /* INFORMATICA - PROCESOS AGILES */
    (1, 2010178, 'H'), /* INFORMATICA - ENTORNOS VIRTUALES DE APRENDIZAJE */
    (1, 2010188, 'H'), /* INFORMATICA - SERVICIOS TELEMATICOS */
    (1, 2010189, 'H'), /* INFORMATICA - RECONOCIMIENTO DE VOZ */
    (1, 2010209, 'H'), /* INFORMATICA - SEGURIDAD DE SISTEMAS */
    (1, 2010215, 'I'), /* INFORMATICA - TALLER DE GRADO II */
    (1, 2010216, 'I'), /* INFORMATICA - CLOUD COMPUTING */
    (1, 2010217, 'I'), /* INFORMATICA - BUSSINESS INTELLIGENCE */
    (1, 2010218, 'I') /* INFORMATICA - CIENCIA DE DATOS Y MACHINE LEARNING */
;
/*
    teacher_subjects
*/
insert into teacher_subjects (group_number, person_id, university_subject_id)
values 
    ('1', 1, 1803001),      /* ID 1  |INGLES I G1 - MARIA BENITA*/
    ('2', 1, 1803001),      /* ID 2  |INGLES I G2 - MARIA BENITA*/
    ('3', 2, 1803001),      /* ID 3  |INGLES I G3 - PEETERS*/

    ('B',  3, 2006063),      /* ID 4  |FISICA GENERAL - ROBERTO VALENZUELA*/
    ('B1', 4, 2006063),      /* ID 5  |FISICA GENERAL - RENE MOREIRA*/
    ('B2', 5, 2006063),      /* ID 6  |FISICA GENERAL - ROCIO GUZMAN*/
    ('B3', 7, 2006063),      /* ID 7  |FISICA GENERAL - MIGUEL ANGEL ORDONEZ*/
    ('B4', 6, 2006063),      /* ID 8  |FISICA GENERAL - ROCIO GUZMAN*/
    ('B5', 8, 2006063),      /* ID 9  |FISICA GENERAL - JUAN CARLOS TERRAZAS*/
    ('B6', 8, 2006063),      /* ID 10 |FISICA GENERAL - JUAN CARLOS TERRAZAS*/

    ('10', 9, 2008019),      /* ID 11  |ALGEBRA I - JUAN ANTONIO RODRIGUEZ*/
    ('15', 10, 2008019),      /* ID 12  |ALGEBRA I - ALVARO HERNANDO CALVO*/
    ('8',  11, 2008019),      /* ID 13  |ALGEBRA I - GUALBERTO LEON*/

    ('10', 12, 2008054),      /* ID 14  |CALCULO I - POR DESIGNAR*/
    ('11', 13, 2008054),      /* ID 15  |CALCULO I - RAMIRO ZURITA*/

    ('1',  14, 2010010),      /* ID 16  |INTRO A LA PROGRA - CARLA SALAZAR*/
    ('10', 15, 2010010),      /* ID 17  |INTRO A LA PROGRA - VLADIMIR COSTAS*/
    ('2',  16, 2010010),      /* ID 18  |INTRO A LA PROGRA - LETICIA BLANCO*/
    ('3',  17, 2010010),      /* ID 19  |INTRO A LA PROGRA - HERNAN USTARIZ*/
    ('4',  18, 2010010),      /* ID 20  |INTRO A LA PROGRA - HENRY FRANK*/
    ('5',  19, 2010010),      /* ID 21  |INTRO A LA PROGRA - VICTOR HUGO*/
    ('6',  14, 2010010),      /* ID 22 |INTRO A LA PROGRA - CARLA SALAZAR*/
    ('7',  15, 2010010),      /* ID 23  |INTRO A LA PROGRA - VLADIMIR COSTAS*/

    ('1', 2, 1803002),      /* ID 24  |INGLES II - MAGDA LENA*/
    ('2', 2, 1803002),      /* ID 25  |INGLES II - MAGDA LENA*/
    ('3', 2, 1803002),      /* ID 26  |INGLES II - MAGDA LENA*/

    ('5A', 20, 2008022),      /* ID 27  |ALGEBRA II - WALTER GONZALO*/
    ('6',  21, 2008022),      /* ID 28  |ALGEBRA II - HERNAN SILVA*/
    ('8',  22, 2008022),      /* ID 29  |ALGEBRA II - JOSE OMONTE*/

    ('12', 23, 2008056),      /* ID 30  |CALCULO II - AMILCAR*/
    ('6',  24, 2008056),      /* ID 31  |CALCULO II - LOBO*/

    ('1', 25, 2010003),      /* ID 32  |ELEMENTOS DE PROGRAMACION - ROSEMARY*/
    ('2', 16, 2010003),      /* ID 33  |ELEMENTOS DE PROGRAMACION - LETICIA*/
    ('3', 16, 2010003),      /* ID 34  |ELEMENTOS DE PROGRAMACION - LETICIA*/
    ('5', 26, 2010003),      /* ID 35  |ELEMENTOS DE PROGRAMACION - HELDER OCTAVIO*/

    ('1', 27, 2010013),      /* ID 36  |ARQUITECTURA I - SAMUEL ACHA*/
    ('2', 16, 2010013),      /* ID 37  |ARQUITECTURA I - LETI*/

    ('1', 25, 2010200),      /* ID 38  |PROGRAMACION - ROSEMARY*/

    ('2', 28, 2008060),      /* ID 39  |CALCULO NUMERICO - JUCHANI*/
    ('3', 29, 2008060),      /* ID 40  |CALCULO NUMERICO - OSCAR ZABALAGA*/

    ('1', 30, 2008140),      /* ID 41  |LOGICA - HOEPFNER*/

    ('1', 31, 2010014),      /* ID 42  |ARQUITECTURA II - ROBERTO AGREDA*/

    ('1', 32, 2010037),      /* ID 43  |TEORIA DE GRAFOS - YONY MONTOYA*/

    ('1', 33, 2010041),      /* ID 44  |ORGANIZACION Y METODOS - INDIRA*/

    ('1', 34, 2010206),      /* ID 45  |METODOS Y TECNICAS DE PROG. - CORINA*/
    ('2', 35, 2010206),      /* ID 46  |METODOS Y TECNICAS DE PROG. - CARLOS MANZUR*/
    ('5', 32, 2010206),      /* ID 47  |METODOS Y TECNICAS DE PROG. -  YONY MONTOYA*/

    ('3', 36, 2008029),      /* ID 48  |PROB. Y ESTADISTICA - DELGADILLO COSSIO*/
    ('4', 22, 2008029),      /* ID 49  |PROB. Y ESTADISTICA - OMONTE*/

    ('1', 37, 2010005),      /* ID 50  |TALLER DE BAJO NIVEL - MONTECINOS*/

    ('1', 38, 2010015),      /* ID 51  |BASE DE DATOS I - VITTER JESUS MEDRANO*/
    ('2', 39, 2010015),      /* ID 52  |BASE DE DATOS I - BORIS CALANCHA*/

    ('1', 14, 2010018),      /* ID 53  |SISTEMAS DE INFORMACION I - CARLA SALAZAR*/
    ('2', 14, 2010018),      /* ID 54  |SISTEMAS DE INFORMACION I - CARLA SALAZAR*/

    ('1', 40, 2010038),      /* ID 55  |FUNCIONAL - TATIANA*/

    ('1', 16, 2010197),      /* ID 56  |ALGORITMOS AVANZADOS - LETICIA*/

    ('1', 40, 2010016),      /* ID 57  |BASE DE DATOS II - TATIANA*/
    ('2', 40, 2010016),      /* ID 58  |BASE DE DATOS II - TATIANA*/

    ('1', 41, 2010017),      /* ID 59  |TSO - JORGE ORELLANA*/
    ('2', 41, 2010017),      /* ID 60  |TSO - JORGE ORELLANA*/
    ('5', 42, 2010017),      /* ID 61  |TSO - GROVER CUSSI*/

    ('1', 43, 2010022),      /* ID 62  |SISTEMAS DE INFO II - MARCELO FLORES*/
    ('2', 44, 2010022),      /* ID 63  |SISTEMAS DE INFO II - K. JALDIN*/

    ('1', 19, 2010040),      /* ID 64  |AUTOMATAS. - VICTOR HUGO MONTANO*/

    ('1', 39, 2010042),      /* ID 65  |GRAFICACION POR COMPUTADORA - BORIS CALANCHA*/

    ('1', 45, 2010201),      /* ID 66  |INTELIGENCIA ARTIFICIAL I - CARMEN ROSA*/
    ('2', 46, 2010201),      /* ID 67  |INTELIGENCIA ARTIFICIAL I - ERIKA PATRICIA*/

    ('1', 33, 2010020),      /* ID 68  |INGENIERIA DE SOFTWARE - INDIRA*/
    ('2', 25, 2010020),      /* ID 69  |INGENIERIA DE SOFTWARE - ROSEMARY*/

    ('1', 41, 2010047),      /* ID 70  |REDES DE COMPUTADORAS - JORGE ORELLANA*/
    ('2', 41, 2010047),      /* ID 71  |REDES DE COMPUTADORAS - JORGE ORELLANA*/

    ('1', 47, 2010049),      /* ID 72  |ESTRUCTURA Y SEMANTICA - PATRICIA ROMERO*/

    ('1', 39, 2010053),      /* ID 73  |TALLER DE BASE DE DATOS - BORIS CALANCHA*/
    ('2', 39, 2010053),      /* ID 74  |TALLER DE BASE DE DATOS - BORIS CALANCHA*/
    ('3', 43, 2010053),      /* ID 75  |TALLER DE BASE DE DATOS - MARCELO FLORES*/
    ('4', 39, 2010053),      /* ID 76  |TALLER DE BASE DE DATOS - BORIS CALANCHA*/

    ('2', 45, 2010202),      /* ID 77  |INTELIGENCIA ARTIFICIAL II - CARMEN ROSA*/

    ('1', 15, 2010203),      /* ID 78  |PROGRAMACION WEB - VLADIMIR COSTAS*/

    ('1', 18, 2010019),      /* ID 79  |SIMULACION DE SISTEMAS - HENRY FRANK VILLARROEL*/

    ('1', 34, 2010024),      /* ID 80  |TALLER DE INGENIERIA DE SOFTWARE - CORINA*/
    ('2', 16, 2010024),      /* ID 81  |TALLER DE INGENIERIA DE SOFTWARE - LETICIA*/

    ('1', 48, 2010100),      /* ID 82  |ARQUITECTURA DE SOFTWARE - CLAUDIA URENA*/

    ('1', 34, 2010204),      /* ID 83  |IHC - CORINA*/

    ('1', 37, 2010205),      /* ID 84  |REDES AVANZADAS - MONTECINOS*/

    ('1', 42, 2010035),      /* ID 85  |APLICACION DE SISTEMAS OPERATIVOS - GROVER CUSSI*/
    ('2', 42, 2010035),      /* ID 86  |APLICACION DE SISTEMAS OPERATIVOS - GROVER CUSSI*/

    ('1', 47, 2010102),      /* ID 87  |EVALUACION Y AUDITORIA DE SISTEMAS - PATRICIA ROMERO*/
    ('2', 49, 2010102),      /* ID 88  |EVALUACION Y AUDITORIA DE SISTEMAS - JIMMY NOVILLO*/

    ('6', 34, 2010214),      /* ID 89  |TALLER DE GRADO I - CORINA*/
    ('7', 47, 2010214),      /* ID 90  |TALLER DE GRADO I - PATRICIA ROMERO*/

    ('1', 50, 2010066),      /* ID 91  |PROCESOS AGILES - NIBETH MENA*/

    ('1', 15, 2010178),      /* ID 92  |ENTORNOS VIRTUALES DE APRENDIZAJE - VLADIMIR COSTAS*/

    ('1', 51, 2010188),      /* ID 93  |TELEMATICOS - AMERICO FIORILO*/

    ('1', 45, 2010189),      /* ID 94  |RECONOCIMIENTO DE VOZ - CARMEN ROSA*/

    ('1', 52, 2010209),      /* ID 95  |SEGURIDAD DE SISTEMAS - MARCELO ANTEZANA*/

    ('2', 19, 2010215),      /* ID 96  |TALLER DE GRADO II - VICTOR HUGO MONTANO*/
    ('3', 45, 2010215),      /* ID 97  |TALLER DE GRADO II - CARMEN ROSA*/
    ('4', 47, 2010215),      /* ID 98  |TALLER DE GRADO II - PATRICIA ROMERO*/

    ('1', 32, 2010216),      /* ID 99  |CLOUD COMPUTING - YONY MONTOYA*/

    ('1', 53, 2010217),      /* ID 100  |BUSSINESS INTELIGENCE Y BIG DATA - VICTOR ADOLFO*/

    ('1', 46, 2010218)      /* ID 101  |MACHINE LEARNING - ERIKA PATRICIA*/
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
insert into blocks (id, name, max_floor, block_status_id, max_classrooms, faculty_id)
values 
    (29, 'BLOQUE 29',                           0, 1, 20, 1),     /*ID F*/
    (9,  'DEPARTAMENTO DE BIOLOGIA',            2, 1, 20, 1),     /*ID F*/       
    (27, 'BLOQUE 27',                           3, 1, 20, 1),     /*ID F*/    
    (7,  'DEPARTAMENTO DE QUIMICA',             1, 1, 20, 1),     /*ID F*/    
    (28, 'BLOQUE 28',                           2, 1, 20, 1),     /*ID F*/    
    (4,  'DEPARTAMENTO DE FISICA',              0, 1, 20, 1),     /*ID F*/
    (12, 'BLOQUE 12',                           2, 1, 20, 1),     /*ID F*/       
    (13, 'BLOQUE 13',                           3, 1, 20, 1),     /*ID F*/    
    (11, 'BLOQUE 11',                           0, 1, 20, 1),     /*ID F*/    
    (15, 'BIBLIOTECA FCYT',                     2, 1, 20, 1),     /*ID F*/    
    (22, 'DEPARTAMENTO INDUSTRIAL',             0, 1, 20, 1),     /*ID F*/
    (17, 'PLANTA DE PROCESOS INDUSTRIALES',     2, 1, 20, 1),     /*ID F*/       
    (19, 'SECTOR LABORATORIOS MECANICA',        3, 1, 20, 1),     /*ID F*/    
    (20, 'EDIFICIO CAD - CAM',                  1, 1, 20, 1),     /*ID F*/    
    (1,  'BLOQUE CENTRAL EDIFICIO DECANATURA',  2, 1, 20, 1),     /*ID F*/    
    (16, 'EDIFICIO ACADEMICO 2',                3, 1, 20, 1),     /*ID F*/
    (65, 'BLOQUE TRENCITO',                     2, 1, 20, 1),     /*ID F*/       
    (63, 'AULAS INF - LAB',                     3, 1, 20, 1),     /*ID F*/    
    (64, 'EDIFICIO MEMI',                       2, 1, 20, 1),     /*ID F*/    
    (10, 'EDIFICIO ELEKTRO',                    0, 1, 20, 1),     /*ID F*/
    (26, 'EDIFICIO DE LABORATORIOS BASICOS',    2, 1, 20, 1)      /*ID F*/       
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
    ('607',     50, 0, 29, 1, 1, NOW(), NOW()),          /*ID 1 |AULAS INF-LAB*/ 
    
    ('606',     50, 1, 9, 1, 1, NOW(), NOW()),          /*ID 2 |AULAS INF-LAB*/ 
    ('608',     25, 0, 9, 1, 1, NOW(), NOW()),          /*ID 3 |AULAS INF-LAB*/ 
    ('609',     25, 0, 9, 1, 1, NOW(), NOW()),          /*ID 4 |AULAS INF-LAB*/ 
    ('608A',    25, 0, 9, 1, 1, NOW(), NOW()),          /*ID 5 |AULAS INF-LAB*/ 
    ('608B',    50, 0, 9, 1, 1, NOW(), NOW()),          /*ID 6 |EDIFICIO MEMI*/ 
    ('609A',    50, 0, 9, 1, 1, NOW(), NOW()),          /*ID 7 |EDIFICIO MEMI*/ 

    ('612',     75, 0, 27, 3, 1, NOW(), NOW()),             /*ID 8 |EDIFICIO MEMI*/ 

    ('613',  50, 0, 7, 2, 1, NOW(), NOW()),                /*ID 9  |EDIFICIO ACADEMICO 2*/ 
    ('614',  50, 0, 7, 2, 1, NOW(), NOW()),                /*ID 10 |EDIFICIO ACADEMICO 2*/ 
    ('615',  50, 0, 7, 2, 1, NOW(), NOW()),                /*ID 11 |EDIFICIO ACADEMICO 2*/ 
    ('616',  50, 0, 7, 2, 1, NOW(), NOW()),                /*ID 12 |EDIFICIO ACADEMICO 2*/ 
    ('616A', 50, 1, 7, 2, 1, NOW(), NOW()),                /*ID 13 |EDIFICIO ACADEMICO 2*/ 

    ('617',   50, 1, 28, 2, 1, NOW(), NOW()),              /*ID 14 |EDIFICIO ACADEMICO 2*/ 
    ('617B', 100, 0, 28, 2, 1, NOW(), NOW()),               /*ID 15 |EDIFICIO ACADEMICO 2*/ 
    ('617C', 100, 0, 28, 2, 1, NOW(), NOW()),               /*ID 16 |EDIFICIO ACADEMICO 2*/ 

    ('618',                            100, 0, 4, 2, 1, NOW(), NOW()),               /*ID 17 |EDIFICIO ACADEMICO 2*/ 
    ('619',                            100, 0, 4, 2, 1, NOW(), NOW()),               /*ID 18 |EDIFICIO ACADEMICO 2*/ 
    ('619A',                           100, 0, 4, 2, 1, NOW(), NOW()),               /*ID 19 |EDIFICIO ACADEMICO 2*/ 
    ('620',                            100, 0, 4, 2, 1, NOW(), NOW()),               /*ID 20 |EDIFICIO ACADEMICO 2*/ 
    ('620B',                           100, 0, 4, 2, 1, NOW(), NOW()),               /*ID 21 |EDIFICIO ACADEMICO 2*/ 
    ('621',                            100, 0, 4, 2, 1, NOW(), NOW()),               /*ID 22 |EDIFICIO ACADEMICO 2*/ 
    ('621A',                           100, 0, 4, 2, 1, NOW(), NOW()),               /*ID 23 |EDIFICIO ACADEMICO 2*/ 
    ('FISCOM GABINETE COMPUTO FISICA', 100, 0, 4, 2, 1, NOW(), NOW()),               /*ID 24 |EDIFICIO ACADEMICO 2*/ 

    ('622', 100, 0, 12, 2, 1, NOW(), NOW()),               /*ID 25 |EDIFICIO ACADEMICO 2*/ 

    ('623', 100, 0, 13, 2, 1, NOW(), NOW()),               /*ID 26 |EDIFICIO ACADEMICO 2*/ 
    
    ('624',  75, 0, 11, 2, 1,  NOW(), NOW()),               /*ID 27 |EDIFICIO ACADEMICO 2*/ 
    
    ('625C',  75, 2, 15, 2, 1,  NOW(), NOW()),               /*ID 28 |EDIFICIO ACADEMICO 2*/ 
    ('625D',  75, 2, 15, 2, 1,  NOW(), NOW()),               /*ID 29 |EDIFICIO ACADEMICO 2*/ 
    ('CAE',   75, 1, 15, 2, 1,  NOW(), NOW()),               /*ID 30 |EDIFICIO ACADEMICO 2*/ 

    ('631',   100, 0, 22, 2, 1,        NOW(), NOW()),        /*ID 31 |EDIFICIO ACADEMICO 2*/ 
    ('632',   100, 0, 22, 2, 1,        NOW(), NOW()),        /*ID 32 |EDIFICIO ACADEMICO 2*/ 
    ('CAE 2', 100, 0, 22, 2, 1,        NOW(), NOW()),        /*ID 33 |EDIFICIO ACADEMICO 2*/ 

    ('635', 100, 1, 17, 2, 1, NOW(), NOW()),                /*ID 34 |BLOQUE TRENCITO*/ 

    ('640', 100, 0, 19, 2, 1, NOW(), NOW()),                /*ID 35 |BLOQUE TRENCITO*/ 
    ('642', 100, 0, 19, 2, 1, NOW(), NOW()),                /*ID 36 |BLOQUE TRENCITO*/ 
    ('643', 100, 0, 19, 2, 1, NOW(), NOW()),                /*ID 37 |BLOQUE TRENCITO*/ 

    ('644',    100, 1, 20, 2, 1, NOW(), NOW()),                /*ID 38 |BLOQUE TRENCITO*/ 
    ('644A',   100, 1, 20, 2, 1, NOW(), NOW()),                /*ID 39 |BLOQUE TRENCITO*/ 
    ('AUDCIV', 100, 3, 20, 2, 1, NOW(), NOW()),                /*ID 40 |BLOQUE TRENCITO*/ 

    ('651',    50, 0, 1, 2, 1, NOW(), NOW()),                 /*ID 41 |BLOQUE CENTRAL - EDIFICIO DECANATURA*/ 
    ('652',    50, 0, 1, 2, 1, NOW(), NOW()),                 /*ID 42 |BLOQUE CENTRAL - EDIFICIO DECANATURA*/ 
    ('655',    50, 0, 1, 2, 1, NOW(), NOW()),                 /*ID 43 |BLOQUE CENTRAL - EDIFICIO DECANATURA*/ 
    ('AUDMEC', 50, 2, 1, 2, 1, NOW(), NOW()),                 /*ID 44 |BLOQUE CENTRAL - EDIFICIO DECANATURA*/ 
    ('MAGCIV', 50, 2, 1, 2, 1, NOW(), NOW()),                 /*ID 45 |BLOQUE CENTRAL - EDIFICIO DECANATURA*/ 

    ('690A',   50, 0, 16, 2, 1, NOW(), NOW()),                /*ID 46 |EDIFICIO ACADEMICO 2*/ 
    ('690B',   50, 0, 16, 2, 1, NOW(), NOW()),                /*ID 47 |EDIFICIO ACADEMICO 2*/ 
    ('690C',   50, 0, 16, 2, 1, NOW(), NOW()),                /*ID 48 |EDIFICIO ACADEMICO 2*/ 
    ('690D',   50, 0, 16, 2, 1, NOW(), NOW()),                /*ID 49 |EDIFICIO ACADEMICO 2*/ 
    ('690E',   50, 0, 16, 2, 1, NOW(), NOW()),                /*ID 50 |EDIFICIO ACADEMICO 2*/ 
    ('690MAT', 50, 0, 16, 2, 1, NOW(), NOW()),                /*ID 51 |EDIFICIO ACADEMICO 2*/ 
    
    ('691A', 100, 1, 16, 2, 1, NOW(), NOW()),               /*ID 52 |EDIFICIO ACADEMICO 2*/ 
    ('691B', 100, 1, 16, 2, 1, NOW(), NOW()),               /*ID 53 |EDIFICIO ACADEMICO 2*/ 
    ('691C', 100, 1, 16, 2, 1, NOW(), NOW()),               /*ID 54 |EDIFICIO ACADEMICO 2*/ 
    ('691D', 100, 1, 16, 2, 1, NOW(), NOW()),               /*ID 55 |EDIFICIO ACADEMICO 2*/ 
    ('691E', 100, 1, 16, 2, 1, NOW(), NOW()),               /*ID 56 |EDIFICIO ACADEMICO 2*/ 
    ('691F', 100, 1, 16, 2, 1, NOW(), NOW()),               /*ID 57 |EDIFICIO ACADEMICO 2*/ 

    ('692A', 100, 2, 16, 2, 1, NOW(), NOW()),               /*ID 58 |EDIFICIO ACADEMICO 2*/ 
    ('692B', 100, 2, 16, 2, 1, NOW(), NOW()),               /*ID 59 |EDIFICIO ACADEMICO 2*/ 
    ('692C', 100, 2, 16, 2, 1, NOW(), NOW()),               /*ID 60 |EDIFICIO ACADEMICO 2*/ 
    ('692D', 100, 2, 16, 2, 1, NOW(), NOW()),               /*ID 61 |EDIFICIO ACADEMICO 2*/ 
    ('692E', 100, 2, 16, 2, 1, NOW(), NOW()),               /*ID 62 |EDIFICIO ACADEMICO 2*/ 
    ('692F', 100, 2, 16, 2, 1, NOW(), NOW()),               /*ID 63 |EDIFICIO ACADEMICO 2*/ 
    ('692G',  75, 2, 16, 2, 1,  NOW(), NOW()),               /*ID 64 |EDIFICIO ACADEMICO 2*/ 
    ('692H',  75, 2, 16, 2, 1,  NOW(), NOW()),               /*ID 65 |EDIFICIO ACADEMICO 2*/ 

    ('693A',        100, 2, 16, 2, 1,        NOW(), NOW()),        /*ID 66 |EDIFICIO ACADEMICO 2*/ 
    ('693B',        100, 2, 16, 2, 1,        NOW(), NOW()),        /*ID 67 |EDIFICIO ACADEMICO 2*/ 
    ('693C',        100, 2, 16, 2, 1,        NOW(), NOW()),        /*ID 68 |EDIFICIO ACADEMICO 2*/ 
    ('693D',        100, 2, 16, 2, 1,        NOW(), NOW()),        /*ID 69 |EDIFICIO ACADEMICO 2*/ 
    ('AUDITORIO 2', 300, 2, 16, 3, 1,        NOW(), NOW()),        /*ID 70 |EDIFICIO ACADEMICO 2*/ 

    ('660',     50, 0, 65, 1, 1, NOW(), NOW()),          /*ID 71 |AULAS INF-LAB*/ 
    ('661',     50, 0, 65, 1, 1, NOW(), NOW()),          /*ID 72 |AULAS INF-LAB*/ 

    ('LABORATORIO DE COMPUTO 1',     50, 0, 63, 1, 1, NOW(), NOW()),          /*ID 73 |AULAS INF-LAB*/ 
    ('LABORATORIO DE COMPUTO 2',     50, 0, 63, 1, 1, NOW(), NOW()),          /*ID 74 |AULAS INF-LAB*/ 
    ('LABORATORIO DE REDES',         25, 0, 63, 1, 1, NOW(), NOW()),          /*ID 75 |AULAS INF-LAB*/ 
    ('LABORATORIO DE DESARROLLO',    25, 0, 63, 1, 1, NOW(), NOW()),          /*ID 76 |AULAS INF-LAB*/ 
    ('LABORATORIO DE MANTENIMIENTO', 25, 0, 63, 1, 1, NOW(), NOW()),          /*ID 77 |AULAS INF-LAB*/ 

    ('LABORATORIO DE COMPUTO 3',                   50, 2, 64, 1, 1, NOW(), NOW()),          /*ID 78 |EDIFICIO MEMI*/ 
    ('LABORATORIO DE COMPUTO 4 - VIRTUALIZACION',  50, 2, 64, 1, 1, NOW(), NOW()),          /*ID 79 |EDIFICIO MEMI*/ 
    ('AUDITORIO DE USO MULTIPLE',                  75, 2, 64, 3, 1, NOW(), NOW()),          /*ID 80 |EDIFICIO MEMI*/ 

    ('667A', 50, 0, 10, 2, 1, NOW(), NOW()),                /*ID 81 |EDIFICIO ACADEMICO 2*/ 
    ('667B', 50, 0, 10, 2, 1, NOW(), NOW()),                /*ID 82 |EDIFICIO ACADEMICO 2*/ 
    ('668',  50, 0, 10, 2, 1, NOW(), NOW()),                /*ID 83 |EDIFICIO ACADEMICO 2*/ 
    
    ('669A', 100, 1, 10, 2, 1, NOW(), NOW()),               /*ID 84 |EDIFICIO ACADEMICO 2*/ 
    ('669B', 100, 1, 10, 2, 1, NOW(), NOW()),               /*ID 85 |EDIFICIO ACADEMICO 2*/ 
    ('670',  100, 1, 10, 2, 1, NOW(), NOW()),               /*ID 86 |EDIFICIO ACADEMICO 2*/ 

    ('671',  100, 2, 10, 2, 1, NOW(), NOW()),               /*ID 87 |EDIFICIO ACADEMICO 2*/ 
    ('671A', 100, 2, 10, 2, 1, NOW(), NOW()),               /*ID 88 |EDIFICIO ACADEMICO 2*/ 
    ('671B', 100, 2, 10, 2, 1, NOW(), NOW()),               /*ID 89 |EDIFICIO ACADEMICO 2*/ 
    ('671C', 100, 2, 10, 2, 1, NOW(), NOW()),               /*ID 90 |EDIFICIO ACADEMICO 2*/ 
    ('672',  100, 2, 10, 2, 1, NOW(), NOW()),               /*ID 91 |EDIFICIO ACADEMICO 2*/ 

    ('674A', 100, 2, 10, 2, 1,        NOW(), NOW()),        /*ID 92 |EDIFICIO ACADEMICO 2*/ 
    ('674B', 100, 2, 10, 2, 1,        NOW(), NOW()),        /*ID 93 |EDIFICIO ACADEMICO 2*/ 
    ('675',  100, 2, 10, 2, 1,        NOW(), NOW()),        /*ID 94 |EDIFICIO ACADEMICO 2*/ 

    ('680-A', 50, 0, 26, 2, 1, NOW(), NOW()),              /*ID 95 |EDIFICIO ACADEMICO 2*/ 
    ('680-B', 50, 0, 26, 2, 1, NOW(), NOW()),              /*ID 96 |EDIFICIO ACADEMICO 2*/ 
    ('680-C', 50, 0, 26, 2, 1, NOW(), NOW()),              /*ID 97 |EDIFICIO ACADEMICO 2*/ 
    ('680-E', 50, 0, 26, 2, 1, NOW(), NOW()),              /*ID 98 |EDIFICIO ACADEMICO 2*/ 
    ('680-F', 50, 0, 26, 2, 1, NOW(), NOW()),              /*ID 99 |EDIFICIO ACADEMICO 2*/ 
    ('680-G', 50, 0, 26, 2, 1, NOW(), NOW()),              /*ID 100 |EDIFICIO ACADEMICO 2*/ 
    ('680-H', 50, 0, 26, 2, 1, NOW(), NOW()),              /*ID 101 |EDIFICIO ACADEMICO 2*/ 
    ('680-I', 50, 0, 26, 2, 1, NOW(), NOW()),              /*ID 102 |EDIFICIO ACADEMICO 2*/ 

    ('681-A', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 103 |EDIFICIO ACADEMICO 2*/ 
    ('681-B', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 104 |EDIFICIO ACADEMICO 2*/ 
    ('681-C', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 105 |EDIFICIO ACADEMICO 2*/ 
    ('681-D', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 106 |EDIFICIO ACADEMICO 2*/ 
    ('681-E', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 107 |EDIFICIO ACADEMICO 2*/ 
    ('681-F', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 108 |EDIFICIO ACADEMICO 2*/ 
    ('681-G', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 109 |EDIFICIO ACADEMICO 2*/ 
    ('681-H', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 110 |EDIFICIO ACADEMICO 2*/ 
    ('681-I', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 111 |EDIFICIO ACADEMICO 2*/ 
    ('681-J', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 112 |EDIFICIO ACADEMICO 2*/ 
    ('681-K', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 113 |EDIFICIO ACADEMICO 2*/ 
    ('681-L', 100, 1, 26, 2, 1, NOW(), NOW()),               /*ID 114 |EDIFICIO ACADEMICO 2*/ 

    ('682-A', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 115 |EDIFICIO ACADEMICO 2*/ 
    ('682-B', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 116 |EDIFICIO ACADEMICO 2*/ 
    ('682-C', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 117 |EDIFICIO ACADEMICO 2*/ 
    ('682-D', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 118 |EDIFICIO ACADEMICO 2*/ 
    ('682-E', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 119 |EDIFICIO ACADEMICO 2*/ 
    ('682-F', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 120 |EDIFICIO ACADEMICO 2*/ 
    ('682-G',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 121 |EDIFICIO ACADEMICO 2*/ 
    ('682-H',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 122 |EDIFICIO ACADEMICO 2*/ 
    ('682-I', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 123 |EDIFICIO ACADEMICO 2*/ 
    ('682-J',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 124 |EDIFICIO ACADEMICO 2*/ 
    ('682-K',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 125 |EDIFICIO ACADEMICO 2*/ 
    ('682-L',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 126 |EDIFICIO ACADEMICO 2*/ 

    ('683-A', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 127 |EDIFICIO ACADEMICO 2*/ 
    ('683-B', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 128 |EDIFICIO ACADEMICO 2*/ 
    ('683-C', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 129 |EDIFICIO ACADEMICO 2*/ 
    ('683-D', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 130 |EDIFICIO ACADEMICO 2*/ 
    ('683-E', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 131 |EDIFICIO ACADEMICO 2*/ 
    ('683-F', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 132 |EDIFICIO ACADEMICO 2*/ 
    ('683-G',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 133 |EDIFICIO ACADEMICO 2*/ 
    ('683-H',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 134 |EDIFICIO ACADEMICO 2*/ 
    ('683-I', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 135 |EDIFICIO ACADEMICO 2*/ 
    ('683-J',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 136 |EDIFICIO ACADEMICO 2*/ 
    ('683-K',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 137 |EDIFICIO ACADEMICO 2*/ 
    ('683-L',  75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 138 |EDIFICIO ACADEMICO 2*/ 

    ('683-A',  100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 139 |EDIFICIO ACADEMICO 2*/ 
    ('683-B',  100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 140 |EDIFICIO ACADEMICO 2*/ 
    ('683-C',  100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 141 |EDIFICIO ACADEMICO 2*/ 
    ('683-D',  100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 142 |EDIFICIO ACADEMICO 2*/ 
    ('BIBLIO', 100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 143 |EDIFICIO ACADEMICO 2*/ 
    ('683-E',  100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 144 |EDIFICIO ACADEMICO 2*/ 
    ('683-F',  100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 145 |EDIFICIO ACADEMICO 2*/ 
    ('683-G',   75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 146 |EDIFICIO ACADEMICO 2*/ 
    ('683-H',   75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 147 |EDIFICIO ACADEMICO 2*/ 
    ('683-I',  100, 2, 26, 2, 1, NOW(), NOW()),               /*ID 148 |EDIFICIO ACADEMICO 2*/ 
    ('683-J',   75, 2, 26, 2, 1,  NOW(), NOW()),              /*ID 149 |EDIFICIO ACADEMICO 2*/ 
    ('683-K',   75, 2, 26, 2, 1,  NOW(), NOW())               /*ID 150 |EDIFICIO ACADEMICO 2*/ 
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
    reservation
*/
/*
    lunes:     '2024-04-22'
    martes:    '2024-04-23'
    miercoles: '2024-04-24'
    jueves:    '2024-04-25'
    viernes:   '2024-04-26'
    sabado:    '2024-04-27'
    domingo:   '2024-04-28'
*/
insert into reservations (quantity, `repeat`, observation, priority, `date`, parent_id, verified, configuration_flag, academic_period_id, reservation_reason_id, reservation_status_id, created_at, updated_at)
VALUES
    (125, 7, 'Clases', 0, '2024-04-23', 1, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 2, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 3, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 4, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 5, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 6, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 7, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 8, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Practica', 0, '2024-04-25', 9, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/

    (125, 7, 'Practica', 0, '2024-04-22', 10, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/

    (125, 7, 'Practica', 0, '2024-04-24', 11, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/

    (125, 7, 'Practica', 0, '2024-04-24', 12, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/

    (125, 7, 'Practica', 0, '2024-04-24', 13, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/

    (125, 7, 'Practica', 0, '2024-04-25', 14, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 15, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 16, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 17, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 18, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 19, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 20, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-24', 21, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-25', 22, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-26', 23, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-24', 24, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 25, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-27', 26, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 27, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 28, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 29, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-25', 30, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-26', 31, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-26', 32, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-23', 33, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 34, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-25', 35, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-23', 36, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-24', 37, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 38, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-22', 39, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-24', 40, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-26', 41, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-23', 42, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-24', 43, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-26', 44, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-24', 45, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 46, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-27', 47, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-24', 48, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 49, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-27', 50, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Practica', 0, '2024-04-23', 51, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-24', 52, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 53, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 54, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 55, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-25', 56, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 57, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 58, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 59, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 60, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 61, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 62, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-25', 63, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-26', 64, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-27', 65, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-22', 66, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-23', 67, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 68, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-23', 69, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-24', 70, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-26', 71, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-24', 72, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-24', 73, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 74, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-23', 75, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-24', 76, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-26', 77, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-22', 78, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-24', 79, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 80, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-23', 81, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-24', 82, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-25', 83, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Practica', 0, '2024-04-22', 84, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-23', 85, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-25', 86, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 87, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 88, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 89, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 90, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 91, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 92, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 93, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 94, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 95, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 96, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 97, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 98, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 99, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-22', 100, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-23', 101, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-25', 102, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 103, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 104, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases',   0, '2024-04-22', 105, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases',   0, '2024-04-23', 106, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Practica', 0, '2024-04-25', 107, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 108, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 109, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 110, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 111, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 112, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 113, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 114, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-27', 115, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 116, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 117, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 118, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 119, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 120, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-27', 121, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 122, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 123, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 124, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 125, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 126, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 127, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 128, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 129, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 130, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 131, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 132, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 133, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-24', 134, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 135, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 136, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 137, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 138, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 139, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 140, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 141, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 142, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 143, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 144, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 145, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 146, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 147, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 148, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 149, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 150, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 151, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 152, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 153, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 154, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 155, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 156, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 157, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 158, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 159, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-27', 160, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 161, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 162, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 163, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-24', 164, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 165, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 166, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 167, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 168, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 169, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 170, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 171, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 172, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 173, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 174, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 175, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 176, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 177, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 178, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 179, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 180, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 181, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 182, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 183, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 184, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 185, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 186, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 187, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 188, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 189, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 190, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 191, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 192, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 193, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 194, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 195, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 196, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 197, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 198, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 199, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-24', 200, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 201, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 202, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 203, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 204, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 205, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 206, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 207, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 208, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 209, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 210, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 211, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 212, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 213, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 214, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 215, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 216, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 217, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 218, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 219, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 220, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 221, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-26', 222, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-27', 223, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 224, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 225, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 226, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 227, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 228, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 229, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 230, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 231, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 232, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 233, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 234, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 235, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 236, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 237, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-24', 238, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 239, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 240, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 241, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 242, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-26', 243, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 244, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 245, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 246, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-23', 247, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 248, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 249, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 250, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-25', 251, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-23', 252, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 253, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 254, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 255, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-27', 256, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-27', 257, 1, 1, 1, 2, 1, NOW(), NOW()),         /*2 INGLES I - GRUPO 1*/

    (125, 7, 'Clases', 0, '2024-04-22', 258, 1, 1, 1, 2, 1, NOW(), NOW()),         /*1 INGLES I - GRUPO 1*/
    (125, 7, 'Clases', 0, '2024-04-24', 259, 1, 1, 1, 2, 1, NOW(), NOW())         /*2 INGLES I - GRUPO 1*/
;
/*
    time_slot_reservations
*/
insert into reservation_time_slot (reservation_id, time_slot_id, created_at, updated_at)
values
    (1, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (1, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (2, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (2, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (3, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (3, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (4, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (4, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (5, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (5, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (6, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (6, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (7, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (7, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (8, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (8, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (9, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (9, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (10, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (10, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (11, 9,  NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (11, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (12, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (13, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (13, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (13, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (14, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (14, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (15, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (15, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (16, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (16, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (17, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (17, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (18, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (18, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (19, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (19, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (20, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (20, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (21, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (21, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (22, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (22, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (23, 9,  NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (23, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (24, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (24, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (25, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (25, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (26, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (26, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (27, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (27, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (28, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (28, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (29, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (29, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (30, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (30, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (31, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (31, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (32, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (32, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (33, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (33, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (34, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (34, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (35, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (35, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (36, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (36, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (37, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (37, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (38, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (38, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (39, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (39, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (40, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (40, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (41, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (41, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (42, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (42, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (43, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (43, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (44, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (44, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (45, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (45, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (46, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (46, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (47, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (47, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (48, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (48, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (49, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (49, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (50, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (50, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (51, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (51, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (52, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (52, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (53, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (53, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (54, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (54, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (55, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (55, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (56, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (56, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (57, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (57, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (58, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (58, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (59, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (59, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (60, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (60, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (61, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (61, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (62, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (62, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (63, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (63, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (64, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (64, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (65, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (65, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (66, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (66, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (67, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (67, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (68, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (68, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (69, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (69, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (70, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (70, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (71, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (71, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (72, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (72, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (73, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (73, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (74, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (74, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (75, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (75, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (76, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (76, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (77, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (77, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (78, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (78, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (79, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (79, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (80, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (80, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (81, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (81, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (82, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (82, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (83, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (83, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (84, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (84, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (85, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (85, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (86, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (86, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (87, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (87, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (88, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (88, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (89, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (89, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (90, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (90, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (91, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (91, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (92, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (92, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (93, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (93, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (94, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (94, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (95, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (95, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (96, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (96, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (97, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (97, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (98, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (98, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (99, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (99, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (100, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (100, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (101, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (101, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (102, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (102, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (103, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (103, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (104, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (104, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (105, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (105, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (106, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (106, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (107, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (107, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (108, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (108, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (109, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (109, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (110, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (110, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (111, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (111, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (112, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (112, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (113, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (113, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (114, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (114, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (115, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (115, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (116, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (116, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (117, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (117, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (118, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (118, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (119, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (119, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (120, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (120, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (121, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (121, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (122, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (122, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (123, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (123, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (124, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (124, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (125, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (125, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (126, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (126, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (127, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (127, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (128, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (128, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (129, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (129, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (130, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (130, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (131, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (131, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (132, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (132, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (133, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (133, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (134, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (134, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (135, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (135, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (136, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (136, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (137, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (137, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (138, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (138, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (139, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (139, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (140, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (140, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (141, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (141, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (142, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (142, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (143, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (143, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (144, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (144, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (145, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (145, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (146, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (146, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (147, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (147, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (148, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (148, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (149, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (149, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (150, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (150, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (151, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (151, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (152, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (152, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (153, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (153, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (154, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (154, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (155, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (155, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (156, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (156, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (157, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (157, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (158, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (158, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (159, 19, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (159, 20, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (160, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (160, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (161, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (161, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (162, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (162, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (163, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (163, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (164, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (164, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (165, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (165, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (166, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (166, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (167, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (167, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (168, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (168, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (169, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (169, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (170, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (170, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (171, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (171, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (172, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (172, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (173, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (173, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (174, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (174, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (175, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (175, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (176, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (176, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (177, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (177, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (178, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (178, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (179, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (179, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (180, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (180, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (181, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (181, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (182, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (182, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (183, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (183, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (184, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (184, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (185, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (185, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (186, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (186, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (187, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (187, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (188, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (188, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (189, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (189, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (190, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (190, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (191, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (191, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (192, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (192, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (193, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (193, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (194, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (194, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (195, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (195, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (196, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (196, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (197, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (197, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (198, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (198, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (199, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (199, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (200, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (200, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (201, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (201, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (202, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (202, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (203, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (203, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (204, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (204, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (205, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (205, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (206, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (206, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (207, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (207, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (208, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (208, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (209, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (209, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (210, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (210, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (211, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (211, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (212, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (212, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (213, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (213, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (214, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (214, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (215, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (215, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (216, 13, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (216, 14, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (217, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (217, 2, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (218, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (218, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (219, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (219, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (220, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (220, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (221, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (221, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (222, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (222, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (223, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (223, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (224, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (224, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (225, 17, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (225, 18, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (226, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (226, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (227, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (227, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (228, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (228, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (229, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (229, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (230, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (230, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (231, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (231, 10, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (232, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (232, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (233, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (233, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (234, 15, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (234, 16, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (235, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (235, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (236, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (236, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (237, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (237, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (238, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (238, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (239, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (239, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (240, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (240, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/    

    (241, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (241, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (242, 19, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (242, 20, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (243, 19, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (243, 20, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (244, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (244, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (245, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (245, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (246, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (246, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (247, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (247, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (248, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (248, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (249, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (249, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (250, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (250, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/    
    
    (251, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (251, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (252, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (252, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (253, 11, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (253, 12, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (254, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (254, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (255, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (255, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (256, 3, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (256, 4, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (257, 5, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (257, 6, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (258, 7, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (258, 8, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    
    (259, 9, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (259, 10, NOW(), NOW())              /*INGLES I - GRUPO 1*/
;
/*
    reservation_classrooms
*/
insert into classroom_reservation (reservation_id, classroom_id, created_at, updated_at)
values 
    (1, 67, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (2, 55, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (3, 49, NOW(), NOW()),              /*INGLES I - GRUPO 2*/
    (4, 49, NOW(), NOW()),              /*INGLES I - GRUPO 2*/

    (5, 104, NOW(), NOW()),              /*INGLES I - GRUPO 3*/
    (6, 65,  NOW(), NOW()),              /*INGLES I - GRUPO 3*/

    (7, 41, NOW(), NOW()),              /*INGLES II - GRUPO 1*/
    (8, 60, NOW(), NOW()),              /*INGLES II - GRUPO 1*/

    ( 9, 22, NOW(), NOW()),              /*INGLES II - GRUPO 2*/
    
    (10, 20, NOW(), NOW()),              /*INGLES II - GRUPO 2*/

    (11, 20, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    
    (12, 22, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    
    (13, 20, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/

    (14, 20, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    
    (15, 72, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (16, 60, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (17, 63, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/

    (18, 36, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (19, 14, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (20,  1, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/

    (21, 54, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (22, 29, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (23,  1, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/

    (24, 36, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (25, 36, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (26, 16, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/

    (27, 25, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (28, 47, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (29, 62, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/

    (30, 52, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (31, 56, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (32, 26, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/

    (33, 53, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (34, 52, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (35, 53, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    
    (36, 14, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (37, 53, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (38, 27, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/

    (39,  1, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (40,  8, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (41, 27, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/

    (42, 26, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (43, 68, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (44, 56, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/

    (45, 47, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (46, 26, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (47, 54, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/

    (48, 61, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (49, 56, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (50, 72, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/

    (51, 48, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (52, 62, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (53, 57, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/

    (54, 38, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (55, 72, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    
    (56, 53, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (57, 54, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    (58, 64, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6*/
    (59, 42, NOW(), NOW()),             /*CALCULO I - GRUPO 1*/
    
    (60, 50, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (61, 58, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1, 2, 3*/
    (62, 50, NOW(), NOW()),             /*FISICA GENERAL - GRUPO 1, 2*/

    (63, 71, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7, 10*/
    (64, 52, NOW(), NOW()),             /*INGLES II - GRUPO 1, 2*/
    (65, 58, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    (66, 27, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (67, 61, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (68, 59, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    (69,  8, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (70, 27, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (71, 16, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/

    (72, 55, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (73, 28, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (74, 66, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (75, 16, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (76, 41, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (77, 48, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (78, 26, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (79, 26, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (80, 27, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/

    (81, 25, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/
    (82, 54, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (83, 48, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/

    (84, 53, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (85,  1, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (86, 69, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (87, 41, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (88, 49, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (89, 53, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (90, 27, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (91, 73, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (92, 73, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (93, 52, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (94, 25, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (95, 66, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (96, 69, NOW(), NOW()),              /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (97, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98,  1, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (100, 57, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 60, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (102, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (103, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (105, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (106, 71, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (107, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (108, 29, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (109, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (110, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (111, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (112, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (113, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (114, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (115, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (116, 55, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (117, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (118, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (119,  8, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (120, 27, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (121, 36, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (122, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (123, 72, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (124, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (125, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (126, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (127, 69, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (128, 65, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (129, 67, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (130, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (131, 59, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (132,  1, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (133, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (134, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (135, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (136, 66, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (137, 29, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (138, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (139,  8, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (140, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (141, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (142, 69, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (143, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (144, 57, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (145, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (146, 59, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (147, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (148,  8, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (149, 60, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (150, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (151, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (152, 26, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (153, 28, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (154, 27, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (155, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (156, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (157, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (158, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (159, 46, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (160, 80, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (161, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (162, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (163, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (164, 65, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (165, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (166, 55, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (167, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (168, 74, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (169, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (170, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (171, 58, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (172, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (173, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (174, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (175, 60, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (176, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (177, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (178, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (179, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (180, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (181, 55, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (182, 59, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (183, 66, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (184, 60, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (185, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (186, 66, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (187, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (188, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (189, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (190, 65, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (191, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (192, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (193, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (194, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (195, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (196, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (197, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (198, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (199, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (200, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (201, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (202, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (203, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (204, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (205, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (206, 60, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (207, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (208, 64, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (209, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (210, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (211, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (212, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (213, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (214, 28, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (215, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (216, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (217, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (218, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (219, 55, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (220, 72, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (221, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (222, 69, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (223, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (224, 67, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (225, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (226, 57, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (227, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (228, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (229, 65, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (230, 55, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (231, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (232, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (233, 65, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (234, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (235, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (236, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (237, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (238, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (239, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (240, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (241, 64, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (242, 64, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (243, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (244, 63, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (245, 64, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (246, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (247, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (248, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (249, 74, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (250, 74, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (251, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (252, 28, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (253, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (254, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (255, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (256, 67, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (257, 58, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (258, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (259, 104, NOW(), NOW())             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
; 
/*
    person_reservation
*/
insert into person_reservation (reservation_id, person_id, created_at, updated_at)
values 
    (1, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (2, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (3, 1, NOW(), NOW()),              /*INGLES I - GRUPO 2*/
    (4, 1, NOW(), NOW()),              /*INGLES I - GRUPO 2*/

    (5, 2, NOW(), NOW()),              /*INGLES I - GRUPO 3*/
    (6, 2,  NOW(), NOW()),              /*INGLES I - GRUPO 3*/

    (7, 3, NOW(), NOW()),              /*INGLES II - GRUPO 1*/
    (8, 3, NOW(), NOW()),              /*INGLES II - GRUPO 1*/

    ( 9, 4, NOW(), NOW()),              /*INGLES II - GRUPO 2*/
    
    (10, 6, NOW(), NOW()),              /*INGLES II - GRUPO 2*/

    (11, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    
    (12, 6, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    
    (13, 8, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/

    (14, 8, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    
    (15, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (16, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (17, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/

    (18, 10, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (19, 10, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (20, 10, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/

    (21, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (22, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (23, 11, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/

    (24, 12, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (25, 12, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (26, 12, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/

    (27, 13, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (28, 13, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (29, 13, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/

    (30, 14, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (31, 14, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (32, 14, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/

    (33, 15, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (34, 15, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (35, 15, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    
    (36, 16, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (37, 16, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (38, 16, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/

    (39,  17, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (40,  17, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (41, 17, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/

    (42, 18, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (43, 18, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (44, 18, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/

    (45, 19, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (46, 19, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (47, 19, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/

    (48, 14, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (49, 14, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (50, 14, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/

    (51, 15, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (52, 15, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (53, 15, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/

    (54, 2, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (55, 2, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    
    (56, 2, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (57, 2, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    (58, 2, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6*/
    (59, 2, NOW(), NOW()),             /*CALCULO I - GRUPO 1*/
    
    (60, 20, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (61, 20, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1, 2, 3*/
    (62, 20, NOW(), NOW()),             /*FISICA GENERAL - GRUPO 1, 2*/

    (63, 21, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7, 10*/
    (64, 21, NOW(), NOW()),             /*INGLES II - GRUPO 1, 2*/
    (65, 21, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    (66, 22, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (67, 22, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (68, 22, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    (69,  23, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (70, 23, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (71, 23, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/

    (72, 24, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (73, 24, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (74, 24, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (75, 25, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (76, 25, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (77, 25, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (78, 16, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (79, 16, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (80, 16, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/

    (81, 16, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/
    (82, 16, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (83, 16, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/

    (84, 26, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (85,  26, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (86, 26, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (87, 27, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (88, 27, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (89, 16, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (90, 16, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (91, 25, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (92, 25, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (93, 25, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (94, 28, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (95, 28, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (96, 28, NOW(), NOW()),              /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (97, 29, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98,  29, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 29, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (100, 30, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 30, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/    
    (102, 30, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (103, 31, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 31, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (105, 32, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (106, 32, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (107, 33, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (108, 33, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (109, 33, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (110, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (111, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (112, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (113, 35, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (114, 35, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (115, 35, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (116, 32, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (117, 32, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (118, 32, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (119, 36, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (120, 36, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (121, 36, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (122, 22, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (123, 22, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (124, 22, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (125, 37, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (126, 37, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (127, 37, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (128, 38, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (129, 38, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (130, 38, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (131, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (132,  39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (133, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (134, 14, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (135, 14, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (136, 14, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (137, 14, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (138, 14, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (139, 14, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (140, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (141, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (142, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (143, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (144, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (145, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (146, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (147, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (148,  40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (149, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (150, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (151, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (152, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (153, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (154, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (155, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (156, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (157, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (158, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (159, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (160, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (161, 43, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (162, 43, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (163, 43, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (164, 44, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (165, 44, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (166, 44, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (167, 19, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (168, 19, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (169, 19, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (170, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (171, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (172, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (173, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (174, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (175, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (176, 46, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (177, 46, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (178, 46, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (179, 33, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (180, 33, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (181, 33, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (182, 25, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (183, 25, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (184, 25, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (185, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (186, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (187, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (188, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (189, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (190, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (191, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (192, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (193, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (194, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (195, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (196, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (197, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (198, 43, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (199, 43, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (200, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (201, 39, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (202, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (203, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (204, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (205, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (206, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (207, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (208, 18, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (209, 18, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (210, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (211, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (212, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (213, 16, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (214, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (215, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (216, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (217, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (218, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (219, 37, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (220, 37, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (221, 37, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (222, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (223, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (224, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (225, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (226, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (227, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (228, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (229, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (230, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (231, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (232, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (233, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (234, 34, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (235, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (236, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (237, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (238, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (239, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (240, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (241, 15, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (242, 51, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (243, 51, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (244, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (245, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (246, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (247, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (248, 19, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (249, 19, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (250, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (251, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (252, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (253, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (254, 32, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (255, 32, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (256, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (257, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (258, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (259, 47, NOW(), NOW())             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
; 
/*
    person_reservation_teacher_subject
*/
insert into person_reservation_teacher_subject (person_reservation_id, teacher_subject_id, created_at, updated_at)
values 
    (1, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/
    (2, 1, NOW(), NOW()),              /*INGLES I - GRUPO 1*/

    (3, 2, NOW(), NOW()),              /*INGLES I - GRUPO 2*/
    (4, 2, NOW(), NOW()),              /*INGLES I - GRUPO 2*/

    (5, 3, NOW(), NOW()),              /*INGLES I - GRUPO 3*/
    (6, 3,  NOW(), NOW()),              /*INGLES I - GRUPO 3*/

    (7, 4, NOW(), NOW()),              /*INGLES II - GRUPO 1*/
    (8, 4, NOW(), NOW()),              /*INGLES II - GRUPO 1*/

    ( 9, 5, NOW(), NOW()),              /*INGLES II - GRUPO 2*/
    
    (10, 6, NOW(), NOW()),              /*INGLES II - GRUPO 2*/

    (11, 7, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    
    (12, 8, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/
    
    (13, 9, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1*/

    (14, 10, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    
    (15, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (16, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 2*/
    (17, 11, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/

    (18, 12, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (19, 12, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 3*/
    (20, 12, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/

    (21, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (22, 13, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 4*/
    (23, 13, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/

    (24, 14, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (25, 14, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 5*/
    (26, 14, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/

    (27, 15, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (28, 15, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 6*/
    (29, 15, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/

    (30, 16, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (31, 16, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7*/
    (32, 16, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/

    (33, 17, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (34, 17, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 10*/
    (35, 17, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    
    (36, 18, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (37, 18, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1*/
    (38, 18, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/

    (39, 19, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (40, 19, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 2*/
    (41, 19, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/

    (42, 20, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (43, 20, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 3*/
    (44, 20, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/

    (45, 21, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (46, 21, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 5*/
    (47, 21, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/

    (48, 22, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (49, 22, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/
    (50, 22, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 2*/

    (51, 23, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (52, 23, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/
    (53, 23, NOW(), NOW()),             /*ALGORITMOS AVANZADOS - GRUPO 1*/

    (54, 24, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    (55, 24, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 1*/
    
    (56, 25, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/
    (57, 25, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    (58, 26, NOW(), NOW()),              /*INTRODUCCION A LA PROGRAMACION - GRUPO 1, 6*/
    (59, 26, NOW(), NOW()),             /*CALCULO I - GRUPO 1*/
    
    (60, 27, NOW(), NOW()),             /*ARQUITECTURA DE COMPUTADORAS I - GRUPO 1*/
    (61, 27, NOW(), NOW()),             /*ELEM. DE PROGRAMACION Y ESTRUC. DE DATOS - GRUPO 1, 2, 3*/
    (62, 27, NOW(), NOW()),             /*FISICA GENERAL - GRUPO 1, 2*/

    (63, 28, NOW(), NOW()),             /*INTRODUCCION A LA PROGRAMACION - GRUPO 7, 10*/
    (64, 28, NOW(), NOW()),             /*INGLES II - GRUPO 1, 2*/
    (65, 28, NOW(), NOW()),             /*TALLER DE INGENIERIA DE SOFTWARE - GRUPO 2*/

    (66, 29, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (67, 29, NOW(), NOW()),              /*CALCULO NUMERICO - GRUPO 1*/
    (68, 29, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/

    (69, 30, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (70, 30, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/
    (71, 30, NOW(), NOW()),              /*TEORIA DE GRAFOS - GRUPO 1*/

    (72, 31, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (73, 31, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (74, 31, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/

    (75, 32, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (76, 32, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (77, 32, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (78, 33, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (79, 33, NOW(), NOW()),              /*PROGRAMACION FUNCIONAL - GRUPO 1*/
    (80, 33, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/

    (81, 34, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 2*/
    (82, 34, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (83, 34, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/

    (84, 35, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (85, 35, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (86, 35, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (87, 36, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (88, 36, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (89, 37, NOW(), NOW()),             /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/
    (90, 37, NOW(), NOW()),              /*INTELIGENCIA ARTIFICIAL I - GRUPO 1*/

    (91, 38, NOW(), NOW()),             /*BASE DE DATOS II - GRUPO 1*/
    (92, 38, NOW(), NOW()),             /*BASE DE DATOS I - GRUPO 1*/
    (93, 38, NOW(), NOW()),             /*PROGRAMACION FUNCIONAL - GRUPO 1*/

    (94, 39, NOW(), NOW()),             /*TEORIA DE GRAFOS - GRUPO 1*/
    (95, 39, NOW(), NOW()),             /*CALCULO NUMERICO - GRUPO 1*/
    (96, 39, NOW(), NOW()),              /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (97, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (98, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (99, 40, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (100, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (101, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/    
    (102, 41, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (103, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (104, 42, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (105, 43, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (106, 43, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (107, 44, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (108, 44, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (109, 44, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (110, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (111, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (112, 45, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (113, 46, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (114, 46, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (115, 46, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (116, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (117, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (118, 47, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (119, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (120, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (121, 48, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (122, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (123, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (124, 49, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (125, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (126, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (127, 50, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (128, 51, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (129, 51, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (130, 51, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (131, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (132, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (133, 52, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (134, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (135, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (136, 53, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (137, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (138, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (139, 54, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (140, 55, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (141, 55, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (142, 55, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (143, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (144, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (145, 56, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (146, 57, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (147, 57, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (148, 57, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (149, 58, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (150, 58, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (151, 58, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (152, 59, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (153, 59, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (154, 59, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (155, 60, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (156, 60, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (157, 60, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (158, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (159, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (160, 61, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (161, 62, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (162, 62, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (163, 62, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (164, 63, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (165, 63, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (166, 63, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (167, 64, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (168, 64, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (169, 64, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (170, 65, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (171, 65, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (172, 65, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (173, 66, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (174, 66, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (175, 66, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (176, 67, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (177, 67, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (178, 67, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (179, 68, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (180, 68, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (181, 68, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (182, 69, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (183, 69, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (184, 69, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (185, 70, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (186, 70, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (187, 70, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (188, 71, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (189, 71, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (190, 71, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (191, 72, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (192, 72, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (193, 72, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (194, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (195, 73, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (196, 74, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (197, 74, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (198, 75, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (199, 75, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (200, 76, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (201, 76, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (202, 77, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (203, 77, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (204, 77, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (205, 78, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (206, 78, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (207, 78, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (208, 79, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (209, 79, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (210, 80, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (211, 80, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (212, 81, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (213, 81, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (214, 82, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (215, 82, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (216, 82, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (217, 83, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (218, 83, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (219, 84, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (220, 84, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (221, 84, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (222, 85, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (223, 85, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (224, 86, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (225, 86, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (226, 87, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (227, 87, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (228, 87, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (229, 88, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (230, 88, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (231, 88, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (232, 89, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (233, 89, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (234, 89, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (235, 90, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (236, 90, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (237, 90, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (238, 91, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (239, 91, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (240, 92, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (241, 92, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/

    (242, 93, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (243, 93, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (244, 94, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (245, 94, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (246, 95, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (247, 95, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (248, 96, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (249, 96, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (250, 97, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (251, 97, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (252, 98, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (253, 98, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (254, 99, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (255, 99, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (256, 100, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (257, 100, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    
    (258, 101, NOW(), NOW()),             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
    (259, 101, NOW(), NOW())             /*96  RESERVA ESPECIAL - EXAMEN DE INGRESO*/
; 