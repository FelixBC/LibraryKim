<template>

  <q-layout view="hHh lpR fFf">
    <q-page-container>
      <q-header elevated class="bg-primary text-white" height-hint="98">
        <q-toolbar>

          <q-toolbar-title class="header__logo">
            <q-avatar>
              <img src="https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg">
            </q-avatar>
            Kikiriki
          </q-toolbar-title>
        </q-toolbar>
        <q-btn-dropdown color="primary" label="Dueños">
          <q-tabs align="left">
            <q-route-tab to="/page1" label="Lista"/>
            <q-route-tab to="/page2" label="Crear"/>
          </q-tabs>
        </q-btn-dropdown>
        <q-btn-dropdown color="primary" label="Gallos">
          <q-tabs align="left">
            <q-route-tab to="/page1" label="Lista"/>
            <q-route-tab to="/page2" label="Crear"/>
          </q-tabs>
        </q-btn-dropdown>
        <q-btn-dropdown color="primary" label="Encuentros">
          <q-tabs align="left">
            <q-route-tab to="/page1" label="Lista"/>
            <q-route-tab to="/page2" label="Crear"/>
          </q-tabs>
        </q-btn-dropdown>

      </q-header>


      <!--========== DRAWER ==========-->
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
                <q-icon name="inbox" />
              </q-item-section>

              <q-item-section>
                Inbox
              </q-item-section>
            </q-item>

            <q-item active clickable v-ripple>
              <q-item-section avatar>
                <q-icon name="star" />
              </q-item-section>

              <q-item-section>
                Star
              </q-item-section>
            </q-item>

            <q-item clickable v-ripple>
              <q-item-section avatar>
                <q-icon name="send" />
              </q-item-section>

              <q-item-section>
                Send
              </q-item-section>
            </q-item>

            <q-separator />

            <q-item clickable v-ripple>
              <q-item-section avatar>
                <q-icon name="drafts" />
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
    </q-page-container>
  </q-layout>

</template>
<style>
@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap");

</style>
<script lang="ts" setup>
import {ref, Ref} from 'vue';
import {Router, useRoute, useRouter} from 'vue-router';

const drawer: Ref<boolean> = ref(true);
const miniState: Ref<boolean> = ref(true);
const route = useRoute();
const router: Router = useRouter();

const gotoPeople = (): void => {
  router.push('/People');
};

const gotoHome = (): void => {
  router.push('/');
};

const gotoRegistration = (): void => {
  router.push('/Registration');
};

const toggleLeftDrawer = (): void => {
  drawer.value = !drawer.value;
};

</script>