import {createRouter, createWebHashHistory, RouteRecordRaw} from 'vue-router';
import Home from '../components/Home.vue';
import Registration from "../components/Registration.vue";
import People from "../components/People.vue";

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Home',
        component: Home,
    },
    {
        path: '/people',
        name: 'People',
        component: People,
    },
    {
        path: '/registration',
        name: 'Registration',
        component: Registration,
    },
];

const router = createRouter({
    history: createWebHashHistory(),
    routes,
});

export default router;
