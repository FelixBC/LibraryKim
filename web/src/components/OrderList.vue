<script lang="ts" setup>
import { onMounted, ref, computed } from "vue";
import { Order } from "./types.ts";

const trackingNumber = ref<string | null>(null);
const supplierID = ref<number | null>(null);
const userID = ref<number | null>(null);
const totalOrder = ref<number | null>(null);
const deliveryDate = ref<string | null>(null);
const realArrivalDate = ref<string | null>(null);
const paymentMethodID = ref<number | null>(null);
const status = ref<string | null>(null);

const API_URL = "http://localhost:3000/orders";
const orders = ref<Order[]>([]);

const filterValue = ref('');

const itemsPerPage = ref(10);
const perPageOptions = [
  { label: '5', value: 5 },
  { label: '10', value: 10 },
  { label: '20', value: 20 }
];

const handleItemsPerPageChange = (value: number) => {
  itemsPerPage.value = value;
};

const paginatedOrders = computed(() => {
  const filteredOrders = orders.value.filter(order =>
      order.trackingNumber.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredOrders.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  orders.value = data as Order[];
});

const deleteOrder = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  });
  orders.value = orders.value.filter(order => order.id !== id);
};

const editOrder = async (id) => {
  const order = orders.value.find(order => order.id === id);
  if (order) {
    orderID.value = order.id;
    trackingNumber.value = order.trackingNumber;
    supplierID.value = order.supplierID;
    userID.value = order.userID;
    totalOrder.value = order.totalOrder;
    deliveryDate.value = order.deliveryDate;
    realArrivalDate.value = order.realArrivalDate;
    paymentMethodID.value = order.paymentMethodID;
    status.value = order.status;

    window.scroll({
      top: 0,
      behavior: 'smooth'
    });
  }
};

</script>

<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width" style="max-width: 1100px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Lista de Ordenes</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar"
          >
            <template v-slot:prepend>
              <q-icon name="event"/>
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
                <th class="text-right">Número de Seguimiento</th>
                <th class="text-right">ID de Suplidor</th>
                <th class="text-right">ID de Usuario</th>
                <th class="text-right">Total de la Orden</th>
                <th class="text-right">Fecha de Entrega</th>
                <th class="text-right">Fecha Real de Llegada</th>
                <th class="text-right">ID de Método de Pago</th>
                <th class="text-right">Estado</th>
                <th></th>
                <th></th>
              </tr>
              </thead>
              <tbody v-for="order in paginatedOrders" :key="order.id">
              <tr>
                <td class="text-left">{{ order.trackingNumber }}</td>
                <td class="text-left">{{ order.supplierID }}</td>
                <td class="text-left">{{ order.userID }}</td>
                <td class="text-left">{{ order.totalOrder }}</td>
                <td class="text-left">{{ order.deliveryDate }}</td>
                <td class="text-left">{{ order.realArrivalDate }}</td>
                <td class="text-left">{{ order.paymentMethodID }}</td>
                <td class="text-left">{{ order.status }}</td>
                <td class="text-right">
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editOrder(order.id)" class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteOrder(order.id)" class="small-btn"></q-btn>
                  </div>
                </td>
                <td></td>
              </tr>
              </tbody>
            </q-markup-table>
          </q-card>
        </q-card-section>
      </q-card>
    </q-page>
  </q-layout>
</template>

<style scoped>

</style>

