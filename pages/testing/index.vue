<script>
import draggable from 'vuedraggable'
export default {
  name: 'App',
  components: { Draggable: draggable },
  data() {
    return {
      people: [
        { name: 'Abby' },
        { name: 'Brooke' },
        { name: 'Courtenay' },
        { name: 'David' },
      ],
      places: [
        { name: 'Austria' },
        { name: 'Bahamas' },
        { name: 'Canada' },
        { name: 'Djibouti' },
      ],
    }
  },
}
</script>

<template>
  <div id="app">
    <table>
      <thead>
        <tr>
          <th>Table where sorting works.  No transition group</th>
        </tr>
      </thead>
      <Draggable :list="people" element="tbody">
        <tr v-for="person in people">
          <td>{{ person.name }}</td>
        </tr>
      </Draggable>
      <tbody>
        <tr><td>Non-moving tbody goes here</td></tr>
      </tbody>
    </table>
    <table>
      <thead>
        <tr>
          <th>Table with sorting and transition group</th>
        </tr>
      </thead>
      <Draggable :list="places" element="tbody">
        <transition-group tag="div" name="list-complete">
          <tr v-for="country in places" :key="country.name" class="list-complete-item">
            <td>{{ country.name }}</td>
          </tr>
        </transition-group>
      </Draggable>
      <tbody>
        <tr><td>Non-moving tbody goes here</td></tr>
      </tbody>
    </table>
  </div>
</template>

<style>
table{ border: 1px solid black; margin: 2em; }

.list-complete-item {
  transition: all 1s;
}

.list-complete-enter, .list-complete-leave-active {
  opacity: 0;
  height: 0px;
  margin-top: 0px;
  padding: 0px;
  border: solid 0px;
}
</style>
