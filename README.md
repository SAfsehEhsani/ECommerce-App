
# Ecommerce Flutter App

A clean, responsive, and dynamic **Ecommerce mobile application** built using **Flutter**, featuring splash/login screens, category-wise product display, product details, cart, and wishlist. 
It uses real-time product data from the **Fake Store API**.

---
## APK FILE: https://drive.google.com/file/d/1tfgRx-XFt2f-YoKKSsY8XVrLnuqsVfKM/view?usp=sharing

## App Features

-  Splash screen with animation  
-  Login screen with validation  
-  Dashboard with category-wise product display  
-  Product details page  
-  Add to cart and wishlist  
-  Edit/delete cart items   
-  Named route navigation  
-  Responsive UI  
-  Error handling for API failures

---

##  Tools & Technologies Used

| Tool/Package             |                 Usage                      |
|--------------------------|--------------------------------------------|
| **Flutter & Dart**       |        Mobile app framework                |
| `provider`               |    State management (cart/wishlist)        |
| `http`                   |      Fetching data from API                |
| `flutter_launcher_icons` |         Custom app icon                    |
| **Fake Store API**       |    Free REST API for products/categories   |

---

##  Screens

- Splash Screen  
- Login Screen  
- Category Dashboard  
- Product Listing  
- Product Details  
- Cart Screen  
- Wishlist Screen

---

##  API

**Fake Store API**  
📎 https://fakestoreapi.com/  
Provides real-time product data, categories, and individual product details.

---

## 🔎 How It Works

1. App starts with a splash screen animation.
2. On login screen, user enters email/password (simulated).
3. Dashboard shows categories (fetched from API).
4. On tapping a category, product list is displayed.
5. Each product can be viewed in detail.
6. User can:
   - Add items to cart
   - Increase/decrease quantity
   - Remove items
   - Add/remove from wishlist
7. Cart shows subtotal + promo code input (non-functional demo).
8. Navigation uses **named routes**.
9. All state updates use **Provider**.

---

## Functions used

| Function                     |           Description                     |
|------------------------------|-------------------------------------------|
| `fetchCategories()`          | Fetch all categories from API             |
| `fetchProductsByCategory()`  | Fetch products under a category           |
| `addToCart(product)`         | Add product to cart                       |
| `removeFromCart(product)`    | Remove product from cart                  |
| `updateQuantity(product)`    | Increment/decrement quantity              |
| `toggleWishlist(product)`    | Add/remove product from wishlist          |
| `totalPrice()`               | Calculates subtotal for cart items        |


## Developer : Syed Afseh Ehsani
