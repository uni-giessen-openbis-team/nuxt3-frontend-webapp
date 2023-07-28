import Cards from './Cards.vue'

describe('<Cards />', () => {
  it('renders', () => {
    // see: https://on.cypress.io/mounting-vue
    cy.mount(Cards)
  })
})