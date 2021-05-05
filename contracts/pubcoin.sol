pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract pubcoin is ERC20, ERC20Mintable {

	///PubCoin programs
	address private owner;
	string private name;
	string private symbol;
	uint8 private decimal;

	//the creator of the contarct is the owner
	constructor(
	    address _owner,
	    string memory _name,
	    string memory _symbol,
	    uint8 _decimal
	    )public
	{
		owner = _owner;
		name = _name;
		symbol = _symbol;
		decimal = _decimal;
	}
}