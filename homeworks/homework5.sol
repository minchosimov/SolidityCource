pragma solidity ^0.4.20;

contract Service {
    uint sercviceCost;
    address owner;
    uint lastBuy;
    uint lastWithdraw;
    
    event BuySevice (address indexed buyer, uint timestamp);
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    modifier lockServiceForBuy{
        require(now >= lastBuy + 2 minutes);
        _;
    }
    
    modifier lockServiceForWithdraw{
        require(now >= lastWithdraw + 1 hours);
        _;
    }
    
    function Service() public{
        owner = msg.sender;
        sercviceCost = 1 ether;
        lastBuy = 0;
        lastWithdraw = 0;
    }
    
    function buyService() public payable lockServiceForBuy{
        require (msg.value >= sercviceCost);
        
        lastBuy = now;
        BuySevice (msg.sender,lastBuy);
        
        uint overPayment = msg.value - sercviceCost;
        
        if (overPayment > 0){
            msg.sender.transfer(overPayment);
        }
        
    }
    
    function withdrawByOwner (uint value) public onlyOwner lockServiceForWithdraw{
        require (value <= 5 ether);
        require (value <= this.balance);
        
        lastWithdraw = now;
        
        owner.transfer(value);
    }
    
    
    
}