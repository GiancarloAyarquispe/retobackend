function fn() {
  var config = {};
  config.baseUrl = karate.properties['serverest.url'] || 'https://serverest.dev';
  config.baseUrl = config.baseUrl.replace(/\/$/, '');
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 20000);
  return config;
}
