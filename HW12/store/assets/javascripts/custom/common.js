window.addEventListener('DOMContentLoaded', () => {
  const domainUrl = `${window.location.origin}`

  function getCart() {
    const cartUrl = `${domainUrl}/carts/1`
    const cartTotal = document.querySelector('.cart-button .total');
    const cartList = document.querySelector('.cart-list');

    fetch(cartUrl, {
      headers: {
        method: 'POST',
        'Content-Type': 'application/json'
      },
    })
      .then((response) => {
        console.log('response: ', response);


        response.json()
      })
      .then((data) => {
        const products = data.products;

        const totalProducts =  products.map(item => item.quantity).reduce((accumulator, currValue) => accumulator + currValue, 0);

        if (products.length) {
          cartList.textContent = '';
  
          products.forEach(item => {
            let product = item.product;

            const listProduct = 
            `<li>
              ${product.name}
              <div class="d-flex">
                <img src="${product.image}" width="50" alt="${product.name}">
                <div>x ${item.quantity}</div>
                <div>$ ${product.price * item.quantity}</div>
              </div>
            </li>`
  
            cartList.insertAdjacentHTML('afterBegin', listProduct);
          });
  
          cartTotal.textContent = totalProducts;
        } else {
          const emptyList = `<li>Empry cart</li>`

          cartList.insertAdjacentHTML('afterBegin', emptyList);
        }
    })
  
  }
  
  // getCart();

  const addProductToCart = (event) => {
    const target = event.target;

    if (target.classList.contains('add-to-cart')) {
      event.preventDefault();

      const action = target.parentElement.action;

      fetch(`${action}`, {
        method: 'POST',
        'Content-Type': 'application/json'
      })
      .then((response) => {
          getCart();
      } );
    }
  }

  // document.addEventListener('click', addProductToCart)
})
