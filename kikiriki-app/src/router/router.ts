import {createRouter, createWebHashHistory, RouteRecordRaw} from 'vue-router';
import Home from '../components/Home.vue';
import About from '../components/About.vue';
import Registration from "../components/Registration.vue";

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Home',
        component: Home,
    },
    {
        path: '/about',
        name: 'About',
        component: About,
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
