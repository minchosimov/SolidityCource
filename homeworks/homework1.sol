pragma solidity ^0.4.20;

contract Mathematic{
    
    int number1 = 0;
    
    function add(int256 number2){
        number1 +=number2;
    }
    
    function substract(int256 number2){
        number1-=number2;
    }
    
    function multiply (int256 number2){
        number1*=number2;
    }
    
    function divide (int256 number2){
        number1/=number2;
    }
    
    function  power (uint56 number2){
        number1=uint56(number1)**number2;
    }
    
    function remainder (int256 number2){
        number1 = number1%number2;
    }
    
    function getState () returns (int256){
        return (number1);
    }
    
    function  resetNumer1 (){
        number1 = 0;
    }
    
}