function(label) {
  var suffix = Date.now().toString(36) + Math.random().toString(36).substring(2, 10);
  return {
    nome: 'QA ' + label + ' ' + suffix,
    email: 'qa.' + suffix + '@example.com',
    password: 'Qa!' + suffix,
    administrador: 'false'
  };
}
