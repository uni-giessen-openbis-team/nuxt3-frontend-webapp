import { defineStore } from 'pinia'
import openbis from './openbis.esm'

/*
The openbisStore is used to interact with the openBIS API.
It is used to login, logout, and fetch data from openBIS.
V3 instance created here, is used in all the other stores.
This ensures that only one instance of the v3 object is
created and used throughout the application.
*/

// TODO: Perist the V3 Object. https://prazdevs.github.io/pinia-plugin-persistedstate/guide/limitations.html
 
export const useOpenBisStore = defineStore('openBis', {
  state: () => ({
    v3: null as openbis.openbis | null,
    sessionToken: null as string | null,
    personalAccessToken: null as  openbis.PersonalAccessTokenPermId | null,
    applicationName: 'applicationName',
  }),

  actions: {
    // TODO: Use the PAT to login. No TS support for PAT yet. 
    async getPersonalAccessTokenOnLogin() {
      try {
        if (!this.v3 || !this.sessionToken) throw new Error('v3 object or session token not initialized');
        // Obtain servers renewal information
        const information = await this.v3.getServerInformation();
        const personalAccessTokensRenewalPeriodInSeconds = parseInt(information['personal-access-tokens-validity-warning-period']);
        const personalAccessTokensRenewalPeriodInDays = personalAccessTokensRenewalPeriodInSeconds / (24 * 60 * 60);
        const personalAccessTokensMaxValidityPeriodInSeconds = parseInt(information['personal-access-tokens-max-validity-period']);
        const personalAccessTokensMaxValidityPeriodInDays = personalAccessTokensMaxValidityPeriodInSeconds / (24 * 60 * 60);
        // Obtain user id
        const sessionInformation = await this.v3.getSessionInformation();
        const userId = sessionInformation.getPerson().getUserId();
        
        // Search for PAT for this user and application
        // NOTE: Standard users only get their PAT but admins get all, filtering with the user solves this corner case
        const criteria = new openbis.PersonalAccessTokenSearchCriteria();
        criteria.withSessionName().thatEquals(this.applicationName);
        criteria.withOwner().withUserId().thatEquals(userId); // needed for admin
        const fo = new openbis.PersonalAccessTokenFetchOptions()
        const personalAccessTokenSearchResult = await this.v3.searchPersonalAccessTokens(
          criteria,
          fo
        );

        let bestTokenFound = null as openbis.PersonalAccessToken | null;
        let bestTokenFoundPermId = null as  openbis.PersonalAccessTokenPermId | null;

         // Obtain longer lasting application token
        for (const personalAccessToken of personalAccessTokenSearchResult.getObjects()) {
          if (new Date(personalAccessToken.getValidToDate()) > new Date()) {
            if (!bestTokenFound) {
              bestTokenFound = personalAccessToken;
            } else if (new Date(personalAccessToken.getValidToDate()) > new Date(bestTokenFound.getValidToDate())) {
              bestTokenFound = personalAccessToken;
            }
          }
        }
        
        // If best token doesn't exist, create
        if (!bestTokenFound) {
          bestTokenFoundPermId = await this.createApplicationPersonalAccessToken(
            personalAccessTokensMaxValidityPeriodInDays
          );
        }

        // If best token is going to expire in less than the warning period, renew
        const renewalDate = new Date();
        renewalDate.setDate(renewalDate.getDate() + personalAccessTokensRenewalPeriodInDays);
        if (bestTokenFound && new Date(bestTokenFound.getValidToDate()) < renewalDate) {
          bestTokenFoundPermId = await this.createApplicationPersonalAccessToken(
            personalAccessTokensMaxValidityPeriodInDays
          );
        }
        
        // If we have not created or renewed, return current
        if (!bestTokenFoundPermId) {
          bestTokenFoundPermId = bestTokenFound?.getPermId();
        }

        this.personalAccessToken = bestTokenFoundPermId;
      } catch (error) {
        console.error('Error getting personal access token:', error);
      }
    },

    async createApplicationPersonalAccessToken(validityPeriodInDays: number) {
      try {
        if (!this.v3 || !this.sessionToken) throw new Error('v3 object or session token not initialized');

        const creation = new openbis.PersonalAccessTokenCreation();
        creation.setSessionName(this.applicationName);
        creation.setValidFromDate(new Date().getDate());
        creation.setValidToDate(new Date(Date.now() + validityPeriodInDays * 24 * 60 * 60 * 1000).getDate());

        const creationResult = await this.v3.createPersonalAccessTokens([creation]);
        return creationResult[0].getPermId();
      } catch (error) {
        console.error('Error creating personal access token:', error);
        throw error;
      }
    },


    async initialize() {
      try {
        this.v3 = await new openbis.openbis()
        console.log('🚀 ~ initialize ~ this.v3:', this.v3)
        // after initialization, look if PAT is available and use it
      } catch (error) {
        console.error('Error initializing v3 object:', error)
      }
    },

    async autoLogin() {
      try {
        await this.login('admin', 'mysecretpassword')
      } catch (error) {
        console.error('Error auto logging in:', error)
      }
    },

    async login(username: string, password: string) {
      try {
        if (!this.v3)
          throw new Error('v3 object not initialized')

        
        this.sessionToken = await this.v3.login(username, password)
        console.log('🚀 ~ login ~ sessionToken:', this.sessionToken)
        // after login create a PAT

      } catch (error) {
        console.error('Error logging in:', error)
      }
    },
    
    async logout() {
      try {
        if (!this.v3)
          throw new Error('v3 object not initialized')

        await this.v3.logout()
        console.log('Logged out successfully')
      } catch (error) {
        console.error('Error logging out:', error)
      }
    },
  },

  getters: {
    async getSessionInformation(state): Promise<string | null> {
      try {
        return await state.v3?.getSessionInformation()
      } catch (error) {
        console.error('Error getting session information:', error)
        return null
      }
    },
    async isLoggedIn(state): Promise<boolean> {
      try {
        if (await this.getSessionInformation)
          return true
        return false
      } catch (error) {
        console.error('Error checking if logged in:', error)
        return false
      }
    },
    
  },
  persist: true
})
