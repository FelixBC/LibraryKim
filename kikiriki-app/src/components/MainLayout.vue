<template>
  <q-layout view="hHh lpR fFf">

    <q-header elevated class="bg-primary text-white" height-hint="98">
      <q-toolbar>
        <q-btn dense flat round icon="menu" @click="toggleLeftDrawer"/>

        <q-toolbar-title>
          <q-avatar>
            <img src="https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg">
          </q-avatar>
          Kikiriki
        </q-toolbar-title>
      </q-toolbar>

      <q-tabs align="left">
        <q-route-tab to="/page1" label="Registro"/>
        <q-route-tab to="/page2" label="Informe"/>
        <q-route-tab to="/page3" label="Preferidos"/>
      </q-tabs>
    </q-header>

    <q-drawer
        v-model="drawer"
        show-if-above

        :mini="miniState"
        @mouseover="miniState = false"
        @mouseout="miniState = true"

        :width="200"
        :breakpoint="500"
        bordered
        :class="$q.dark.isActive ? 'bg-grey-9' : 'bg-grey-3'"
    >
      <q-scroll-area class="fit">
        <q-list padding>
          <q-item clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="inbox" class="custom-icon-color" />
            </q-item-section>

            <q-item-section @click="gotoHome">
              Inbox
            </q-item-section>
          </q-item>

          <q-item active clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="star" color="blue"/>
            </q-item-section>

            <q-item-section @click="gotoAbout">
                Star


            </q-item-section>
          </q-item>

          <q-item clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="send" color="orange" />
            </q-item-section>

            <q-item-section @click="gotoRegistration">
              Send
            </q-item-section>
          </q-item>

          <q-separator />

          <q-item clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="drafts" color="teal"/>
            </q-item-section>

            <q-item-section>
              Drafts
            </q-item-section>
          </q-item>
        </q-list>
      </q-scroll-area>
    </q-drawer>


    <q-page-container>
      <router-view/>
    </q-page-container>

  </q-layout>
</template>
<style>
.custom-icon-color {
  color: rgb(120, 20, 66);
}
</style>

<script lang="ts">
import { ref, Ref } from 'vue';
import { Router, useRoute, useRouter } from 'vue-router';
import routes from "../router/router.ts";


const drawer: Ref<boolean> = ref(false);
const miniState: Ref<boolean> = ref(true);
const route = useRoute();
const router: Router = useRouter();

const gotoAbout = (): void => {
  routes.push('/About');
};
const gotoHome = (): void => {
  routes.push('/');
};

const gotoRegistration = (): void => {
  routes.push('/Registration');
}

const toggleLeftDrawer = (): void => {
  drawer.value = !drawer.value;
};

export default {
  setup() {
    return {
      drawer,
      miniState,
      gotoAbout,
      gotoHome,
      gotoRegistration,
      toggleLeftDrawer,
    };
  },
};
</script>