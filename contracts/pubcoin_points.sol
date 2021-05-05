pragma solidity ^ 0.5.0;

import "./pubcoin.sol";

contract pubcoin_points {
    address private owner;
    
    constructor() public {
        owner = msg.sender;
    }
}

