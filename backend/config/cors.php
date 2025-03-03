<?php

return [
    'paths' => ['api/*'], // Rutas protegidas por CORS
    'allowed_methods' => ['*'], // Métodos HTTP permitidos
    'allowed_origins' => ['*'], // Orígenes permitidos (puedes restringir esto)
    'allowed_headers' => ['*'], // Encabezados permitidos
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => false,
];
