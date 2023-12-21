# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# Examples:
admin_user = User.create!(email: "admin@admin.com", password: "admin", role_id: User.roles[:admin])
client_user = User.create!(email: "client@client.com", password: "client", role_id: User.roles[:client])

province_1 = Province.create!(name: "Santiago")
province_2 = Province.create!(name: "Puerto Plata")
province_3 = Province.create!(name: "Santo Domingo")
province_4 = Province.create!(name: "La Romana")

city_1 = City.create!(name: "Navarrete", province_id: province_1.id)
city_2 = City.create!(name: "Imbert", province_id: province_2.id)
city_3 = City.create!(name: "Los Rieles", province_id: province_3.id)
city_4 = City.create!(name: "La Romana", province_id: province_4.id)

sector_1 = Sector.create!(name: "Navarrete - S1", city_id: city_1.id)
sector_2 = Sector.create!(name: "Imbert - S1", city_id: city_2.id)
sector_3 = Sector.create!(name: "Los Rieles - S1", city_id: city_3.id)
sector_4 = Sector.create!(name: "La Romana - S1", city_id: city_4.id)

employee_1 = Employee.create!(name: "Juan",
                              identification: "402-2454648-8",
                              phone_number: "809-555-5555",
                              province_id: province_1.id,
                              city_id: city_1.id,
                              sector_id: sector_1.id,
                              street: "Calle 1",
                              birth_date: "1990-01-01",
                              salary: 10000,
                              gender_id: 1
)

employee_2 = Employee.create!(name: "Pedro",
                              identification: "402-2454334-8",
                              phone_number: "809-555-6666",
                              province_id: province_2.id,
                              city_id: city_2.id,
                              sector_id: sector_2.id,
                              street: "Calle 2",
                              birth_date: "1990-01-01",
                              salary: 15000,
                              gender_id: 1
)
employee_3 = Employee.create!(name: "Maria",
                              identification: "402-24543342-3",
                              phone_number: "809-555-3333",
                              province_id: province_3.id,
                              city_id: city_3.id,
                              sector_id: sector_3.id,
                              street: "Calle 3",
                              birth_date: "1990-01-01",
                              salary: 20000,
                              gender_id: 0
)

employee_4 = Employee.create!(name: "Jose",
                              identification: "031-24543342-3",
                              phone_number: "809-555-2222",
                              province_id: province_4.id,
                              city_id: city_4.id,
                              sector_id: sector_4.id,
                              street: "Calle 4",
                              birth_date: "1990-01-01",
                              salary: 25000,
                              gender_id: 2
)

author_1 = Author.create!(name: "J. R. R. Tolkien")
author_2 = Author.create!(name: "George Orwell")
author_3 = Author.create!(name: "Harper Lee")
author_4 = Author.create!(name: "Jane Austen")
author_5 = Author.create!(name: "J.D. Salinger")
author_6 = Author.create!(name: "F. Scott Fitzgerald")
author_7 = Author.create!(name: "Herman Melville")
author_8 = Author.create!(name: "Aldous Huxley")
author_9 = Author.create!(name: "Leo Tolstoy")
author_10 = Author.create!(name: "Charlotte Brontë")
author_11 = Author.create!(name: "Fyodor Dostoevsky")

