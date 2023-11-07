import {createRouter, createWebHashHistory, RouteRecordRaw} from 'vue-router';

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Login',
        component: () => import('../components/Login.vue'),
    },
    {
        path: '/mainLayout',
        name: 'MainLayout',
        component: () => import('../components/MainLayout.vue'),
        children: [
            {
                path: '/dashboard',
                name: 'home ',
                component: () => import('../components/Home.vue'),
            },
            {
                path: '/userCreate',
                name: 'UserCreate',
                component: () => import('../components/UserCreate.vue'),
            },
            {
                path: '/userList',
                name: 'UserList',
                component: () => import('../components/UserList.vue'),
            },
            {
                path: '/ownerCreate',
                name: 'OwnerCreate',
                component: () => import('../components/OwnerCreate.vue'),
            },
            {
                path: '/ownerList',
                name: 'OwnerList',
                component: () => import('../components/OwnerList.vue'),
            },
            {
                path: '/roosterCreate',
                name: 'RoosterCreate',
                component: () => import('../components/RoosterCreate.vue'),
            },
            {
                path: '/roosterList',
                name: 'RoosterList',
                component: () => import('../components/RoosterList.vue'),
            },
            {
                path: '/ticketCreate',
                name: 'TicketCreate',
                component: () => import('../components/TicketCreate.vue'),
            },
            {
                path: '/ticketList',
                name: 'TicketList',
                component: () => import('../components/TicketList.vue'),
            },
            {
                path: '/colorCreate',
                name: 'ColorCreate',
                component: () => import('../components/ColorCreate.vue'),
            },
            {
                path: '/colorList',
                name: 'ColorList',
                component: () => import('../components/ColorList.vue'),
            },
        ]

    }

];


const router = createRouter({
    history: createWebHashHistory(),
    routes,
});

export default router;
