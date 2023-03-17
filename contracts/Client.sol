// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./utility/Structures.sol";
// import "hardhat/console.sol";

contract ClientContract {
    address [2]addrs;
    mapping (address => Client) clients;

    constructor() {
        addrs[0] = msg.sender;
    }

    function setContractAddress(address contract_address) external {
        require(msg.sender == addrs[0], "Unauth Access");
        addrs[1] = contract_address;
    }
}