book_1 = Book.create!(title: "The Lord of the Rings", author: author_1, isbn: "9780544003415", genre_id: 1, quantity: 10, price: 1000, rating: 5, image_url: "https://pictures.abebooks.com/isbn/9780544003415-us.jpg")
book_2 = Book.create!(title: "1984", author: author_2, isbn: "9780451524935", genre_id: 2, quantity: 15, price: 800, rating: 4.5, image_url: "https://149522020.v2.pressablecdn.com/wp-content/uploads/2017/01/2a34d8_a6741e88335241308890543d203ad89dmv2.jpg")
book_3 = Book.create!(title: "To Kill a Mockingbird", author: author_3, isbn: "9780061120084", genre_id: 3, quantity: 12, price: 900, rating: 4.8, image_url: "https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/81gepf1eMqL._AC_UF1000,1000_QL80_.jpg")
book_4 = Book.create!(title: "Pride and Prejudice", author: author_4, isbn: "9780679783268", genre_id: 4, quantity: 7, price: 850, rating: 4.6, image_url: "https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/71Q1tPupKjL._AC_UF1000,1000_QL80_.jpg")
book_5 = Book.create!(title: "The Catcher in the Rye", author: author_5, isbn: "9780316769488", genre_id: 5, quantity: 9, price: 750, rating: 4, image_url: "https://m.media-amazon.com/images/I/91HPG31dTwL._AC_UF1000,1000_QL80_.jpg")
book_6 = Book.create!(title: "The Great Gatsby", author: author_6, isbn: "9780743273565", genre_id: 6, quantity: 8, price: 700, rating: 4.2, image_url: "https://upload.wikimedia.org/wikipedia/commons/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg")
book_7 = Book.create!(title: "Moby Dick", author: author_7, isbn: "9781503280786", genre_id: 7, quantity: 10, price: 950, rating: 4.1, image_url: "https://mpd-biblio-covers.imgix.net/9781466804128.jpg")
book_8 = Book.create!(title: "Brave New World", author: author_8, isbn: "9780060850524", genre_id: 8, quantity: 11, price: 880, rating: 4.3, image_url: "https://upload.wikimedia.org/wikipedia/en/6/62/BraveNewWorld_FirstEdition.jpg")
book_9 = Book.create!(title: "War and Peace", author: author_9, isbn: "9781400079988", genre_id: 9, quantity: 6, price: 1100, rating: 5, image_url: "https://images.penguinrandomhouse.com/cover/9781400079988")
book_10 = Book.create!(title: "Jane Eyre", author: author_10, isbn: "9780141441146", genre_id: 10, quantity: 7, price: 800, rating: 4.4, image_url: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1692725440i/197321006.jpg")
book_11 = Book.create!(title: "Crime and Punishment", author: author_11, isbn: "9780143058144", genre_id: 11, quantity: 5, price: 950, rating: 4.7, image_url: "https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/81EcXiV-9WL._AC_UF1000,1000_QL80_.jpg")
book_12 = Book.create!(title: "Anna Karenina", author: author_9, isbn: "9781853262715", genre_id: 12, quantity: 4, price: 1000, rating: 4.0, image_url: "https://storage.googleapis.com/s4-bucket/citadel/5f6206cf7a179fdaf9b65c2a/d9625f0d-7c24-4d78-84d6-5d59b0a731f8-image.jpg?GoogleAccessId=dragonstone-production@glose-platform.iam.gserviceaccount.com&Expires=32503680000&Signature=D3GFpszEnEgob5iSkKLG6lZH5d6ArZRTfhSDADmG4MtV4FzCsVSDM%2BTKjyhGuYVZor459cJU%2BI%2BZ3c0pxcjRLjtpX08IvqUPfLNOJwn5Tr6guK/pxh2Lox44FskwZSCpqFhoBRR%2Ba%2By6ws99LhsGwMkDEcQxkJKJ1oDbk2DW/nrAFwVqVGkpJpqkq018Btf5DiqzP0E%2BBb1dZJU4absR0Lr/e7e9b0A4meHMd2PeqiSxEGdluNx5CRyXinta50Jr6Nz4kQzKHxGU2ffqlPatFM1JMN5kIjW9uL1D3Ne5pU1lW7ZEEu0qlWlvPiglNAMyJJJe9133KbuJNxz8tYKHkg%3D%3D")

event_1 = Event.create!(name: "Book Fair", event_date: "2021-11-01", description: "Used & New Book Fair!!", image_url: "https://www.shutterstock.com/shutterstock/photos/2229060415/display_1500/stock-vector-abstract-modern-business-conference-design-template-with-creative-round-lines-minimal-flyer-layout-2229060415.jpg", capacity: 10)
event_2 = Event.create!(name: "Template Concert Fair", event_date: "2021-11-02", description: "Free Random book Fair!", image_url: "https://img.freepik.com/free-psd/banner-template-concert_23-2148403186.jpg", capacity: 30)
event_3 = Event.create!(name: "Author Book Signing Event", event_date: "2021-11-03", description: "Used & New Book Fair!!", image_url: "https://img.freepik.com/free-psd/author-book-signing-event-banner-template_23-2148646050.jpg?w=2000", capacity: 15)
event_4 = Event.create!(name: "Book Fair", event_date: "2021-11-04", description: "Used & New Book Fair!!", image_url: "https://img.freepik.com/free-psd/music-festival-horizontal-banner-template_23-2149819155.jpg?size=626&ext=jpg&ga=GA1.1.1803636316.1701129600&semt=ais", capacity: 50)
event_5 = Event.create!(name: "Book clubs & Reading Events", event_date: "2021-11-02", description: "Free Random book Fair!", image_url: "https://friscolibrary.bibliocommons.com/events/uploads/images/full/64904af60ebad60b30a5cda4244c279b/Event%20Banner%20Book%20Clubs%20&%20Reading%20Events%20760x230.jpg", capacity: 25)
event_6 = Event.create!(name: "Inspired Readers Festival", event_date: "2021-11-03", description: "Used & New Book Fair!!", image_url: "https://cdn.filestackcontent.com/compress/output=format:jpg/cache=expiry:max/resize=width:1600/Gse2jV9PRSZ0nyLQCTAK", capacity: 50)

reservation_1 = Reservation.create!(client: client_user, event: event_1, status_id: Reservation.statuses[:Pendiente])
reservation_2 = Reservation.create!(client: client_user, event: event_1, status_id: Reservation.statuses[:Aprovada])
reservation_3 = Reservation.create!(client: client_user, event: event_1, status_id: Reservation.statuses[:Aprovada])
reservation_4 = Reservation.create!(client: client_user, event: event_1, status_id: Reservation.statuses[:Aprovada])
reservation_5 = Reservation.create!(client: client_user, event: event_1, status_id: Reservation.statuses[:Cancelada])
reservation_6 = Reservation.create!(client: client_user, event: event_2, status_id: Reservation.statuses[:Pendiente])
reservation_7 = Reservation.create!(client: client_user, event: event_3, status_id: Reservation.statuses[:Aprovada])
reservation_8 = Reservation.create!(client: client_user, event: event_3, status_id: Reservation.statuses[:Aprovada])
reservation_9 = Reservation.create!(client: client_user, event: event_4, status_id: Reservation.statuses[:Aprovada])
reservation_10 = Reservation.create!(client: client_user, event: event_4, status_id: Reservation.statuses[:Cancelada])

book_checkout_1 = BookCheckout.create!(client: client_user, book: book_1, status_id: BookCheckout.statuses[:Prestado])
book_checkout_2 = BookCheckout.create!(client: client_user, book: book_1, status_id: BookCheckout.statuses[:Devuelto])
book_checkout_3 = BookCheckout.create!(client: client_user, book: book_1, status_id: BookCheckout.statuses[:Prestado])
book_checkout_4 = BookCheckout.create!(client: client_user, book: book_1, status_id: BookCheckout.statuses[:Devuelto])
book_checkout_5 = BookCheckout.create!(client: client_user, book: book_1, status_id: BookCheckout.statuses[:Prestado])
book_checkout_6 = BookCheckout.create!(client: client_user, book: book_2, status_id: BookCheckout.statuses[:Prestado])
book_checkout_7 = BookCheckout.create!(client: client_user, book: book_3, status_id: BookCheckout.statuses[:Devuelto])
book_checkout_8 = BookCheckout.create!(client: client_user, book: book_3, status_id: BookCheckout.statuses[:Prestado])
book_checkout_9 = BookCheckout.create!(client: client_user, book: book_4, status_id: BookCheckout.statuses[:Devuelto])
book_checkout_10 = BookCheckout.create!(client: client_user, book: book_4, status_id: BookCheckout.statuses[:Devuelto])
