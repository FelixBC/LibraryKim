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
            {
                path: '/employeeCreate',
                name: 'EmployeeCreate',
                component: () => import('../components/EmployeeCreate.vue'),
            },
            {
                path: '/employeeList',
                name: 'EmployeeList',
                component: () => import('../components/EmployeeList.vue'),
            },
            {
                path: '/cityCreate',
                name: 'CityCreate',
                component: () => import('../components/CityCreate.vue'),
            },
            {
                path: '/cityList',
                name: 'CityList',
                component: () => import('../components/CityList.vue'),
            },
            {
                path: '/provinceCreate',
                name: 'ProvinceCreate',
                component: () => import('../components/ProvinceCreate.vue'),
            },
            {
                path: '/provinceList',
                name: 'ProvinceList',
                component: () => import('../components/ProvinceList.vue'),
            },
            {
                path: '/sectorCreate',
                name: 'SectorCreate',
                component: () => import('../components/SectorCreate.vue'),
            },
            {
                path: '/sectorList',
                name: 'SectorList',
                component: () => import('../components/SectorList.vue'),
            },

        ]

    }

];


const router = createRouter({
    history: createWebHashHistory(),
    routes,
});

export default router;
