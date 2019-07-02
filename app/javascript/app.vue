<template>
<<<<<<< HEAD
    <div>
    <li v-for="(item, index) in items" :key="index">
      {{ parentMessage }} - {{ index }} - {{ item.message }}
    </li>
    </div>
</template>

<script>
  export default {
    data () {
      return {
        parentMessage: 'Parent',
        items: [
          { message: 'Foo' },
          { message: 'Bar' }
        ]
      }
    }
  }
</script>
=======
  <div id="app">
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
>>>>>>> 1902a55cba3c2a93969e9d4e30e558b581e792f6
