// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./utility/Structures.sol";
import "./utility/Interfaces.sol";

// import "hardhat/console.sol";

contract OAuth3 is OAuth3Inter {
    address[2] addrs;
    mapping(address => User) users;
    idPair[] userList;
    uint256 totalUsers;

    constructor() {
        addrs[0] = msg.sender;
    }

    function setContractAddress(address contract_address) external {
        require(msg.sender == addrs[0], "Unauth Access");
        addrs[1] = contract_address;
    }

    modifier onlyOwner() {
        require(msg.sender == addrs[0], "Only Owner Allowed");
        _;
    }

    function isUser() external view returns (bool res) {
        if (msg.sender == users[msg.sender].id) res = true;
        else res = false;
    }

    modifier ownerOrUser() {
        require(
            msg.sender == addrs[0] || msg.sender == users[msg.sender].id,
            "Neither owner nor user"
        );
        _;
    }

    function addUser(string memory uid) external {
        User storage user = users[msg.sender];
        require(msg.sender != users[msg.sender].id, "Account Already Exists");
        user.id = msg.sender;
        user.uid = uid;
        user.reg_date = block.timestamp;
        user.is_active = true;
        userList[totalUsers].id = msg.sender;
        userList[totalUsers].uid = uid;
        totalUsers++;
    }

    function getUser(
        address id
    )
        external
        view
        ownerOrUser
        returns (string memory uid, uint256 reg_date, bool is_active)
    {
        User storage user = users[id];
        uid = user.uid;
        reg_date = user.reg_date;
        is_active = user.is_active;
    }

    function addAadhaar(Aadhaar memory aadhaar) external {
        require(msg.sender == users[msg.sender].id, "Account doesn't exists");
        users[msg.sender].aadhaar = aadhaar;
    }

    function readAadhaar(
        address id
    ) external view ownerOrUser returns (Aadhaar memory aadhaar) {
        aadhaar = users[id].aadhaar;
    }
}
