<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {User} from "./types.ts";
import EditNameModal from "./EditNameModal.vue";

const name = ref<string | null>(null)
const API_URL = "http://localhost:3000/users";
const users = ref<User[]>([]);
const editingUser = ref<User | null>(null);
const showModal = ref(false);
const filterValue = ref('')
const itemsPerPage = ref(10);
// not needed could implement later
// const perPageOptions = [
//   {label: '5', value: 5},
//   {label: '10', value: 10},
//   {label: '20', value: 20}
// ];
//
// const handleItemsPerPageChange = (value: number) => {
//   itemsPerPage.value = value;
// };

const paginatedUsers = computed(() => {
  const filteredUsers = users.value.filter(user =>
      user.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredUsers.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  users.value = data as User[];
});
const editUser = async (id) => {
  showModal.value = true;
  const user = users.value.find(user => user.id === id)
  if (user) {
    editingUser.value = user;

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}
const onModalClose = () => {
  showModal.value = false;
};


const deleteUser = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  users.value = users.value.filter(person => person.id !== id)
}
const onUpdateUser = async ({id, name}) => {
  const res = await fetch(`${API_URL}/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: name,
    })
  });

  const data = await res.json();

  const index = users.value.findIndex(user => user.id === id);
  if (index !== -1) {
    users.value[index].name = data.name;
  }

  showModal.value = false;
};

</script>
<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Lista de Usuarios</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar"
          >
            <template v-slot:before>
              <q-icon name="person"/>
            </template>

            <template v-slot:append>
              <q-icon name="search"/>
            </template>
          </q-input>
        </q-card-section>
        <q-card-section>
          <q-card>
            <q-markup-table>
              <thead>
              <tr>
                <th class="text-right">Nombre</th>
                <th></th>
                <th></th>
              </tr>
              </thead>
              <tbody v-for="user in paginatedUsers" :key="user.id">
              <tr>
                <td class="text-left">{{ user.name }}</td>
                <td class="text-right">
                  <div>

                    <q-btn v-if="!showModal" round color="secondary" icon="edit" @click="editUser(user.id)"
                           class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteUser(user.id)"
                           class="small-btn"></q-btn>
                  </div>
                </td>
                <th></th>
              </tr>
              </tbody>
              <div>
              </div>
            </q-markup-table>
          </q-card>
        </q-card-section>
      </q-card>
    </q-page>
    <EditNameModal v-model:show="showModal" v-bind="editingUser" @close="onModalClose"
                   @save="onUpdateUser"></EditNameModal>
  </q-layout>
</template>
<style scoped>

</style>
/style>