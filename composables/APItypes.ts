export type Space = {
    "@type": string;
    "@id": number;
    fetchOptions: FetchOptions;
    id: TechId;
    permId: PermId;
    code: string;
    description: string | null;
    frozen: boolean;
    frozenForProjects: boolean;
    frozenForSamples: boolean;
    registrationDate: number;
    modificationDate: number;
    registrator: null;
    samples: null;
    projects: null;
};

export type FetchOptions = {
    "@type": string;
    "@id": number;
    count: null;
    from: null;
    cacheMode: string;
    registrator: null;
    samples: null;
    projects: null;
    sort: null;
    sortBy: null;
};

export type TechId = {
    techId: number;
    "@type": string;
    "@id": number;
    id: string;
};

export type PermId = {
    permId: string;
    "@type": string;
    "@id": number;
};

export type SearchResult = {
    objects: Space[];
    totalCount: number;
    "@type": string;
    "@id": number;
};