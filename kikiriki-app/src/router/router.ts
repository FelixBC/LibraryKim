import {createRouter, createWebHashHistory, RouteRecordRaw} from 'vue-router';
import Home from '../components/Home.vue';
import OwnerCreate from "../components/OwnerCreate.vue";
import OwnerList from "../components/OwnerList.vue";
import RoosterCreate from "../components/RoosterCreate.vue";
import RoosterList from "../components/RoosterList.vue";
import TicketCreate from "../components/TicketCreate.vue";
import TicketList from "../components/TicketList.vue";
import UserCreate from "../components/UserCreate.vue";
import UserList from "../components/UserList.vue";

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Home',
        component: Home,
    },
    {
        path: '/userCreate',
        name: 'UserCreate',
        component: UserCreate,
    },
    {
        path: '/userList',
        name: 'UserList',
        component: UserList,
    },
    {
        path: '/ownerCreate',
        name: 'OwnerCreate',
        component: OwnerCreate,
    },
    {
        path: '/ownerList',
        name: 'OwnerList',
        component: OwnerList,
    },
    {
        path: '/roosterCreate',
        name: 'RoosterCreate',
        component: RoosterCreate,
    },
    {
        path: '/roosterList',
        name: 'RoosterList',
        component: RoosterList,
    },
    {
        path: '/ticketCreate',
        name: 'TicketCreate',
        component: TicketCreate,
    },
    {
        path: '/ticketList',
        name: 'TicketList',
        component: TicketList,
    },

];

const router = createRouter({
    history: createWebHashHistory(),
    routes,
});

export default router;
