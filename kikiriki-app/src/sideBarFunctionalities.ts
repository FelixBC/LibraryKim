/*==================== SHOW NAVBAR ====================*/
const showMenu = (headerToggle: string, navbarId: string): void => {
    const toggleBtn: HTMLElement | null = document.getElementById(headerToggle);
    const nav: HTMLElement | null = document.getElementById(navbarId);

    // Validate that variables exist
    if (toggleBtn && nav) {
        toggleBtn.addEventListener('click', (): void => {
            // We add the show-menu class to the div tag with the nav__menu class
            nav.classList.toggle('show-menu');
            // change icon
            toggleBtn.classList.toggle('bx-x');
        });
    }
};

showMenu('header-toggle', 'navbar');

/*==================== LINK ACTIVE ====================*/
const linkColor: NodeListOf<Element> = document.querySelectorAll('.nav__link');

function colorLink(): void {
    linkColor.forEach((l: Element): void => l.classList.remove('active'));
    this.classList.add('active');
}

linkColor.forEach((l: Element): void => l.addEventListener('click', colorLink));
