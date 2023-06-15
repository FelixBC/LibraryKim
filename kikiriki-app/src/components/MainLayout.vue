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
        <header class="header">
          <div class="header__container">

            <a href="#" class="header__logo">Bedimcode</a>

            <div class="header__search">
              <input type="search" placeholder="Search" class="header__input">
              <i class='bx bx-search header__icon'></i>
            </div>

            <div class="header__toggle">
              <i class='bx bx-menu' id="header-toggle"></i>
            </div>
          </div>
        </header>

        <!--========== NAV ==========-->
        <div class="nav" id="navbar">
          <nav class="nav__container">
            <div>
              <a href="#" class="nav__link nav__logo">
                <i class='bx bxs-disc nav__icon'></i>
                <span class="nav__logo-name">Bedimcode</span>
              </a>

              <div class="nav__list">
                <div class="nav__items">
                  <h3 class="nav__subtitle">Profile</h3>

                  <a href="#" class="nav__link active">
                    <i class='bx bx-home nav__icon'></i>
                    <span class="nav__name">Home</span>
                  </a>

                  <div class="nav__dropdown">
                    <a href="#" class="nav__link">
                      <i class='bx bx-user nav__icon'></i>
                      <span class="nav__name">Profile</span>
                      <i class='bx bx-chevron-down nav__icon nav__dropdown-icon'></i>
                    </a>

                    <div class="nav__dropdown-collapse">
                      <div class="nav__dropdown-content">
                        <a href="#" class="nav__dropdown-item">Passwords</a>
                        <a href="#" class="nav__dropdown-item">Mail</a>
                        <a href="#" class="nav__dropdown-item">Accounts</a>
                      </div>
                    </div>
                  </div>

                  <a href="#" class="nav__link">
                    <i class='bx bx-message-rounded nav__icon'></i>
                    <span class="nav__name">Messages</span>
                  </a>
                </div>

                <div class="nav__items">
                  <h3 class="nav__subtitle">Menu</h3>

                  <div class="nav__dropdown">
                    <a href="#" class="nav__link">
                      <i class='bx bx-bell nav__icon'></i>
                      <span class="nav__name">Notifications</span>
                      <i class='bx bx-chevron-down nav__icon nav__dropdown-icon'></i>
                    </a>

                    <div class="nav__dropdown-collapse">
                      <div class="nav__dropdown-content">
                        <a href="#" class="nav__dropdown-item">Blocked</a>
                        <a href="#" class="nav__dropdown-item">Silenced</a>
                        <a href="#" class="nav__dropdown-item">Publish</a>
                        <a href="#" class="nav__dropdown-item">Program</a>
                      </div>
                    </div>

                  </div>

                  <a href="#" class="nav__link">
                    <i class='bx bx-compass nav__icon'></i>
                    <span class="nav__name">Explore</span>
                  </a>
                  <a href="#" class="nav__link">
                    <i class='bx bx-bookmark nav__icon'></i>
                    <span class="nav__name">Saved</span>
                  </a>
                </div>
              </div>
            </div>

            <a href="#" class="nav__link nav__logout">
              <i class='bx bx-log-out nav__icon'></i>
              <span class="nav__name">Log Out</span>
            </a>
          </nav>
        </div>

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

<script lang="ts" setup>
import {ref, Ref} from 'vue';
import {Router, useRoute, useRouter} from 'vue-router';

const drawer: Ref<boolean> = ref(false);
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