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
        path: '/mainUserLayout',
        name: 'MainUserLayout',
        component: () => import('../components/MainUserLayout.vue'),
        children: [
            {
                path: '/recommendations',
                name: 'Recommendation',
                component: () => import('../components/Recommendations.vue'),
            }
        ]
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
                path: '/users',
                name: 'UserList',
                component: () => import('../components/UserList.vue'),
            },
            {
                path: '/users/create',
                name: 'UserCreate',
                component: () => import('../components/UserCreate.vue'),
            },
            {
                path: '/employees',
                name: 'EmployeeList',
                component: () => import('../components/EmployeeList.vue'),
            },
            {
                path: '/employees/create',
                name: 'EmployeeCreate',
                component: () => import('../components/EmployeeCreate.vue'),
            },
            {
                path: '/provinces',
                name: 'ProvinceList',
                component: () => import('../components/ProvinceList.vue'),
            },
            {
                path: '/provinces/create',
                name: 'ProvinceCreate',
                component: () => import('../components/ProvinceCreate.vue'),
            },
            {
                path: '/cities',
                name: 'CityList',
                component: () => import('../components/CityList.vue'),
            },
            {
                path: '/cities/create',
                name: 'CityCreate',
                component: () => import('../components/CityCreate.vue'),
            },
            {
                path: '/sectors/create',
                name: 'SectorCreate',
                component: () => import('../components/SectorCreate.vue'),
            },
            {
                path: '/sectors',
                name: 'SectorList',
                component: () => import('../components/SectorList.vue'),
            },
            {
                path: '/books',
                name: 'BookList',
                component: () => import('../components/BookList.vue'),
            },
            {
                path: '/books/create',
                name: 'BookCreate',
                component: () => import('../components/BookCreate.vue'),
            },
            {
                path: '/authors',
                name: 'AuthorList',
                component: () => import('../components/AuthorList.vue'),
            },
            {
                path: '/authors/create',
                name: 'AuthorCreate',
                component: () => import('../components/AuthorCreate.vue'),
            },
            {
                path: '/productCreate',
                name: 'ProductCreate',
                component: () => import('../components/ProductCreate.vue'),
            },
            {
                path: '/reservationSpaceCreate',
                name: 'ReservationSpaceCreate',
                component: () => import('../components/ReservationSpaceCreate.vue'),
            },
            {
                path: '/reservationSpaceList',
                name: 'ReservationSpaceList',
                component: () => import('../components/ReservationSpaceList.vue'),
            },
            {
                path: '/eventCreate',
                name: 'EventCreate',
                component: () => import('../components/EventCreate.vue'),
            },
            {
                path: '/eventList',
                name: 'EventList',
                component: () => import('../components/EventList.vue'),
            },
            {
                path: '/reservationCreate',
                name: 'ReservationCreate',
                component: () => import('../components/ReservationCreate.vue'),
            },
            {
                path: '/reservationList',
                name: 'ReservationList',
                component: () => import('../components/ReservationList.vue'),
            },
            {
                path: '/orderCreate',
                name: 'OrderCreate',
                component: () => import('../components/OrderCreate.vue'),
            },
            {
                path: '/orderList',
                name: 'OrderList',
                component: () => import('../components/OrderList.vue'),
            }
        ]

    }
];


const router = createRouter({
    history: createWebHashHistory(),
    routes,
});

export default router;
