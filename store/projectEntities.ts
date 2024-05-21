import { defineStore } from 'pinia';
import { ref } from 'vue';

type ProjectEntity = {
  title: string;
  conditions: Array<any>;
  continous: boolean;
  unit: string | null;
}

export const useProjectEntitiesStore = defineStore('projectEntities', () => {
  const variables = ref<ProjectEntity[]>([
    {
      title: 'genotype',
      conditions: ref([]),
      continous: false,
      unit: null,
    }, 
    {
      title: 'color',
      conditions: ref([]),
      continous: false,
      unit: null,
    },
  ]);

  return { variables };
});
