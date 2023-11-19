export interface Author {
    id: number;
    name: string;
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