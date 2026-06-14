function fn() {
  // 1. Obtener el ambiente (default 'dev')
  var env = karate.env;
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  // 2. Definir los valores base según el ambiente
  var config = {
    env: env,
    myVarName: 'someValue'
  };

  // 3. Asignar la URL base dinámica
  if (env == 'dev') {
    config.baseUrl = 'http://216.10.245.166/dev';
  } else if (env == 'e2e') {
    config.baseUrl = 'http://216.10.245.166/';
  }

//  // 4. (Opcional) Configurar tiempos de espera o timeouts
//  karate.configure('connectTimeout', 5000);
//  karate.configure('readTimeout', 5000);

  return config;
}