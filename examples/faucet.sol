pragma solidity ^0.4.20;

contract Faucet{
    address owner;
    uint256 sendAmount;
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    modifier hasEnoughBalance (uint256 value){
        require (this.balance>=value);
        _;
    }
    
    function Faucet () public{
        owner = msg.sender;
        sendAmount = 1 ether;
    }
    
    function() public payable{
        
    }
    
    function getContractBalance() public view returns(uint256){
        return this.balance;
    }
    
    function changeSendAmount(uint256 newValue) public onlyOwner{
        sendAmount = newValue;
    }
    
    function withdrawSender() public hasEnoughBalance(sendAmount){
        msg.sender.transfer(sendAmount);
        
    }
    
    function sendFromSenderToSomeone (address target) public hasEnoughBalance(sendAmount){
        target.transfer(sendAmount);
    }
    
    function withdrawOwner(uint256 value) public onlyOwner hasEnoughBalance(value){
        owner.transfer(value);
        
    }
    
    function destroy () public onlyOwner{
        selfdestruct(owner);
    }
}