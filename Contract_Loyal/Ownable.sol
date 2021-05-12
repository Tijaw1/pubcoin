
pragma solidity >=0.5.8;

import './PointsTokenStorage.sol';
//import './Pubcoin_Points.sol';

/**
 * Title Ownable
 * This contract has an owner address providing basic authorization control
 */
contract Ownable is PointsTokenStorage {
  /**
   * Event to show ownership has been transferred
   */
  event OwnershipTransferred(address previousOwner, address newOwner);

  /**
   * Throws error if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner(), "Only owner has the right");
    _;
  }

  /**
   * Returns the address of the owner
   */
  function owner() public view returns (address) {
    return addressStorage[keccak256("owner")];
  }

  /**
   * Allows the current owner to transfer control of the contract to a newOwner.
   * newOwner the address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0), "Empty owner is not allowed");
    setOwner(newOwner);
  }

  /**
   * Sets a new owner address
   */
  function setOwner(address newOwner) internal {
    emit OwnershipTransferred(owner(), newOwner);
    addressStorage[keccak256("owner")] = newOwner;
  }
}