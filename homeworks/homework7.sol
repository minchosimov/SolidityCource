pragma solidity ^0.4.20;

library SafeMath {
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        //there is no case where this function can overflow/underflow
        uint256 c = a / b;
        return c;
    }
    
    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract Ownable{
    address public owner;
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    function Ownable() public{
        owner = msg.sender;
    }
}

contract Destructuble is Ownable{
    function destroy() public onlyOwner{
        selfdestruct(owner);
    }
}
library members{
    
    using SafeMath for uint;
    struct DataMembers{
        address memberAdr;
        uint donateSum;
        uint timeLastDonate;
        uint lastDonate;
    }
    
    function initialize (DataMembers strorage selft, address member) public{
        
        
    }
    
    
}