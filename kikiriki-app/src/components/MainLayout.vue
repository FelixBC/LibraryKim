<template>

  <q-layout view="hHh lpR fFf">
    <q-page-container>
      <q-header elevated class="bg-primary text-white" height-hint="98">
        <q-toolbar>

          <q-toolbar-title class="header__logo">
           <q-item clickable v-ripple @click="gotoDashboard">
            <q-avatar>
              <img src="https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg">
            </q-avatar>
            Kikiriki
           </q-item>
          </q-toolbar-title>
        </q-toolbar>
      </q-header>

      <!--========== DRAWER ==========-->

      <q-drawer
          class="extraSpaceSideBarHeading sidebar-content"
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

        <q-list padding>

          <q-expansion-item
              expand-separator
              icon="perm_identity"
              label="Usuarios"
          >
            <q-list padding>
              <q-item clickable v-ripple>
                <q-item-section @click="gotoUserList">
                  Lista
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section @click="gotoUserCreate">
                  Create
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section>
                  Restrinctions
                </q-item-section>
              </q-item>
            </q-list>

          </q-expansion-item>
        </q-list>
        <q-list padding>

          <q-expansion-item
              expand-separator
              icon="person"
              label="Dueño"
          >
            <q-list padding>
              <q-item clickable v-ripple>
                <q-item-section @click="gotoOwnerList">
                  Lista
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section @click="gotoOwnerCreate">
                  Crear
                </q-item-section>
              </q-item>

            </q-list>

          </q-expansion-item>
        </q-list>
        <q-list padding>

          <q-expansion-item
              expand-separator
              icon="egg"
              label="Gallos"
          >
            <q-list padding>
              <q-item clickable v-ripple>
                <q-item-section @click="gotoRoosterList">
                  Lista
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section @click="gotoRoosterCreate">
                  Crear
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section>
                  Restrinctions
                </q-item-section>
              </q-item>
            </q-list>

          </q-expansion-item>
        </q-list>
        <q-list padding>
          <q-expansion-item
              expand-separator
              icon="calendar_today"
              label="Encuentros"
          >
            <q-list padding>
              <q-item clickable v-ripple>
                <q-item-section @click="gotoFightList">
                  Lista
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section @click="gotoFightCreate">
                  Crear
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section>
                  Restrinctions
                </q-item-section>
              </q-item>
            </q-list>

          </q-expansion-item>
        </q-list>
        <q-list padding>

          <q-expansion-item
              expand-separator
              icon="paid"
              label="Jugadas"
          >
            <q-list padding>
              <q-item clickable v-ripple>
                <q-item-section @click="gotoTicketList">
                  Lista
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section @click="gotoTicketCreate">
                  Crear
                </q-item-section>
              </q-item>

              <q-item clickable v-ripple>
                <q-item-section @click="gotoFightList">
                  Proximos eventos
                </q-item-section>
              </q-item>
            </q-list>

          </q-expansion-item>

        </q-list>

        <q-item class="extraSpaceOntop">
          <q-item-section>
          </q-item-section>
        </q-item>
        <q-item

            clickable
            v-ripple
            active-class="my-menu-link"
        >
          <q-item-section avatar>
            <q-icon name="settings_power"/>
          </q-item-section>

          <q-item-section>Logout</q-item-section>
        </q-item>
      </q-drawer>
      <q-page-container>
        <router-view/>
      </q-page-container>
    </q-page-container>
  </q-layout>

</template>
<style>

@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap");
.extraSpaceOntop {
  padding-top: 100%;
}

.extraSpaceSideBarHeading {
  padding-top: 30%;
}

</style>
<script lang="ts" setup>
import {ref, Ref} from 'vue';
import {Router, useRoute, useRouter} from 'vue-router';

const drawer: Ref<boolean> = ref(true);
const miniState: Ref<boolean> = ref(true);
const route = useRoute();
const router: Router = useRouter();

const gotoOwnerCreate = (): void => {
  router.push('/OwnerCreate');
};
const gotoOwnerList = (): void => {
  router.push('/OwnerList');
};
const gotoRoosterCreate = (): void => {
  router.push('/RoosterCreate');
};
const gotoRoosterList = (): void => {
  router.push('/RoosterList');
};
const gotoTicketCreate = (): void => {
  router.push('/TicketCreate');
};
const gotoTicketList = (): void => {
  router.push('/TicketList');
};
const gotoUserCreate = (): void => {
  router.push('/UserCreate');
};
const gotoUserList = (): void => {
  router.push('/UserList');
};
const gotoDashboard = (): void => {
  router.push('/');
};
const gotoFightCreate = (): void => {
  router.push('/FightCreate');
};
const gotoFightList = (): void => {
  router.push('/FightList');
};


const toggleLeftDrawer = (): void => {
  drawer.value = !drawer.value;
};

</script>