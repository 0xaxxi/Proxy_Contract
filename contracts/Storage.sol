//SPDX-License-Identifier:Unlicensed
pragma solidity 0.5.2;

contract Storage{
  mapping (string => uint256) _uintStorage;
  mapping (string => address) _addressStorage;
  mapping (string => bool) _boolStorage;
  mapping (string => bytes4) _bytes4Storage;
  mapping (string => string) _stringStorage;
  address public owner;
  bool public _initialized;
}