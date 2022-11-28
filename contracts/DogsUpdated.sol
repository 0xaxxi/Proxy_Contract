//SPDX-License-Identifier:Unlicensed
pragma solidity 0.5.2;

import './Storage.sol';

contract DogsUpdated is Storage {
  modifier onlyOwner(){
    require(msg.sender == owner);
    _;
  }
  
  constructor() public{
    initialize(msg.sender);
  }
  function initialize(address _owner) public {
    require(!_initialized);
    owner = _owner;
    _initialized = true;
  }
  function getNumberofDogs() public view returns (uint256){
    return _uintStorage["Dogs"];
  }
  function setNumberofDogs(uint256 toSet) public onlyOwner {
    _uintStorage["Dogs"] = toSet;
  }

}