<script setup lang="ts">
import {ref} from "vue";

const email = ref<string | null>(null)
const password = ref<string | null>(null)

</script>

<template>
  <q-layout view="hHh lpR fFf">
    <q-page-container>
      <div class="div_background">
        <q-page class="bg-light-grey window-height window-width row justify-center items-center">

          <div class="column">
            <div class="div_h5">
              <h5 class="text-h5 q-my-md">Sign In</h5>
            </div>
            <div class="row">
              <q-card square bordered class="q-pa-lg shadow-1">
                <q-card-section>
                  <q-form class="q-gutter-md">
                    <q-input filled v-model="email" label="Email" lazy-rules
                             :rules="[ val => val && val.isEmpty || 'Please enter your email']"/>
                    <q-input filled v-model="password" label="Password" lazy-rules
                             :rules="[ val => val && val.isEmpty || 'Please enter your password']"/>
                  </q-form>
                </q-card-section>
                <q-card-actions class="q-px-md">
                  <q-btn unelevated color="grey" size="lg" class="full-width" label="Login"/>
                </q-card-actions>
                <q-card-section class="text-center q-pa-none">
                  <p class="text-blue-grey-14">Not registered?<br><router-link to="/UserCreate">Create an Account! </router-link>
                    <br> <router-link to=""> Can't Login? </router-link>
                  </p>

                </q-card-section>
              </q-card>
            </div>
          </div>
        </q-page>
      </div>
    </q-page-container>
  </q-layout>
</template>

<style scoped>
.div_background {
  background-image: url('public/LibraryHD.jpg');
  background-size: cover;
}
.div_h5{
  text-align: center;
  font-size: 2rem;
  font-weight: 600;
  color: rgb(0, 0, 0);
  margin-left: 10px;
}
.q-card {
  width: 360px;
}
</style>