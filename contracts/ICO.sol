pragma solidity >=0.4.22 <0.8.0;
// SPDX-License-Identifier: MIT

import "./LIHKGCOIN.sol";

contract ICO {


     LIHKGCOIN lihkgc;

    constructor(LIHKGCOIN _lihkgcoin) public
  {
      lihkgc = _lihkgcoin;
      owner = msg.sender;  
  }

    string public name = "LIHKGC ICO";
    address public owner;

    // Receive ETH

    // Send LIHKGC according to remaining LIHKGC in ICO contract

}