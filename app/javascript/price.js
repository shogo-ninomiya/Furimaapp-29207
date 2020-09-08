function price(){
  const priceInput = document.getElementById("item-price");
  const tax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  priceInput.addEventListener('keyup', () => {
    const value = priceInput.value;
      if (value >= 300 && value <= 9999999){
        let fee = Math.floor(value * 0.1)
        let gains = Math.floor(value - fee)
        tax.textContent = fee;
        profit.textContent = gains;
      } else {
        let fee = '-';
        let gains = '-';
        tax.textContent = fee;
        profit.textContent = gains;
      }
    });
}
window.addEventListener('load', price);