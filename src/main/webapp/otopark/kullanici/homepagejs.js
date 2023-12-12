/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function harfKontrolu(event) {
    const inputValue = event.target.value.toUpperCase(); // Girilen değeri büyük harfe çevir

    // İngiliz alfabesindeki harfleri kontrol et
    const regex = /^[A-Z]{1,3}$/;
    const isValid = regex.test(inputValue);

    if (!isValid || inputValue.includes('Q') || inputValue.includes('W') || inputValue.includes('X')) {
        alert('Lütfen plakada geçerli harfler girin!');
        event.target.value = ''; // Geçersiz girişi temizle
    }
}
function checkInput() {
    let inputElement = document.getElementById('numberPlaka');
    let inputValue = inputElement.value;

    // İki haneli olup olmadığını kontrol et
    if (inputValue.length === 1) {
        inputValue = '0' + inputValue; // Tek haneli ise başına 0 ekleyerek iki haneli yap
        inputElement.value = inputValue;
    } else if (inputValue.length !== 2) {
        alert('Lütfen geçerli bir plaka girin.');
        return false; // Formun gönderilmesini engelle
    }

    let inputElement2 = document.getElementById('formattedPlaka');
    let inputValue2 = inputElement2.value;
    if (inputValue2.length > 4) {
        alert('Lütfen geçerli bir plaka girin.');
        return false;
    }
    return true;
}