<template>
  <div>
    <maincontents></maincontents>    
  </div>
</template>

<script>
import MainContents from './components/MainContents';

export default {
    name: "top",
    components : {
        'maincontents': MainContents,
    }
}
</script>