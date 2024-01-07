// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

  // Attach event listeners to the increment and decrement buttons
 // app/assets/javascripts/application.js
document.addEventListener('DOMContentLoaded', function() {
    const toggleCartButton = document.getElementById('toggle-cart');
    const cartSidebar = document.getElementById('cart-sidebar');
  
    toggleCartButton.addEventListener('click', function() {
      cartSidebar.classList.toggle('open');
    });
  });
  