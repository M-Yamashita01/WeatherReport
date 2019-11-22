<script>
import store from "./store/index";

export default {
  created: function() {
    store.dispatch("destroy");
    document.location = "/";
  }
};
</script>
