# APIS DEL PROYECTO

* Registro

URI: /api/v1/signup
Método: POST
Header requerido: ninguno
Entradas: name:string, last_name:string, username:string, email:string, password:string, password_confirmation:string, city:string, country:string, phone:string, document:string. Se requieren username, email, password, password_confirmation
Salidas: JSON con los datos del usuario creado

* Login

URI: /api/v1/login
Método: POST
Header requerido: ninguno
Entradas: username:string, password:string. Ambos requeridos
Salidas: JSON con los datos del usuario logueado y auth token para consultar las otras rutas

* Mostrar usuario

URI: /api/v1/users/show
Método: GET
Header requerido: auth_token
Entradas: ninguna
Salidas: JSON con los datos del usuario

* Actualizar usuario

URI: /api/v1/users/update
Método: PATCH
Header requerido: auth_token
Entradas: ninguna
Salidas: JSON con los datos actualizados del usuario

* Mostrar boveda de usuario

URI: /api/v1/vaults/show
Método: GET
Header requerido: auth_token
Entradas: ninguna
Salidas: JSON con los datos de la bóveda del usuario

* Mostrar codigos de usuario

URI: /api/v1/codes/user
Método: GET
Header requerido: auth_token
Entradas: ninguna
Salidas: JSON con los datos de los codigos promocionales del usuario

* Comprar codigos de usuario

URI: /api/v1/codes/buy
Método: POST
Header requerido: auth_token
Entradas: value:float. El valor enviado debe ser menor o igual al valor que el usuario tiene en su bóveda
Salidas: JSON con los datos del codigo promocional comprado

* Redimir codigos de usuario

URI: /api/v1/transactions/save
Método: PATCH
Header requerido: auth_token
Entradas: code:string. El código ingresado debe corresponder a uno de los códigos que posee y el usuario y que tienen un estado Activo
Salidas: JSON con los datos de la bóveda del usuario actualizada

* Transferir valor a otro usuario

URI: /api/v1/transactions/transfer
Método: PATCH
Header requerido: auth_token
Entradas: other_uuid:string, value:float. Se debe ingresar el uuid de la bóveda del otro usuario al cual le queremos transferir. Así mismo, el valor a transferir debe ser menor o igual al valor que el usuario tiene en su bóveda
Salidas: JSON con los datos de la bóveda del usuario actualizada
