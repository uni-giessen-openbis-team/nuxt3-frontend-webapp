import { generateClasses } from '@formkit/themes'

const config = {
  config: {
    classes: generateClasses({
      global: {
        // classes
        outer: '$reset mb-3',
        input: 'form-control',
        label: 'form-label',
        help: 'form-text',
      },
      form: {
        form: 'col-md-8 col-lg-6 mt-5 mx-auto p-5 border rounded',
      },
      range: {
        input: '$reset form-range',
      },
      submit: {
        outer: '$reset mt-3',
        input: '$reset btn btn-primary',
      },
      checkbox: {
        outer: '$reset form-check mt-3 ',
        input: '$reset form-check-input',
        label: '$reset form-check-label',
        help: 'form-text',
      },
    }),
  },
}

export default config
