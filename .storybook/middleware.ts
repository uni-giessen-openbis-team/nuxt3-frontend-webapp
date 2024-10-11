const express = require('express');
const bodyParser = require('body-parser');


const expressMiddleWare = router => {
    router.use(bodyParser.urlencoded({ extended: false }));
    router.use(bodyParser.json());
    router.get(/api/get-orders/:orderId, (request, response) => {
      if (request.params.orderId === 'error') {
        response.status(500).send('Something broke!')
      }
  
      res.send({ data: { text: 'hello world' } })
    })
};

module.exports = expressMiddleWare; 