
// ①　JSを動かす記述
// ②　価格を入力するHTMLのクラスかIDを変数Aに入れる
// ③　上記で入れた変数Aに対してのトリガーを書く
// ④　②の中で入力された値を取り出して変数Bに入れる
// ⑤　変数Bに対して計算し変数C,Dに入れる（出品手数料Cと利益D）
// ⑥　手数料部分には変数Cをインサート
// ⑦　利益部分に変数Dをインサート


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