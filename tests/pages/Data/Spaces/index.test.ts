
import Spaces from '@/pages/Data/Spaces/index.vue'
import { it, expect, describe, test } from 'vitest'
import  mountSuspended  from '@nuxt/test-utils/runtime'

describe('Create Space'), () => {
  it('can mount page'), async () => {
    const page = mountSuspended(Spaces)
    expect((await page).text()).toContain('Create New Space')
  }
}