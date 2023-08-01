const require = (function () {
  // Replace this with the actual base URL of your openBIS API
  const baseUrl = 'http://localhost:8080/openbis/resources/api/v3'

  return {
    baseUrl,
    paths: {
      'jquery': 'lib/jquery/js/jquery',
      'stjs': 'lib/stjs/js/stjs',
      'underscore': 'lib/underscore/js/underscore',
      'moment': 'lib/moment/js/moment',
      'components': '../../components',
      'openbis-screening': '../../js/openbis-screening',
      'bootstrap': '../../lib/bootstrap/js/bootstrap.min',
      'bootstrap-slider': '../../lib/bootstrap-slider/js/bootstrap-slider.min',
    },
    shim: {
      'stjs': {
        exports: 'stjs',
        deps: ['underscore'],
      },
      'underscore': {
        exports: '_',
      },
      'openbis-screening': {
        deps: ['openbis'],
        exports: 'openbis',
      },
    },
  }
})()
