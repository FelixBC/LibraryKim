import {createRouter, createWebHashHistory, RouteRecordRaw} from 'vue-router';

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Login',
        component: () => import('../components/Login.vue'),
    },
    {
        path: '/userCreate',
        name: 'UserCreate',
        component: () => import('../components/UserCreate.vue'),
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
                path: '/roleCreate',
                name: 'RoleCreate',
                component: () => import('../components/RoleCreate.vue'),
            },
            {
                path: '/roleList',
                name: 'RoleList',
                component: () => import('../components/RoleList.vue'),
            },
            {
                path: '/authorCreate',
                name: 'AuthorCreate',
                component: () => import('../components/AuthorCreate.vue'),
            },
            {
                path: '/authorList',
                name: 'AuthorList',
                component: () => import('../components/AuthorList.vue'),
            },

            {
                path: '/genderCreate',
                name: 'GenderCreate',
                component: () => import('../components/GenderCreate.vue'),
            },
            {
                path: '/genderList',
                name: 'GenderList',
                component: () => import('../components/GenderList.vue'),
            },

        ]

    }

];


const router = createRouter({
    history: createWebHashHistory(),
    routes,
});

export default router;
