declare module 'openbis' {
    export default class Openbis {
      constructor();
      login(username: string, password: string): Promise<void>;
      searchSpaces(criteria: SpaceSearchCriteria, options: SpaceFetchOptions): Promise<SpaceSearchResult>;
      logout(): Promise<void>;
    }
  }
  
  declare module 'as/dto/space/search/SpaceSearchCriteria' {
    export default class SpaceSearchCriteria {
      constructor();
    }
  }
  
  declare module 'as/dto/space/fetchoptions/SpaceFetchOptions' {
    export default class SpaceFetchOptions {
      constructor();
    }
  }
  
  declare class SpaceSearchResult {
    constructor();
    getObjects(): Space[];
  }
  
  declare class Space {
    constructor();
  }

