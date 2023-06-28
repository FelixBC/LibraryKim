
export interface Owner {

    id: number;
    name: string;
    lastName: string;
    age: number;
    city: string;
    phone: number;
    identificationNumber: number;
    wins: number;
    loses: number;

}

interface  DropdownItem {
    id: number;
    name: string;
}
export interface Rooster {
    id: number;
    name: string;
    breedId: number;
    color: string;
    wins: number;
    loses: number;
    strength: number;
    resistance: number;
    agility: number;
    defence: number;
    roosterOwnerId: number;

}
