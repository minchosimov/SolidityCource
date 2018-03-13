pragma solidity ^0.4.20;

contract Enum_test{
    enum States {locked,unlocked,restricted}
    States public state;
    
    address owner;
    
    struct Users{
        address id;
        uint counter;
        uint timestamp;
    }
    Users public user;
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    modifier accessAllow{
        if (state == States.unlocked){
           _; 
        } else{
            if (state == States.restricted){
                require(msg.sender == owner);
                _;
            }
        }
    }
    
    function Enum_test() public{
        owner = msg.sender;
        state = States.unlocked;
    }
    
    function changeStateByOwner(States e) public onlyOwner{
        state = e;
    }
    
    function () payable public accessAllow{
        
    }
    
    function count() public accessAllow{
        user.id = msg.sender;
        user.counter ++;
        user.timestamp = now;
    }
    
}