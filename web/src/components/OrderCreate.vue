<script lang="ts" setup>
import { ref } from 'vue';
import { Order, OrderDetail } from "./types.ts";

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
const ordersDetails = ref<OrderDetail[]>([]);

const create = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      trackingNumber: trackingNumber.value,
      supplierID: supplierID.value,
      userID: userID.value,
      totalOrder: totalOrder.value,
      deliveryDate: deliveryDate.value,
      realArrivalDate: realArrivalDate.value,
      paymentMethodID: paymentMethodID.value,
      status: status.value,
    })
  });

  const data = await res.json();
  orders.value.push(data);
  onReset();
};

const onReset = () => {
  trackingNumber.value = null;
  supplierID.value = null;
  userID.value = null;
  totalOrder.value = null;
  deliveryDate.value = null;
  realArrivalDate.value = null;
  paymentMethodID.value = null;
  status.value = null;
};
</script>

<template>
  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Crear Orden</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="trackingNumber"
                    label="Número de Seguimiento"
                    hint="Número de Seguimiento de la Orden"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe escribir un número de seguimiento']"
                />
                <q-input
                    filled
                    v-model="supplierID"
                    label="ID de Suplidor"
                    hint=" "
                    lazy-rules
                    :rules="[val => !isNaN(val) || 'Debe ser un número']"
                />
                <q-input
                    filled
                    v-model="userID"
                    label="ID de Usuario"
                    hint=" "
                    lazy-rules
                    :rules="[val => !isNaN(val) || 'Debe ser un número']"
                />
                <q-input
                    filled
                    v-model="totalOrder"
                    label="Total de la Orden"
                    hint=" "
                    lazy-rules
                    :rules="[val => !isNaN(val) || 'Debe ser un número']"
                />
                <q-input
                    filled
                    v-model="deliveryDate"
                    label="Fecha de Entrega"
                    type="date"
                    lazy-rules
                    :rules="[val => val || 'Debe seleccionar una fecha y hora']"
                />
                <q-input
                    filled
                    v-model="realArrivalDate"
                    label="Fecha Real de Llegada"
                    type="date"
                    lazy-rules
                    :rules="[val => val || 'Debe seleccionar una fecha y hora']"
                />
                <q-input
                    filled
                    v-model="paymentMethodID"
                    label="ID de Método de Pago"
                    hint=" "
                    lazy-rules
                    :rules="[val => !isNaN(val) || 'Debe ser un número']"
                />
                <q-input
                    filled
                    v-model="status"
                    label="Estado"
                    hint="Estado de la Orden"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe escribir un estado']"
                />
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="create">Crear</q-btn>
              <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm"/>
            </div>
          </div>

        </q-card-section>
      </q-card>
    </q-form>
  </q-page>
</template>


<style scoped>

</style>
