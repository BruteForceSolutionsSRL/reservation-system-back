<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitud para Elementos de programación y estructura de datos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 20px;
        }

        .header img {
            width: 150px;
            height: auto;
        }

        .header h1 {
            font-size: 24px;
            margin: 0;
            color: #333;
        }

        .content {
            line-height: 1.5;
        }

        .content p {
            margin: 0;
            color: #555;
        }

        .content .status {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .content .status p {
            margin-right: 10px;
        }

        .content .status i {
            font-size: 20px;
            color: #dc3545; /* Color rojo para indicar rechazo */
        }

        .content table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }

        .content th,
        .content td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .content a {
            color: #007bff;
            text-decoration: none;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
        }

        .footer p {
            margin: 0;
            color: #999;
        }

        .footer a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>{{ $details['title'] }}</h1>
    </div>
    <div class="content">
        <p>{{$details['body']}}</p>
        <h3>Detalle de la solicitud</h3>
        <div class="status">
            <p><b>Estado:</b> Rechazado</p>
            <i class="fa-solid fa-circle-xmark"></i>
        </div>
        <p><b>Fecha:</b> {{ $details['date'] }}</p>
        <p><b>Hora de inicio:</b> {{ $details['time_slot'][0] }}</p>
        <p><b>Hora de fin:</b> {{ $details['time_slot'][1] }}</p>
        <p><b>Materia:</b> {{ $details['subject_name'] }} </p>
        <p><b>Profesores/Grupos:</b></p>
        <ul>
            @for ($i = 0; $i<count($details['groups']); $i++)
                <li>
                    <b>{{ $details['groups'][$i]['teacher_name'] }} :</b> {{ $details['groups'][$i]['group_number'] }}
                </li>
            @endfor
        </ul>
        <p><b>Bloque:</b> {{ $details['block_name'] }} </p>
        <p><b>Ambientes/capacidad:</b> </p>
        <ul>
            @for ($i = 0; $i<count($details['classrooms']); $i++)
                <li>
                    <b>{{ $details['classrooms'][$i]['classroom_name'] }}:</b> {{ $details['classrooms'][$i]['capacity'] }}
                </li>
            @endfor
        </ul>
        <p><b>Motivo:</b> {{ $details['reason_name'] }} </p>
        <p><b>Cantidad de estudiantes:</b> {{ $details['quantity'] }} </p>
    </div>
    <hr>
    <div class="footer">
        <p><b>Enviado por:</b> {{ $details['sendBy'] }}</p>
        <p>&copy; 2024 SURA. Todos los derechos reservados.</p>
        <p>**Redes sociales:**</h
        <a href="#">Facebook</a> |
        <a href="#">Twitter</a> |
        <a href="#">LinkedIn</a>
    </div>
</div>
</body>
</html>
