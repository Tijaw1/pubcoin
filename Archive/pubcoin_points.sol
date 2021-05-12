pragma solidity ^ 0.5.0;

import "./pubcoin.sol";

contract pubcoin_points {
    address private owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    struct customer {
        address customer_id;
        string first_name;
        string last_name;
        string email;
        bool isReg;
        mapping (address => bool) bus;
    }
    
    struct business {
        address business_id;
        string business_name;
        string email;
        bool isReg;
        pubcoin_points pp;
        mapping(address => bool) cust;
        mapping(address ==> bool) partnership;
        mapping(address ==> uint256) xrate
    }
}

