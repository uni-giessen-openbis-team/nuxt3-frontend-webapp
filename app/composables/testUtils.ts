import type { Sample } from "../types/wizard.js"

export function createSample(data: Partial<Sample>) {
    return { 
        id:  "1",
        name:  "Sample 1",
        conditions:  [],
        externalDBID:  "",
        count:  1,
        parents: [],
        pools:  [],
        ...data
    }
}

