//SPDX-License-Identifier:Unlicensed
pragma solidity 0.5.2;

import './Storage.sol';

contract Dogs is Storage {
  modifier onlyOwner(){
    require(msg.sender == owner);
    _;
  }
  constructor() public{
    owner = msg.sender;
  }
  function getNumberofDogs() public view returns (uint256){
    return _uintStorage["Dogs"];
  }
  function setNumberofDogs(uint256 toSet) public {
    _uintStorage["Dogs"] = toSet;
  }

}