const { createProxyMiddleware } = require('http-proxy-middleware'); 
module.exports = function(app) 
  { app.use( '/openbis', createProxyMiddleware(
    { target: 'http://localhost:8080/openbis', changeOrigin: true, }
  ) 
); 
};
