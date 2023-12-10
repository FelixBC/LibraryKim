import {date} from "quasar";

export interface Author {
    id: number;
    name: string;
}

export interface Employee {
    id: number;
    name: string;
    role: string;
    identification: string;
    sector: string;
    province: string;
    city: string;
    address: string;
    birthdate: date;
    gender: number;
    phoneNumber: string;
    email: number;
}

export interface Email {
    id: number;
    email: string;
}

export interface Phone {
    id: number;
    phoneNumber: string;
}

export interface Province {
    id: number;
    name: string;
}

export interface City {
    id: number;
    name: string;
}

export interface Sector {
    id: number;
    name: string;
}

export interface Identification {
    id: number;
    name: string;
}

export interface Address {
    id: number;

}


export interface User {
    id: number;
    idRole: number;
    name: string;
    password: string;
    ID_Contact: number;
}

export interface Role {
    id: number;
    name: string;
}

export interface Contact {
    id: number;
    ID_email: number;
}

export interface Gender {
    id: number;
    name: string;
}

export interface SupplierType {
    id: number;
    name: string;
}