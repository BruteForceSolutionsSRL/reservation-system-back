<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

use App\Models\{
    Person,
};

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $people = [
            ['name' => 'MARIA BENITA',   'last_name' => 'CESPEDES GUIZADA',    'user_name' => 'MARIA_BENITA_CESPEDES',    'email' => 'xdxdmaria.c@fcyt.umss.edu'],                   /*ID 1*/                          
            ['name' => 'MAGDA LENA',     'last_name' => 'PEETERS ILONAA',      'user_name' => 'MAGDA_LENA_PEETERS',       'email' => 'xdxdmagda.p@fcyt.umss.edu'],                   /*ID 2*/                
            ['name' => 'ROBERTO',        'last_name' => 'VALENZUELA MIRANDA',  'user_name' => 'ROBERTO_VALENZUELA',       'email' => 'xdxdroberto.v@fcyt.umss.edu'],                 /*ID 3*/    
            ['name' => 'RENE',           'last_name' => 'MOREIRA CALIZAYA',    'user_name' => 'RENE_MOREIRA',             'email' => 'xdxdrene.m@fcyt.umss.edu'],                    /*ID 4*/
            ['name' => 'JOSE FERNANDO',  'last_name' => 'PARISACA ALTAMIRADO', 'user_name' => 'JOSE_FERNANDO_PARISACA',   'email' => 'xdxdjose.p@fcyt.umss.edu'],                    /*ID 5*/
            ['name' => 'ROCIO',          'last_name' => 'GUZMAN SAAVEDRA',     'user_name' => 'ROCIO_GUZMAN',             'email' => 'xdxdrocio.g@fcyt.umss.edu'],                   /*ID 6*/
            ['name' => 'MIGUEL ANGEL',   'last_name' => 'ORDONEZ SALVATIERRA', 'user_name' => 'MIGUEL_ANGEL_ORDONEZ',     'email' => 'xdxdmiguel.o@fcyt.umss.edu'],                  /*ID 7*/
            ['name' => 'JUAN CARLOS',    'last_name' => 'TERRAZAS VARGAS',     'user_name' => 'JUAN_CARLOS_TERRAZAS',     'email' => 'xdxdjuancarlos.t@fcyt.umss.edu'],                    /*ID 8*/
            ['name' => 'JUAN ANTONIO',   'last_name' => 'RODRIGUEZ SEJAS',     'user_name' => 'JUAN_ANTONIO_RODRIGUEZ',   'email' => 'xdxdjuan.r@fcyt.umss.edu'],                    /*ID 9*/
            ['name' => 'ALVARO HERNANDO','last_name' => 'CARRASCO CALVO',      'user_name' => 'ALVARO_HERNANDO_CARRASCO', 'email' => 'xdxdalvaro.c@fcyt.umss.edu'],                  /*ID 10*/
            ['name' => 'GUALBERTO',      'last_name' => 'LEON ROMERO',         'user_name' => 'GUALBERTO_LEON',           'email' => 'xdxdgualberto.l@fcyt.umss.edu'],               /*ID 11*/
            ['name' => 'POR DESIGNAR',   'last_name' => '',                    'user_name' => 'POR_DESIGNAR123',          'email' => 'designar'],                                    /*ID 12*/
            ['name' => 'RAMIRO',         'last_name' => 'ROJAS ZURITA',        'user_name' => 'RAMIRO_ROJAS',             'email' => 'xdxdramiro.r@fcyt.umss.edu'],                  /*ID 13*/
            ['name' => 'CARLA',          'last_name' => 'SALAZAR SERRUDO',     'user_name' => 'CARLA_SALAZAR',            'email' => 'xdxdcarla.s@fcyt.umss.edu'],                   /*ID 14*/
            ['name' => 'VLADIMIR ABEL',  'last_name' => 'COSTAS JAUREGUI',      'user_name' => 'VLADIMIR_ABEL_COSTAS',    'email' => 'xdxdvladimir.c@fcyt.umss.edu'],                /*ID 15*/    
            ['name' => 'LETICIA',        'last_name' => 'BLANCO COCA',          'user_name' => 'LETICIA_BLANCO',          'email' => 'xdxdleticia.b@fcyt.umss.edu'],                 /*ID 16*/    
            ['name' => 'HERNAN',         'last_name' => 'USTARIZ VARGAS',       'user_name' => 'HERNAN_USTARIZ',          'email' => 'xdxdhernan.u@fcyt.umss.edu'],                  /*ID 17*/    
            ['name' => 'HENRY FRANK',    'last_name' => 'VILLARROEL TAPIA',     'user_name' => 'HENRY_FRANK_VILLARROEL',  'email' => 'xdxdhenry.v@fcyt.umss.edu'],                   /*ID 18*/
            ['name' => 'VICTOR HUGO',    'last_name' => 'MONTANO QUIROGA',      'user_name' => 'VICTOR_HUGO_MONTANO',     'email' => 'xdxdvictor.m@fcyt.umss.edu'],                  /*ID 19*/
            ['name' => 'WALTER OSCAR',   'last_name' => 'SALINAS PERICON',      'user_name' => 'WALTER_OSCAR_SALINAS',    'email' => 'xdxdwalter.s@fcyt.umss.edu'],                  /*ID 20*/
            ['name' => 'HERNAN VICTOR',  'last_name' => 'SILVA RAMOS',          'user_name' => 'HERNAN_VICTOR_SILVA',     'email' => 'xdxdhernan.s@fcyt.umss.edu'],                  /*ID 21*/    
            ['name' => 'JOSE ROBERTO',   'last_name' => 'OMONTE OJALVO',        'user_name' => 'JOSE_ROBERTO_OMONTE',     'email' => 'xdxdjose.o@fcyt.umss.edu'],                    /*ID 22*/    
            ['name' => 'AMILCAR SAUL',   'last_name' => 'MARTINEZ MAIDA',       'user_name' => 'AMILCAR_SAUL_MARTINEZ',   'email' => 'xdxdamilcar.m@fcyt.umss.edu'],                 /*ID 23*/    
            ['name' => 'JUAN',           'last_name' => 'TERRAZAS LOBO',        'user_name' => 'JUAN_TERRAZAS',           'email' => 'xdxdjuan.t@fcyt.umss.edu'],                    /*ID 24*/    
            ['name' => 'ROSEMARY',       'last_name' => 'TORRICO BASCOPE',      'user_name' => 'ROSEMARY_TORRICO',        'email' => 'xdxdrosemary.t@fcyt.umss.edu'],                /*ID 25*/    
            ['name' => 'HELDER OCTAVIO', 'last_name' => 'FERNANDEZ GUZMAN',     'user_name' => 'HELDER_OCTAVIO_FERNANDEZ','email' => 'xdxdhelder.f@fcyt.umss.edu'],                  /*ID 26*/    
            ['name' => 'SAMUEL',         'last_name' => 'ACHA PEREZ',           'user_name' => 'SAMUEL_ACHA',             'email' => 'xdxdsamuel.a@fcyt.umss.edu'],                  /*ID 27*/    
            ['name' => 'DEMETRIO',       'last_name' => 'JUCHANI BAZUALDO',     'user_name' => 'DEMETRIO_JUCHANI',        'email' => 'xdxddemetrio.j@fcyt.umss.edu'],                /*ID 28*/    
            ['name' => 'OSCAR A.',       'last_name' => 'ZABALAGA MONTANO',     'user_name' => 'OSCAR_ZABALAGA',          'email' => 'xdxdoscar.z@fcyt.umss.edu'],                   /*ID 29*/    
            ['name' => 'MAURICIO',       'last_name' => 'HOEPFNER REYNOLDS',    'user_name' => 'MAURICIO_HOEPFNER',       'email' => 'xdxddemauricio.h@fcyt.umss.edu'],              /*ID 30*/    
            ['name' => 'LUIS ROBERTO',   'last_name' => 'AGREDA CORRALES',      'user_name' => 'LUIS_ROBERTO_AGREDA',     'email' => 'xdxdluis.a@fcyt.umss.edu'],                    /*ID 31*/    
            ['name' => 'YONY RICHARD',   'last_name' => 'MONTOYA BURGOS',       'user_name' => 'YONY_RICHARD_MONTOYA',    'email' => 'xdxdyony.m@fcyt.umss.edu'],                    /*ID 32*/    
            ['name' => 'INDIRA RICHARD', 'last_name' => 'CAMACHO DEL CASTILLO', 'user_name' => 'INDIRA_RICHARD_CAMACHO',  'email' => 'xdxdindira.c@fcyt.umss.edu'],                  /*ID 33*/    
            ['name' => 'CORINA',         'last_name' => 'FLORES VILLARROEL',    'user_name' => 'CORINA_FLORES',           'email' => 'xdxdcorina.f@fcyt.umss.edu'],                  /*ID 34*/    
            ['name' => 'CARLOS B.',      'last_name' => 'MANZUR SORIA',         'user_name' => 'CARLOS_MANZUR',           'email' => 'xdxdcarlos.m@fcyt.umss.edu'],                  /*ID 35*/    
            ['name' => 'DAVID ALFREDO',  'last_name' => 'DELGADILLO COSSIO',    'user_name' => 'DAVID_ALFREDO_DELGADILLO','email' => 'xdxddavid.d@fcyt.umss.edu'],                   /*ID 36*/    
            ['name' => 'MARCO ANTONIO',  'last_name' => 'MONTECINOS CHOQUE',    'user_name' => 'MARCO_ANTONIO_MONTECINOS','email' => 'xdxdmarco.m@fcyt.umss.edu'],                   /*ID 37*/    
            ['name' => 'VITTER JESUS',   'last_name' => 'MEDRANO PEREZ',        'user_name' => 'VITTER_JESUS_MEDRANO',    'email' => 'xdxdvitter.m@fcyt.umss.edu'],                  /*ID 38*/    
            ['name' => 'BORIS',          'last_name' => 'CALANCHA NAVIA',       'user_name' => 'BORIS_CALANCHA',          'email' => 'xdxdboris.c@fcyt.umss.edu'],                   /*ID 39*/
            ['name' => 'TATIANA',        'last_name' => 'APARICIO YUJA',        'user_name' => 'TATIANA_APARICIO',        'email' => 'xdxdtatiana.a@fcyt.umss.edu'],                 /*ID 40*/    
            ['name' => 'JORGE WALTER',   'last_name' => 'ORELLANA ARAOZ',       'user_name' => 'JORGE_WALTER_ORELLANA',   'email' => 'xdxdjorge.o@fcyt.umss.edu'],                   /*ID 41*/        
            ['name' => 'GROVER HUMBERTO','last_name' => 'CUSSI NICOLAS',        'user_name' => 'GROVER_HUMBERTO_CUSSI',   'email' => 'xdxdgrover.c@fcyt.umss.edu'],                   /*ID 42*/        
            ['name' => 'JUAN MARCELO',   'last_name' => 'FLORES SOLIZ',         'user_name' => 'JUAN_MARCELO_FLORES',     'email' => 'xdxdjuan.f@fcyt.umss.edu'],                    /*ID 43*/        
            ['name' => 'K. ROLANDO',     'last_name' => 'JALDIN ROSALES',       'user_name' => 'ROLANDO_JALDIN',          'email' => 'xdxdrolando.j@fcyt.umss.edu'],                 /*ID 44*/        
            ['name' => 'CARMEN ROSA',    'last_name' => 'GARCIA PEREZ',         'user_name' => 'CARMEN_ROSA_GARCIA',      'email' => 'xdxdcarmenrosa.g@fcyt.umss.edu'],              /*ID 45*/            
            ['name' => 'ERIKA PATRICIA', 'last_name' => 'RODRIGUEZ BILBAO',     'user_name' => 'ERIKA_PATRICIA_RODRIGUEZ','email' => 'xdxderika.r@fcyt.umss.edu'],                   /*ID 46*/            
            ['name' => 'PATRICIA',       'last_name' => 'ROMERO RODRIGUEZ',     'user_name' => 'PATRICIA_ROMERO',         'email' => 'xdxdpatricia.r@fcyt.umss.edu'],                /*ID 47*/            
            ['name' => 'CLAUDIA',        'last_name' => 'URENA HINOJOSA',       'user_name' => 'CLAUDIA_URENA',           'email' => 'xdxdclaudia.u@fcyt.umss.edu'],                 /*ID 48*/            
            ['name' => 'JIMMY',          'last_name' => 'VILLARROEL NOVILLO',   'user_name' => 'JIMMY_VILLARROEL',        'email' => 'xdxdjimmy.v@fcyt.umss.edu'],                   /*ID 49*/            
            ['name' => 'NIBETH',         'last_name' => 'MENA MAMANI',          'user_name' => 'NIBETH_MENA',             'email' => 'xdxdnibeth.m@fcyt.umss.edu'],                  /*ID 50*/            
            ['name' => 'AMERICO',        'last_name' => 'FIORILO LOZADA',       'user_name' => 'AMERICO_FIORILO',         'email' => 'xdxdamerico.f@fcyt.umss.edu'],                 /*ID 51*/            
            ['name' => 'MARCELO',        'last_name' => 'ANTEZANA CAMACHO',     'user_name' => 'MARCELO_ANTEZANA',        'email' => 'xdxdmarcelo.a@fcyt.umss.edu'],                 /*ID 52*/            
            ['name' => 'VICTOR ADOLFO',  'last_name' => 'RODRIGUEZ ESTEVEZ',    'user_name' => 'VICTOR_ADOLFO_RODRIGUEZ', 'email' => 'xdxdvictor.r@fcyt.umss.edu'],                  /*ID 53*/            
            ['name' => 'DANIEL',         'last_name' => 'GARCIA CUCHALLO',      'user_name' => 'DANIEL_GARCIA',           'email' => 'qtimpo1@gmail.com'],                           /*ID 54*/
            ['name' => 'ALEXANDER JAMES','last_name' => 'ROJAS ALVAREZ',        'user_name' => 'ALEXANDER',               'email' => 'alvarez.rojas.alexander.james5@gmail.com'],    /*ID 55*/  
            ['name' => 'ENCARGADO3',     'last_name' => '',                     'user_name' => 'ENCARGADO3',              'email' => 'encargado3@gmail.com'],                        /*ID 56*/  
            ['name' => 'ENCARGADO4',     'last_name' => '',                     'user_name' => 'ENCARGADO4',              'email' => 'encargado4@gmail.com'],                        /*ID 57*/  
            ['name' => 'ENCARGADO5',     'last_name' => '',                     'user_name' => 'ENCARGADO5',              'email' => 'encargado5@gmail.com'],                        /*ID 58*/              
            ['name' => 'SISTEMA',        'last_name' => '',                     'user_name' => 'SISTEMA',                 'email' => '']                                             /*ID 59*/                                      
        ];                  

        $password = '12345678';

        foreach ($people as $person) {
            Person::create([
                'name' => $person['name'],
                'last_name' => $person['last_name'],
                'user_name' => $person['user_name'],
                'email' => $person['email'],
                'password' => bcrypt($password)
            ]);
        }
    }
}
