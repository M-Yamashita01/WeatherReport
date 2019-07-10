<template>
    <div id="top">
        <navbar></navbar>
        <sidebar></sidebar>
    </div>
</template>

<script>
import Header from './components/header.vue';
import SideBar from './components/sidebar.vue';

export default {
    name: "top",
    components : {
        //'navbar': Header,
        'sidebar': SideBar,
    }
}
</script>