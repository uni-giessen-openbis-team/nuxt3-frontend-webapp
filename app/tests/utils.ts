import type { Sample } from "../types/wizard.js"

// This file contains functions for creating objects for testing.

/**
 * Create a sample object
 * @param data - Partial<Sample>
 * @returns Sample
 */
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

