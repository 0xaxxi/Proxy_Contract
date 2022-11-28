//SPDX-License-Identifier:Unlicensed
pragma solidity 0.5.2;

import './Storage.sol';

contract Proxy is Storage{
  address currentAddress;

  constructor(address _currentAddress) public{
    currentAddress = _currentAddress;
  }
  function upgrade(address _newAddress) public {
    currentAddress = _newAddress;
  }

  //Fallback fu nction
  function () payable external{
    //redirect to currentaddress
    address implementation = currentAddress;//where are making this call
    require(currentAddress != address(0));
    //msg.data is all information about the function call
    bytes memory data = msg.data;

    //assembly code
    assembly{
      let result := delegatecall(gas, implementation, add(data, 0x20), mload(data), 0, 0)
      let size := returndatasize
      let ptr := mload(0x40)
      returndatacopy(ptr, 0, size)
      switch result
      case 0 {revert(ptr, size)}
      default {return(ptr, size)}
    }
  }
}
